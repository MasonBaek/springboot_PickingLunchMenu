package com.lunch.mrsbok.service;

import com.lunch.mrsbok.mapper.LunchMapperInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

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
}
