package com.lunch.mason.domain;

import lombok.Data;

@Data
public class HaveIChosenStoreVO {
	private int store_seq;
	private String storePicked;
	private String office;
}
