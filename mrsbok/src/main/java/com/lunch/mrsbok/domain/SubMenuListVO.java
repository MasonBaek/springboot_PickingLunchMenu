package com.lunch.mason.domain;

import lombok.Data;

import java.util.List;

@Data
public class SubMenuListVO {
	private int submenu_seq;
	private int menu_seq;
	private String submenu_status;
	private String submenu;
	private List<Submenu_OptionVO> submenu_optionVO;
}
