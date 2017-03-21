package com.feng.test.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.feng.common.dao.TestMapper;
import com.feng.common.model.Test;
import com.feng.core.mybatis.BaseMybatisDao;
import com.feng.core.mybatis.page.Pagination;
import com.feng.test.service.TestService;

@Service
public class TestServiceImpl extends BaseMybatisDao<TestMapper> implements TestService {
	@Autowired
	TestMapper testMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return testMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Test record) {
		return testMapper.insert(record);
	}

	@Override
	public int insertSelective(Test record) {
		return testMapper.insertSelective(record);
	}

	@Override
	public Test selectByPrimaryKey(Integer id) {
		return testMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Test record) {
		return testMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Test record) {
		return testMapper.updateByPrimaryKey(record);
	}

	@Override
	public Pagination<Test> findPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
		return  super.findPage(resultMap, pageNo, pageSize);
	}

}
