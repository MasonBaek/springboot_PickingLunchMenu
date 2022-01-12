package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.domain.HaveIChosenStoreVO;
import com.lunch.mrsbok.domain.MenuListVO;
import com.lunch.mrsbok.domain.StoreNameVO;
import com.lunch.mrsbok.mapper.LunchMapperInterface;
import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
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
  public String index() throws Exception{
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-09-29-00"));
    String last = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-13-01-00"));
    SimpleDateFormat SDF = new SimpleDateFormat("yy-MM-dd-HH-mm-ss");
    Date firstParse = SDF.parse(first);
    Date lastParse = SDF.parse(last);
    //if(new Date().after(firstParse) && new Date().before(lastParse) ){
      return "index";
    //}
    //return "ready";
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
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-09-29-00"));
    String second = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-10-19-00"));
    String last = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-13-01-00"));
    SimpleDateFormat SDF = new SimpleDateFormat("yy-MM-dd-HH-mm-ss");
    Date firstParse = SDF.parse(first);
    Date secondParse = SDF.parse(second);
    Date lastParse = SDF.parse(last);
    
    logger.info("secondParse -> " + secondParse);
    if(new Date().after(secondParse) && new Date().before(lastParse) ){
      logger.info("10시 20분 부터 /menu페이지로 이동");
      return "redirect:/menu";
    }else if(new Date().before(firstParse) || new Date().after(lastParse) ){
      return "redirect:/ready";
    }
    
    
    //DateTimeFormatter formatter = ;
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    
    // 식당리스트 가져오기
    List<StoreNameVO> list = lunchService.getStoreList();
    logger.info("list -> " + list);
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
    List checkStoreListThe = lunchService.checkStoreListThe(today);
    List checkStoreListBok = lunchService.checkStoreListBok(today);
    // [0] 번 인데스가 '1'이면 리스트 있음 '0'이면 없음
    model.addAttribute("checkStoreListThe", checkStoreListThe);
    model.addAttribute("checkStoreListBok", checkStoreListBok);
    // 리스트 넘기기
    model.addAttribute("storeList",list);
    //model.
    return "lunch";
  }
  
  @RequestMapping("/lunch_officeBok")
  public String lunch_officeBok(Model model) {
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    List checkStoreListBok = lunchService.checkStoreListBok(today);
    model.addAttribute("checkStoreListBok", checkStoreListBok);
    return "lunch_officeBok";
  }
  
  @RequestMapping("/lunch_officeThe")
  public String lunch_officeThe(Model model) {
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    List checkStoreListThe = lunchService.checkStoreListThe(today);
    model.addAttribute("checkStoreListThe", checkStoreListThe);
    return "lunch_officeThe";
  }
  
  @RequestMapping("/menu")
  public String menu(HttpSession session, Model model) throws Exception{
    if(session.getAttribute("id")==null){
      return "redirect:/index";
    }
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-09-29-00"));
    String second = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-10-19-00"));
    String last = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-13-01-00"));
    SimpleDateFormat SDF = new SimpleDateFormat("yy-MM-dd-HH-mm-ss");
    Date firstParse = SDF.parse(first);
    Date secondParse = SDF.parse(second);
    Date lastParse = SDF.parse(last);
    
    logger.info("secondParse -> " + secondParse);
    logger.info("lastParse -> " + lastParse);
    /*
    if(new Date().after(firstParse) && new Date().before(secondParse)){
      logger.info("넌 아직 준비가 안됐다 lunch로 돌아가라 네 이놈 !");
      return "redirect:/lunch";
    }else if(new Date().before(firstParse) || new Date().after(lastParse) ){
      logger.info("ready로 돌아가기");
      return "redirect:/ready";
    }
    */
    // 사무실별 식당
    String bokStore = lunchMapperInterface.getBokStoreForMenu(today);
    String theStore = lunchMapperInterface.getTheStoreForMenu(today);
    logger.info(" Controller -> /menu bokStore : " + bokStore);
    logger.info(" Controller -> /menu theStore : " + theStore);
    model.addAttribute("theStore", theStore);
    model.addAttribute("bokStore", bokStore);
    // 식당별 메뉴
    /*
    List<MenuListVO> bokMenuList = lunchMapperInterface.getBokMenu(bokStore);
    List<MenuListVO> theMenuList = lunchMapperInterface.getTheMenu(theStore);
    logger.info(" Controller -> /menu bokMenuList : " + bokMenuList);
    logger.info(" Controller -> /menu bokMenuList.size() : " + bokMenuList.size());
    logger.info(" Controller -> /menu theMenuList : " + theMenuList);
    logger.info(" Controller -> /menu theMenuList.size() : " + theMenuList.size());
    if(bokMenuList.isEmpty()){
      bokMenuList = null;
    }
    if(theMenuList.isEmpty()){
      theMenuList = null;
    }
    logger.info(" Controller -> /menu bokMenuList 2 : " + bokMenuList);
    logger.info(" Controller -> /menu theMenuList 2 : " + theMenuList);
    
    model.addAttribute("theMenuList", theMenuList);
    model.addAttribute("bokMenuList", bokMenuList);
    */
    // 메뉴하위 서브메뉴는 메뉴선택하면 ajax통신으로 불러옴
        
    return "menu";
  }
  
  @RequestMapping("/mainMenuList")
  public String mainMenuList(@RequestParam String office, Model model) {
    String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
    String store = lunchMapperInterface.getDailyStore(office, today);
    List<MenuListVO> menuList = lunchMapperInterface.getMenuList(store);
    
    if(menuList.isEmpty()) menuList = null;
    model.addAttribute("menuList", menuList);
    return "mainMenuList";
  }
  /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
  @RequestMapping("/test")
  public String test1() {
    return "test";
  }
  
}
