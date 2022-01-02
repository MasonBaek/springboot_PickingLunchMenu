package com.lunch.mrsbok.service;

import com.lunch.mrsbok.mapper.LunchMapperInteface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LunchServiceImpl implements LunchService {
	
	Logger logger = LoggerFactory.getLogger(LunchServiceImpl.class);
	private final LunchMapperInteface lunchMapperInteface;
	
	public LunchServiceImpl(LunchMapperInteface lunchMapperInteface) {
		this.lunchMapperInteface = lunchMapperInteface;
	}
	
	// 식당 리스트 가져오기
	@Override
	public List<String> getStoreList() throws Exception {
		logger.info(" Service -> getStoreList start");
		int maxIndex = lunchMapperInteface.getMaxStoreNum();
		logger.info("maxIndex -> " +maxIndex);
		List<String> list = new ArrayList<>();
		int storeNum = 0;
		while (storeNum<=maxIndex){
			list.add(lunchMapperInteface.getStore(storeNum));
			storeNum++;
		}
		logger.info("service -> list : "+list);
		return list;
	}
}
