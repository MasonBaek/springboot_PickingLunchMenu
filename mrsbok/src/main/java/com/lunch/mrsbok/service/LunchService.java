package com.lunch.mrsbok.service;
import com.lunch.mrsbok.domain.StorePickedVO;
import java.util.List;
public interface LunchService {
	// 식당 전체 리스트
	List<String> getStoreList() throws Exception;
	// 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
	void choiceStore(String id, StorePickedVO storePickedVO);
	// //전체 유저의 식당,사무실 리스트 가져오기
	List checkStoreListBok(String today);
	List checkStoreListThe(String today);
	
}