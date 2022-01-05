package com.lunch.mrsbok.mapper;

import com.lunch.mrsbok.domain.HaveIChosenStoreVO;
import com.lunch.mrsbok.domain.MemberVO;
import com.lunch.mrsbok.domain.StorePickedListVO;
import com.lunch.mrsbok.domain.StorePickedVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Mapper
@Repository
public interface LunchMapperInterface {
  // 로그인
  boolean doLogin(MemberVO memberVO);
  
  // 식당 리스트(전체)
  String getStore(int storeNum);
  // 식당 내가 선택했냐? 안햇으면 false / 선택 했으면 식당이름
  HaveIChosenStoreVO haveIChosenStore(String id, String today);
  
  // 식당 Index 최대값 가져오기
  int getMaxStoreNum();
  
  // 사용자가 선택한 식당이 있는가 체크해보기
  boolean checkStore(String id, String today);
  
  // 사용자가 선택한 식당 DB에 넣기
  void choiceStore(String id, String today, String storePicked, String office, int date_seq);
  
  // 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
  void updateChoiceStore(String id, String today, String storePicked, String office);
  
  // 오늘 식당이 들으가있는가 체크해보자
  int checkStoreForList(String today);
  // 오늘 식당이 들으가있는가 체크 후 false 아니면-> index반환됨 반환된 인데스로 for 고고씽
  StorePickedListVO getStoreListBok(String today, int index);
  StorePickedListVO getStoreListThe(String today, int index);
  
  // Date_seq 가져오기 0 아니면 현재 저장값중에 Max -> 가공 할때 +1 해주면됨
  int getDateSeq(String today);
}
