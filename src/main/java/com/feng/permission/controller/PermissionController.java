package com.feng.permission.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.feng.common.controller.BaseController;
import com.feng.common.model.UPermission;
import com.feng.common.utils.LoggerUtils;
import com.feng.core.mybatis.page.Pagination;
import com.feng.permission.bo.UPermissionBo;
import com.feng.permission.service.PermissionService;
/**
 * 
 * 用户权限管理
 * 
 */
@Controller
@Scope(value="prototype")
@RequestMapping("permission")
public class PermissionController extends BaseController {
	
	@Autowired
	PermissionService permissionService;
	/**
	 * 权限列表
	 * @param findContent	查询内容
	 * @param pageNo		页码
	 * @param modelMap		参数回显
	 * @return
	 */
	@RequestMapping(value="index")
	public ModelAndView index(){
		return new ModelAndView("permission/index");
	}
	@RequestMapping(value="index2",produces={"application/json"})
	@ResponseBody
	public Map index2(String findContent,ModelMap modelMap,Integer pageNumber,Integer pageSize){
		modelMap.put("findContent", findContent);
		//Pagination<UPermission> permissions = permissionService.findPage(modelMap,pageNo,pageSize);
		Map list = permissionService.findPage2(modelMap, pageNumber, pageSize);
		return list;
		//return new ModelAndView("permission/index","page",list);
		
	}
	/**
	 * 权限添加
	 * @param role
	 * @return
	 */
	@RequestMapping(value="addPermission",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> addPermission(UPermission psermission){
		try {
			UPermission entity = permissionService.insertSelective(psermission);
			resultMap.put("status", 200);
			resultMap.put("entity", entity);
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "添加失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "添加权限报错。source[%s]", psermission.toString());
		}
		return resultMap;
	}
	/**
	 * 删除权限，根据ID，但是删除权限的时候，需要查询是否有赋予给角色，如果有角色在使用，那么就不能删除。
	 * @param id
	 * @return
	 */
	@RequestMapping(value="deletePermissionById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteRoleById(String ids){
		return permissionService.deletePermissionById(ids);
	}
}
