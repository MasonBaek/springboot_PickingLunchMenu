package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.domain.HaveIChosenStoreVO;
import com.lunch.mrsbok.mapper.LunchMapperInterface;
import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/*")
public class ViewController {
  Logger logger = LoggerFactory.getLogger(ViewController.class);
  
  private final LunchMapperInterface lunchMapperInterface;
  private final LunchService lunchService;
  
  public ViewController(LunchMapperInterface lunchMapperInterface,
                        LunchService lunchService) {
    this.lunchMapperInterface = lunchMapperInterface;
    this.lunchService = lunchService;
  }
  
  @RequestMapping("/")
  public String index() {
    Date now =new Date();
//    Date ready = new Date("00");
    //now.before()
    // if(now.before("09-30"))
    // return
    
    return "index";
  }
  @RequestMapping("/index")
  public String index2nd() {

    return "redirect:/";
  }
  
  @RequestMapping("/lunch")
  public String lunch(HttpSession session, Model model) throws  Exception {
    if(session.getAttribute("id")==null){
      return "redirect:/index";
    }
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    // 시간 제어 가능?
    
    // 식당리스트 가져오기
    List<String> list = lunchService.getStoreList();
    logger.info("list -> " + list);
    //DateTimeFormatter formatter = ;
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    logger.info("선택한 식당 있냐? 날짜 :"+today);
    // 내가 선택한 식당 있나? 있으면 가져오기
    HaveIChosenStoreVO haveI;
    try {
      haveI = lunchMapperInterface.haveIChosenStore((String)session.getAttribute("id"),today);
      logger.info("choiceStore 정상 리턴2 :"+haveI.getStorePicked());
      model.addAttribute("choiceStore",haveI);
    }catch (NullPointerException e) {
      logger.info("NullPointerException 발생");
      model.addAttribute("choiceStore",false);
    }
    //전체 유저의 식당,사무실 리스트 가져오기
    List checkStoreListThe = lunchService.checkStoreListBok(today);
    List checkStoreListBok = lunchService.checkStoreListThe(today);
    // [0] 번 인데스가 '1'이면 리스트 있음 '0'이면 없음
    model.addAttribute("checkStoreListThe", checkStoreListThe);
    model.addAttribute("checkStoreListBok", checkStoreListBok);
    // 리스트 넘기기
    model.addAttribute("storeList",list);
    //model.
    return "lunch";
  }

}
