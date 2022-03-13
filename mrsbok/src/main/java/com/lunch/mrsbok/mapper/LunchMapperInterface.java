package com.lunch.mason.mapper;
import com.lunch.mason.domain.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface LunchMapperInterface {
  // 로그인
  boolean doLogin(MemberVO memberVO);
  
  // 식당 리스트(전체)
  List<StoreVO> getStore();
  
  // 식당 내가 선택했냐? 안햇으면 false / 선택 했으면 식당이름
  HaveIChosenStoreVO haveIChosenStore(String id, String today);
  
  // 식당 Index 최대값 가져오기
  // int getMaxStoreNum();
  
  // 사용자가 선택한 식당이 있는가 체크해보기
  boolean checkStore(String id, String today);
  
  // 사용자가 선택한 식당 DB에 넣기
  void choiceStore(String id, String today, String storePicked, String office, int date_seq);
  
  // 사용자가 선택한 식당 DB에 넣기(기존에 선택한식당이 있으면 변경하기)
  void updateChoiceStore(String id, String today, String storePicked, String office);
  
  // 오늘 식당이 들으가있는가 체크 후 false 아니면-> index반환됨 반환된 인데스로 for 고고씽
  List<StorePickedListVO> getStoreListOfficeA(String today);
  List<StorePickedListVO> getStoreListOfficeB(String today);
  
  // Date_seq 가져오기 0 아니면 현재 저장값중에 Max -> 가공 할때 +1 해주면됨
  int getDateSeq(String today);
  int getDateSeqFromChoiceStore(String today);
  
  // 식당 선택했다가 -> 식사 X 경우 업데이트
  void updateNoLunchTodayStore(String id, String today);
  void updateNoLunchTodayMenu(String id, String today);
  // 식사 X 디비 입력
  void noLunchTodayStore(String id, String today, int date_seq);
  void noLunchTodayMenu(String id, String today, int seq);
  
  //돌림판 돌리기전 리스트 가져옴
  List<StoreRandomVO> getStoreListOfficeAForRandom(String today);
  List<StoreRandomVO> getStoreListOfficeBForRandom(String today);
  
  // 돌림판 돌린 식당 디비에 넣기
  void insertDailyStoreOfficeA(String store, String today);
  void insertDailyStoreOfficeB(String store, String today);
  
  // 사무실별 선택된 식당 가져오기
  String getOfficeAStoreForMenu(String today);
  String getOfficeBStoreForMenu(String today);
  
  // 사무실정보 가져와서 식당정보 넘기기
  String getDailyStore(String office, String today);
  // 사무실별 선택된 식당의 메뉴 가져오기
  List<MenuListVO> getMenuList(String store);
  
  // 메인 메뉴 추가하기
  void insertMainMenu(MainMenuVO mainMenuVO);
  // 가장최근에 추가한 menu_seq 들고오기
  int getLatestMenuSeq();
  // submenu_seq 먼저 들고오기
  List<Integer> getSubmenuSeq(int menu_seq);
  // 해당 메뉴의 서브메뉴 가져오기
  SubMenuListVO getSubMenuList(int submenu_seq);
  // 서브메뉴의 서브옵션 가져오기
  List<Submenu_OptionVO> getSubmenuOption(int submenu_seq);
  // 추가메뉴 리스트 가져오기
  List<AddMenuListVO> getAddMenuList(int menu_seq);
  
  // 메뉴 고르기
  void insertChoiceMenu(ChoiceMenuVO choiceMenuVO);
  
  // 내 주문 내역 가져오기
  List<MyOrderListVO> getMyOrderList(String id, String today);
  
  // 내 주문 내역 지우기
  void deleteOrder(int choicemenuseq);
	
  void insertNewStore(NewStoreVO newStoreVO);
	
	List<ChoiceMenuVO> getOrderList(String today, String office);
  
  List<MemberVO> getLunchCount(String today, String office);
}