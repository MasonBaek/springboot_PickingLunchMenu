package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.mapper.LunchMapperInteface;
import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/*")
public class ViewController {
  Logger logger = LoggerFactory.getLogger(ViewController.class);
  
  private final LunchMapperInteface lunchMapperInteface;
  private final LunchService lunchService;
  
  public ViewController(LunchMapperInteface lunchMapperInteface,
                        LunchService lunchService) {
    this.lunchMapperInteface = lunchMapperInteface;
    this.lunchService = lunchService;
  }
  
  @RequestMapping("/")
  public String index() {

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
    // 식당리스트 가져오기
    List<String> list = lunchService.getStoreList();
    logger.info("list -> " + list);
    // 리스트 넘기기
    model.addAttribute("storeList",list);
    return "lunch";
  }

}
