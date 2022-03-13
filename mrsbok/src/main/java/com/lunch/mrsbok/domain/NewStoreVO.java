package com.lunch.mason.domain;

import lombok.Data;

@Data
public class NewStoreVO {
	private int store_seq;
	private String store; // 유효성검사
	private String minimum_price;
	private String delivery_tip;
	private String delivery_detail;
}
