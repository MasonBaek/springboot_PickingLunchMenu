package com.lunch.mason.service;
import com.lunch.mason.domain.*;

import java.util.List;
public interface LunchService {
	
	// 식당 전체 리스트
	List<StoreVO> getStoreList() throws Exception;
	// 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
	void choiceStore(String id, StorePickedVO storePickedVO);
	// //전체 유저의 식당,사무실 리스트 가져오기
	List getStoreListOfficeA(String today);
	List getStoreListOfficeB(String today);
	
	List<MyOrderListVO> getMyOrderlist(String id, String today);
	
	List<ChoiceMenuVO> getOrderList(String today, String office);
	
}