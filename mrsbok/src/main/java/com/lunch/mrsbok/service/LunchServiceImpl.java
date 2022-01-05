package com.lunch.mrsbok.service;

import com.lunch.mrsbok.domain.StorePickedListVO;
import com.lunch.mrsbok.domain.StorePickedVO;
import com.lunch.mrsbok.mapper.LunchMapperInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class LunchServiceImpl implements LunchService {
	
	Logger logger = LoggerFactory.getLogger(LunchServiceImpl.class);
	private final LunchMapperInterface lunchMapperInterface;
	
	public LunchServiceImpl(LunchMapperInterface lunchMapperInterface) {
		this.lunchMapperInterface = lunchMapperInterface;
	}
	
	// 식당 리스트 가져오기
	@Override
	public List<String> getStoreList() throws Exception {
		logger.info(" Service -> getStoreList start");
		int maxIndex = lunchMapperInterface.getMaxStoreNum();
		logger.info("maxIndex -> " +maxIndex);
		List<String> list = new ArrayList<>();
		int storeNum = 0;
		while (storeNum<maxIndex){
			list.add(lunchMapperInterface.getStore(storeNum));
			storeNum++;
		}
		logger.info("service -> list : "+list);
		return list;
	}
	
	// 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
	@Override
	public void choiceStore(String id, StorePickedVO storePickedVO) {
		logger.info(" Service -> choiceStore() start");
		String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd")); // 01-04 양식으로 날짜 String 변수에 넣음
		logger.info(" Service -> today : '"+ today+"'");
		String office = storePickedVO.getOffice();
		String storePicked = storePickedVO.getStorePicked();
		if(lunchMapperInterface.checkStore(id, today)){ // 있으머는 어~~~업데이트
			lunchMapperInterface.updateChoiceStore(id, today, storePicked, office);
		}else{ // 없으면 인사트
			int seq = lunchMapperInterface.getDateSeq(today) + 1;
			lunchMapperInterface.choiceStore(id, today, storePicked, office,seq);
		}
		logger.info(" Service -> choiceStore() start");
	}
	
	
	//전체 유저의 식당,사무실 리스트 가져오기
	@Override
	public List checkStoreListBok(String today) {
		int index = lunchMapperInterface.checkStoreForList(today);
		List<StorePickedListVO> list = new ArrayList<>();
		if( index != 0){
			for(int i = 1; i <= index; i++){
				list.add(lunchMapperInterface.getStoreListBok(today,i));
			}
		}
		logger.info("@@@@@Service -> list : "+ list);
		return list;
	}
	//전체 유저의 식당,사무실 리스트 가져오기
	@Override
	public List checkStoreListThe(String today) {
		int index = lunchMapperInterface.checkStoreForList(today);
		List<StorePickedListVO> list = new ArrayList<>();
		if( index != 0){
			for(int i = 1; i <= index; i++){
				list.add(lunchMapperInterface.getStoreListThe(today,i));
			}
		}
		logger.info("@@@@@Service -> list : "+ list);
		return list;
	}
}
