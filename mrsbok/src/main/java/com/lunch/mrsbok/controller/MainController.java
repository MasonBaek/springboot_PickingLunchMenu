package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.domain.LunchVO;
import com.lunch.mrsbok.domain.MemberVO;
import com.lunch.mrsbok.domain.ResultVO;
import com.lunch.mrsbok.domain.StorePickedVO;
import com.lunch.mrsbok.mapper.LunchMapperInterface;
import com.lunch.mrsbok.service.LunchService;
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
  
  private final LunchMapperInterface lunchMapperInterface;
  private final LunchService lunchService;

  public MainController(LunchMapperInterface lunchMapperInterface, LunchService lunchService) {
    this.lunchMapperInterface = lunchMapperInterface;
    this.lunchService = lunchService;
  }

  @PostMapping("/login")
  @ResponseBody
  public LunchVO loginPOST(HttpSession session, @RequestBody MemberVO memberVO) throws Exception{
    logger.info(" Controller -> loginPOST -> memberVO : "+memberVO);
    if(lunchMapperInterface.doLogin(memberVO)){ // 로그인 확인 true
      session.setAttribute("id",memberVO.getId());
      logger.info(" loginPOST -> 로그인 성공 ! ");
      return new ResultVO("success");
    }
    logger.info(" loginPOST -> 로그인 실패 ! ");
    return new ResultVO("asdf");
  }
  
  @RequestMapping("/logout")
  public String logoutPOST(HttpSession session){
    session.invalidate();
    return "redirect:/";
  }
  
  @PostMapping("/choice")
  @ResponseBody
  public ResultVO choicePOST(HttpSession session,@RequestBody StorePickedVO storePickedVO) throws Exception {
    logger.info(" Controller -> choicePOST -> storePickedVO : "+storePickedVO);
    lunchService.choiceStore((String) session.getAttribute("id"),storePickedVO);
    return new ResultVO("success");
    //return new ResultVO("asdf");
  }
  
  
}
