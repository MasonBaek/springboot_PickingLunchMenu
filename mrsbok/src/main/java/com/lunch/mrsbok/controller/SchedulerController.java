package com.lunch.mrsbok.controller;

import com.lunch.mrsbok.service.LunchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class SchedulerController {
	Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	private final LunchService lunchService;
	
	public SchedulerController(LunchService lunchService) {
		this.lunchService = lunchService;
	}
	
	// 시간 들으 가는가 TEST
	//@Scheduled(cron = "*/1 * * * * *")
	/*
	public void datePrintTest() {
		LocalDateTime now = LocalDateTime.now();
		System.out.println("now : " + now);
	}
	*/
	// 시간 테스트 format 사용
	//@Scheduled(cron = "*/1 * 13 * * *")
	/*
	public void datePrintTest() {
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
		String today = now.format(formatter); // 01-04 양식으로 날짜 String 변수에 넣음
	}
	*/
	
}
