package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class SchedulerController {
	
	Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	private final LunchService lunchService;
	private final LunchMapperInterface lunchMapperInterface;
	public SchedulerController(LunchService lunchService,
	                           LunchMapperInterface lunchMapperInterface) {
		this.lunchService = lunchService;
		this.lunchMapperInterface = lunchMapperInterface;
	}
	// 시간 들으 가는가 TEST
	//@Scheduled(cron = "*/1 * * * * *")
	/*
	public void datePrintTest() {
		LocalDateTime now = LocalDateTime.now();
		System.out.println("now : " + now);
	}
	*/
	// 시간 테스트 format 사용
	//@Scheduled(cron = "*/1 * 13 * * *")
	/*
	public void datePrintTest() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
		String today = now.format(formatter); // 01-04 양식으로 날짜 String 변수에 넣음
	}
	*/
	@Scheduled(cron = "0 20 10 * * MON-FRI")
	public void randomStore() throws Exception {
		String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
		List<StoreRandomVO> bokList = lunchMapperInterface.getStoreListBokForRandom(today);
		List<StoreRandomVO> theList = lunchMapperInterface.getStoreListTheForRandom(today);
		logger.info("@@ bokList -> " + bokList);
		logger.info("@@ bokList -> " + theList);
		Random random = new Random();
		String bokStore;
		String theStore;
		// 돌림판 돌리기
		if(!theList.isEmpty()){ // 사용자가 정한메뉴가 있을때
			// 돌림판 돌리고
			theStore = theList.get(random.nextInt(theList.size())).getStorePicked();
		} else { // 사용자가 정한 메뉴가 없을때
			// 전체 식당 메뉴 들고 오고
			List<StoreNameVO> list = lunchMapperInterface.getStore();
			// 돌림판 돌리기
			theStore = list.get(random.nextInt(list.size())).getStoreName();
			//
		}
		if(!bokList.isEmpty()){ // 사용자가 정한메뉴가 있을때
			// 돌림판 돌리고
			bokStore = bokList.get(random.nextInt(bokList.size())).getStorePicked();
		} else { // 사용자가 정한 메뉴가 없을때
			// 전체 식당 메뉴 들고 오고
			List<StoreNameVO> list = lunchMapperInterface.getStore();
			// 돌림판 돌리기
			bokStore = list.get(random.nextInt(list.size())).getStoreName();
		}
		logger.info("theStore -> " + theStore);
		logger.info("bokStore -> " + bokStore);
		// 사무실별 돌림판 돌린 식당 디비에 넣기
		lunchMapperInterface.insertDailyStoreBok(bokStore,today);
		lunchMapperInterface.insertDailyStoreThe(theStore,today);
	}
}
