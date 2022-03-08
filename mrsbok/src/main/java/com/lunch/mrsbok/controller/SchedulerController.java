package com.lunch.mason.controller;

import com.lunch.mason.domain.StoreVO;
import com.lunch.mason.domain.StoreRandomVO;
import com.lunch.mason.mapper.LunchMapperInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

@Component
public class SchedulerController {
	
	Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	private final LunchMapperInterface lunchMapperInterface;
	public SchedulerController(LunchMapperInterface lunchMapperInterface) {
		this.lunchMapperInterface = lunchMapperInterface;
	}
	
	// 월~금 10시20분에 실행
	// 선택된 식당 있으면 선택된 식당중 랜덤 선택
	// 선택된 식당 없으면 기존 DB에 있는 식당중 랜덤 선택
	@Scheduled(cron = "0 20 10 * * MON-FRI")
	public void randomStore() throws Exception {
		logger.info("cron 시작");
		String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
		List<StoreRandomVO> OfficeAList = lunchMapperInterface.getStoreListOfficeAForRandom(today);
		List<StoreRandomVO> officeBList = lunchMapperInterface.getStoreListOfficeBForRandom(today);
		Random random = new Random();
		// 돌림판 돌리기
		if(!officeBList.isEmpty()){ // 사용자가 정한메뉴가 있을때
			// B 사무실 랜덤 식당 디비에 넣기
			lunchMapperInterface.insertDailyStoreOfficeB(officeBList.get(random.nextInt(officeBList.size())).getStorePicked(), today);
			logger.info("cron 식당선택있음 사무실B");
		} else { // 사용자가 정한 메뉴가 없을때
			// 전체 식당 메뉴 들고 오고
			List<StoreVO> list = lunchMapperInterface.getStore();
			// B 사무실 랜덤 식당 디비에 넣기
			lunchMapperInterface.insertDailyStoreOfficeB(list.get(random.nextInt(list.size())).getStore(),today);
			logger.info("cron 식당선택없음 사무실B");
		}
		if(!OfficeAList.isEmpty()){ // 사용자가 정한메뉴가 있을때
			// A 사무실 랜덤 식당 디비에 넣기
			lunchMapperInterface.insertDailyStoreOfficeA(OfficeAList.get(random.nextInt(OfficeAList.size())).getStorePicked(),today);
			logger.info("cron 식당선택있음 사무실A");
		} else { // 사용자가 정한 메뉴가 없을때
			// 전체 식당 메뉴 들고 오고
			List<StoreVO> list = lunchMapperInterface.getStore();
			// A 사무실 랜덤 식당 디비에 넣기
			lunchMapperInterface.insertDailyStoreOfficeA(list.get(random.nextInt(list.size())).getStore(),today);
			logger.info("cron 식당선택없음 사무실A");
		}
		
		logger.info("cron 식당 DB에 넣음 사무실A");
	}
}
