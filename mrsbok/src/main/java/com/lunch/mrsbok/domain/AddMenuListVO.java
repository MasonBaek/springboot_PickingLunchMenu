package com.lunch.mason.domain;

import lombok.Data;

@Data
public class AddMenuListVO {
	private int addmenu_seq;
	private int menu_seq;
	private String addmenu_name;
	private String addmenu_price;
}
