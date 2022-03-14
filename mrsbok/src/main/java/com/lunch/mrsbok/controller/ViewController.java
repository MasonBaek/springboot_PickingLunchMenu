package com.lunch.mason.controller;

import com.lunch.mason.domain.*;
import com.lunch.mason.mapper.LunchMapperInterface;
import com.lunch.mason.service.LunchService;
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
import java.util.*;

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
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-08-29-00"));
    String last = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-13-01-00"));
    SimpleDateFormat SDF = new SimpleDateFormat("yy-MM-dd-HH-mm-ss");
    Date firstParse = SDF.parse(first);
    Date lastParse = SDF.parse(last);
    logger.info("\n\t\t 홈 ");
    
    if(new Date().after(firstParse) && new Date().before(lastParse) ){
      return "index";
    }
    return "ready";
  }
    
  /* lunch */
  @RequestMapping("/lunch")
  public String lunch(HttpSession session, Model model) throws  Exception {
    if(session.getAttribute("id")==null){
      return "redirect:/";
    }
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-08-29-00"));
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
    
    // 식당리스트 가져오기
    List<StoreVO> list = lunchService.getStoreList();
    logger.info("list -> "+ list);
    model.addAttribute("storeList",list);
    // 내가 선택한 식당 있나? 있으면 가져오기
    HaveIChosenStoreVO haveIChosenStoreVO = lunchMapperInterface.haveIChosenStore((String) session.getAttribute("id"), today());
    logger.info("haveI"+haveIChosenStoreVO);
    model.addAttribute("choiceStore -> ",haveIChosenStoreVO);
    //전체 유저의 식당,사무실 리스트 가져오기
    List checkStoreListOfficeB = lunchService.getStoreListOfficeB(today());
    List checkStoreListOfficeA = lunchService.getStoreListOfficeA(today());
    
    model.addAttribute("StoreListOfficeB", checkStoreListOfficeB);
    model.addAttribute("StoreListOfficeA", checkStoreListOfficeA);
    // 리스트 넘기기
    //model.
    return "lunch";
  }
  
  
  @RequestMapping("/lunch_officeA")
  public String lunch_OfficeA(Model model) {
    List getStoreListOfficeA = lunchService.getStoreListOfficeA(today());
    model.addAttribute("StoreListOfficeA", getStoreListOfficeA);
    return "lunch_officeA";
  }
  
  @RequestMapping("/lunch_officeB")
  public String lunch_officeThe(Model model) {
    List getStoreListOfficeB = lunchService.getStoreListOfficeB(today());
    model.addAttribute("StoreListOfficeB", getStoreListOfficeB);
    return "lunch_officeB";
  }
  /* lunch */
  
  /* menu */
  @RequestMapping("/menu")
  public String menu(HttpSession session, Model model) throws Exception{
    if(session.getAttribute("id")==null){
      return "redirect:/";
    }
    // id값 넘겨주기
    model.addAttribute("id", session.getAttribute("id"));
    String first = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-08-29-00"));
    String second = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-10-19-00"));
    String last = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd-13-01-00"));
    SimpleDateFormat SDF = new SimpleDateFormat("yy-MM-dd-HH-mm-ss");
    Date firstParse = SDF.parse(first);
    Date secondParse = SDF.parse(second);
    Date lastParse = SDF.parse(last);
    logger.info("secondParse -> " + secondParse);
    logger.info("lastParse -> " + lastParse);
    if (new Date().after(firstParse) && new Date().before(secondParse)) {
      return "redirect:/lunch";
    }else if(new Date().before(firstParse) || new Date().after(lastParse) ){
      return "redirect:/ready";
    }
    model.addAttribute("OfficeBStore", lunchMapperInterface.getOfficeBStoreForMenu(today()));
    model.addAttribute("OfficeAStore", lunchMapperInterface.getOfficeAStoreForMenu(today()));
    
    return "menu";
  }
  /* menu */
  
  @RequestMapping("/mainMenuList")
  public String mainMenuList(@RequestParam String office, Model model) {
    String store = lunchMapperInterface.getDailyStore(office, today());
    List<MenuListVO> menuList = lunchMapperInterface.getMenuList(store);
    if (menuList.isEmpty()) {
      model.addAttribute("store", store);
    } else {
      model.addAttribute("menuList", menuList);
    }
    return "mainMenuList";
  }

  /* subMenuList */
  @RequestMapping("/subMenuList")
  public String subMenuList(@RequestParam int menu_seq, Model model){
    logger.info("@@@@@@getSubMenuList 시작");
// submenu_seq 먼저 들고오기
    List<Integer> getSubmenuSeq = lunchMapperInterface.getSubmenuSeq(menu_seq);
    List<SubMenuListVO> subMenuList = new ArrayList<>();
    for(int submenu_seq : getSubmenuSeq){
      // 해당 메뉴의 서브메뉴 가져오기
      SubMenuListVO sVO = lunchMapperInterface.getSubMenuList(submenu_seq);
      // 서브메뉴의 서브옵션 가져오기
      sVO.setSubmenu_optionVO(lunchMapperInterface.getSubmenuOption(submenu_seq));
      System.out.println("sVO->"+sVO);
      subMenuList.add(sVO);
    }
    model.addAttribute("subMenuList", subMenuList);
    logger.info("@@@@@@getSubMenuList 끝");
    return "subMenuList";
  }
  /* subMenuList */
  
  @RequestMapping("/addMenuList")
  public String addMenuList(@RequestParam int menu_seq, Model model){
    logger.info(" Controller getAddMenuList 시작");
    List<AddMenuListVO> addMenuList = lunchMapperInterface.getAddMenuList(menu_seq);
    if(addMenuList.isEmpty()) {
      model.addAttribute("addMenuList", null);
    }
    model.addAttribute("addMenuList", addMenuList);
    logger.info(" Controller getAddMenuList 끝");
    return "addMenuList";
  }
  
  @RequestMapping("/myOrderList")
  public String myOrderList(HttpSession session, Model model) {
    logger.info("today -> "+ today());
    List<MyOrderListVO> myOrderListVO = lunchService.getMyOrderlist((String) session.getAttribute("id"), today());
    logger.info("orderList -> "+ myOrderListVO);
    if (myOrderListVO.isEmpty()) {
      model.addAttribute("myOrderList", null);
      logger.info("orderList empty-> "+ model.getAttribute("myOrderList"));
    } else {
      model.addAttribute("myOrderList", myOrderListVO);
    }
    return "myOrderList";
  }
  
  @RequestMapping("/orderList")
  public String orderList(@RequestParam String office, Model model){
    List<ChoiceMenuVO> orderList = lunchService.getOrderList(today(), office);
    if (orderList.isEmpty()) {
      model.addAttribute("orderList", null);
    } else {
      model.addAttribute("orderList", orderList);
    }
    model.addAttribute("office", office.equals("OfficeA") ? "사무실A" : "사무실B");
    return "orderList";
  }
  
  @RequestMapping("/lunchCount")
  public String lunchCount(Model model){
    logger.info("today -> "+ today());
    
    model.addAttribute("OfficeACount", lunchMapperInterface.getLunchCount(today(),"OfficeA"));
    model.addAttribute("OfficeBCount", lunchMapperInterface.getLunchCount(today(),"OfficeB"));
    model.addAttribute("noLunchCount", lunchMapperInterface.getLunchCount(today(),"noLunch"));
    return "lunchCount";
  }
  
  @RequestMapping("/ready")
  public String ready() {
    return "/ready";
  }
  
  public String today() {
    return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy-MM-dd"));
  }

}
