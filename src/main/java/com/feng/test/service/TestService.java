package com.feng.test.service;

import java.util.Map;

import com.feng.common.model.Test;
import com.feng.core.mybatis.page.Pagination;

public interface TestService {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Test record);

    int insertSelective(Test record);

    Test selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Test record);

    int updateByPrimaryKey(Test record);

	Pagination<Test> findPage(Map<String, Object> resultMap, Integer pageNo,Integer pageSize);
}
