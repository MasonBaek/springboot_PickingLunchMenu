package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.domain.LunchVO;
import com.lunch.mrsbok.domain.MemberVO;
import com.lunch.mrsbok.domain.ResultVO;
import com.lunch.mrsbok.mapper.LunchMapperInteface;
import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/api/*")
public class MainController {
  Logger logger = LoggerFactory.getLogger(MainController.class);
  
  private final LunchMapperInteface lunchMapperInteface;
  private final LunchService lunchService;

  public MainController(LunchMapperInteface lunchMapperInteface, LunchService lunchService) {
    this.lunchMapperInteface = lunchMapperInteface;
    this.lunchService = lunchService;
  }

  @PostMapping("/login")
  @ResponseBody
  public LunchVO loginPOST(HttpSession session, @RequestBody MemberVO memberVO, Model model) throws Exception{
    logger.info(" loginPOST -> memberVO : "+memberVO);
    if(lunchMapperInteface.doLogin(memberVO)){ // 로그인 확인 true
      session.setAttribute("id",memberVO.getId());
      
      logger.info(" loginPOST -> 로그인 성공 ! ");
      return new ResultVO("success");
    }
    logger.info(" loginPOST -> 로그인 실패 ! ");
    return new ResultVO("abc");
  }
  
  @RequestMapping("/logout")
  public String logoutPOST(HttpSession session){
    session.invalidate();
    return "redirect:/";
  }
  
  
}