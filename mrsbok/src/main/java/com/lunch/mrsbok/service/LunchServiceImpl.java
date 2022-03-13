package com.lunch.mason.service;

import com.lunch.mason.domain.*;
import com.lunch.mason.mapper.LunchMapperInterface;
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
	public String today() {
		return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
	}
	// 식당 리스트 가져오기
	@Override
	public List<StoreVO> getStoreList() throws Exception {
		logger.info(" Service -> getStoreList start");
		List<StoreVO> list = new ArrayList<>();
		// 식당전체 다들고오기
		list.addAll(lunchMapperInterface.getStore());
		//
		logger.info("service -> list : "+list);
		return list;
	}
	
	// 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
	@Override
	public void choiceStore(String id, StorePickedVO storePickedVO) {
		logger.info(" Service -> choiceStore() start");
		logger.info(" Service -> today : '"+ today()+"'");
		String office = storePickedVO.getOffice();
		String storePicked = storePickedVO.getStorePicked();
		if(lunchMapperInterface.checkStore(id, today())){ // 있으머는 어~~~업데이트
			logger.info("업데이트");
			lunchMapperInterface.updateChoiceStore(id, today(), storePicked, office);
		}else{ // 없으면 인사트
			int seq = lunchMapperInterface.getDateSeq(today()) + 1;
			logger.info("인써트");
			lunchMapperInterface.choiceStore(id, today(), storePicked, office,seq);
		}
		logger.info(" Service -> choiceStore() end");
	}
	
	
	//전체 유저의 식당,사무실 리스트 가져오기
	@Override
	public List getStoreListOfficeA(String today) {
		List<StorePickedListVO> list = new ArrayList<>();
		list.addAll(lunchMapperInterface.getStoreListOfficeA(today));
		logger.info("\n Service -> getStoreListOfficeA -> list : "+ list);
		return list;
	}
	//전체 유저의 식당,사무실 리스트 가져오기
	@Override
	public List getStoreListOfficeB(String today) {
		List<StorePickedListVO> list = new ArrayList<>();
		list.addAll(lunchMapperInterface.getStoreListOfficeB(today));
		return list;
	}
	
	
	@Override
	public List<MyOrderListVO> getMyOrderlist(String id, String today) {
		return lunchMapperInterface.getMyOrderList(id, today);
	}
	
	@Override
	public List<ChoiceMenuVO> getOrderList(String today, String office) {
		return lunchMapperInterface.getOrderList(today, office);
	}
	
}