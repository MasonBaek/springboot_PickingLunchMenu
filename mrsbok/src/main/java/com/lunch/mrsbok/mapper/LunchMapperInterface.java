package com.lunch.mrsbok.mapper;

import com.lunch.mrsbok.domain.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Mapper
@Repository
public interface LunchMapperInterface {
  // 로그인
  boolean doLogin(MemberVO memberVO);
  
  // 식당 리스트(전체)
  String getStore(int storeNum);
  
  // 식당 Index 최대값 가져오기
  int getMaxStoreNum();
  
  
}
