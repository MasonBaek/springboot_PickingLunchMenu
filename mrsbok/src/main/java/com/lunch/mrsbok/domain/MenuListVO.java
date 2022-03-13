package com.lunch.mason.domain;

import lombok.Data;

@Data
public class MenuListVO {
	private int menu_seq;
	private int store_seq;
	private String store;
	private String menu;
	private int price;
	private String info;
	private int popular;
}
