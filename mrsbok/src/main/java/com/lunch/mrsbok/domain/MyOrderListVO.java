package com.lunch.mason.domain;

import lombok.Data;

@Data
public class MyOrderListVO {
	private int choicemenuseq;
	private String store;
	private String menu;
	private String menu_option;
	private String addmenu;
	private int price;
}
