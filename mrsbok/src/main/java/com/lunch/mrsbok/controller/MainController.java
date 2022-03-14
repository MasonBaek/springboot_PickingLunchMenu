package com.lunch.mason.controller;

import com.lunch.mason.domain.*;
import com.lunch.mason.mapper.LunchMapperInterface;
import com.lunch.mason.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/api/*")
public class MainController {
  Logger logger = LoggerFactory.getLogger(MainController.class);
  
  // 호출때마다 오늘 날짜 반환
  // 최초에는 변수에 담았더니 서버돌린날짜로 고정이 되어서
  // 메소드 형태로 변경
  public String today() {
    return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
  }
  
  private final LunchMapperInterface lunchMapperInterface;
  private final LunchService lunchService;

  public MainController(LunchMapperInterface lunchMapperInterface, LunchService lunchService) {
    this.lunchMapperInterface = lunchMapperInterface;
    this.lunchService = lunchService;
  }
  
  // 로그인 index -> lunch로 감
  @PostMapping("/login")
  @ResponseBody
  public LunchVO loginPOST(HttpSession session, @RequestBody MemberVO memberVO) throws Exception{
    logger.info(" Controller -> loginPOST -> memberVO : "+memberVO);
    if(lunchMapperInterface.doLogin(memberVO)){ // 로그인 확인 true
      logger.info(" loginPOST -> 로그인 성공");
      session.setAttribute("id",memberVO.getId());
      //session.setMaxInactiveInterval(60*60*5); //5시간
      session.setMaxInactiveInterval(-1); // 무한대
      return new ResultVO("success");
    }
    return new ResultVO("asdf");
  }
  
  // 로그아웃
  @RequestMapping("/logout")
  public String logoutPOST(HttpSession session){
    session.invalidate();
    return "redirect:/";
  }
  
  // lunch -> 새로운식당추가
  @PostMapping("/insertNewStore")
  @ResponseBody
  public ResultVO insertNewStorePOST(@RequestBody NewStoreVO newStoreVO) {
    lunchMapperInterface.insertNewStore(newStoreVO);
    return new ResultVO("success");
  }
  
  // lunch -> 식당 선택
  @PostMapping("/choice")
  @ResponseBody
  public ResultVO choicePOST(HttpSession session, @RequestBody StorePickedVO storePickedVO) throws Exception {
    logger.info(" Controller -> choicePOST -> storePickedVO : "+storePickedVO);
    lunchService.choiceStore((String) session.getAttribute("id"),storePickedVO);
    return new ResultVO("success");
    //return new ResultVO("asdf");
  }
  
  // lunch -> 결식 : choicemenu & dailystore 둘다 입력
  @PostMapping("/noLunchToday")
  @ResponseBody
  public ResultVO noLunchTodayPOST(HttpSession session) throws Exception{
    logger.info(" Controller -> noLunchTodayPOST -> 밥안먹는사람~~~ : " + session.getAttribute("id"));
    String id = (String) session.getAttribute("id");
  
    // 있으머는 어~~~업데이트
    if(lunchMapperInterface.checkStore(id, today())){
      logger.info("업데이트");
      lunchMapperInterface.updateNoLunchTodayStore(id, today());
      lunchMapperInterface.updateNoLunchTodayMenu(id, today());
    }else{
      // 없으면 인사트
      int seq = lunchMapperInterface.getDateSeq(today()) + 1;
      logger.info("인써트");
      lunchMapperInterface.noLunchTodayStore(id,today(),seq);
      lunchMapperInterface.noLunchTodayMenu(id,today(),seq);
    }
    return new ResultVO("success");
  }
  
  // menu - 새로운 메인메뉴 추가
  @PostMapping("/insertMainMenu")
  @ResponseBody
  public ResultVO insertMainMenuPOST(@RequestBody MainMenuVO mainMenuVO){
    logger.info("mainMenuVO -> " + mainMenuVO);
    lunchMapperInterface.insertMainMenu(mainMenuVO);
    return new ResultVO(String.valueOf(lunchMapperInterface.getLatestMenuSeq()));
  }
  
  // menu -> 메인메뉴 선택
  @PostMapping("/insertChoiceMenu")
  @ResponseBody
  public ResultVO insertChoiceMenuPOST(@RequestBody ChoiceMenuVO choiceMenuVO){
    logger.info("choiceMenuVO -> " + choiceMenuVO);
    choiceMenuVO.setDate_seq(lunchMapperInterface.getDateSeqFromChoiceStore(today()) + 1);
    choiceMenuVO.setDate(today());
    lunchMapperInterface.insertChoiceMenu(choiceMenuVO);
    return new ResultVO("success");
  }
  
  // menu -> 주문 삭제
  @PostMapping("/deleteOrder")
  @ResponseBody
  public ResultVO deleteOrderPOST(@RequestBody int choicemenuseq){
    lunchMapperInterface.deleteOrder(choicemenuseq);
    return new ResultVO("success");
  }
  
  
}
