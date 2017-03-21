package com.feng.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.feng.common.controller.BaseController;
import com.feng.common.model.Test;
import com.feng.core.mybatis.page.Pagination;
import com.feng.test.service.TestService;

@Controller
@Scope(value="prototype")
@RequestMapping("test")
public class TestController extends BaseController {

	@Autowired
	TestService testService;
	
	@RequestMapping(value="index")
	public ModelAndView testIndex(String findContent,ModelMap modelMap,Integer pageNo){
		modelMap.put("findContent", findContent);
		Pagination<Test> test = testService.findPage(modelMap,pageNo,pageSize);
		return  new ModelAndView("test/index","page",test);
	}
	
	@ResponseBody 
	@RequestMapping(value="index2")
	public List testIndex2(String findContent,ModelMap modelMap,Integer pageNo){
		modelMap.put("findContent", findContent);
		Pagination<Test> test = testService.findPage(modelMap,pageNo,pageSize);
		return test.getList();
	}
}
