package com.feng.test.bo;

import java.io.Serializable;

import com.feng.common.model.Test;
import com.feng.common.utils.StringUtils;

public class TestBo extends Test implements Serializable {

	private static final long serialVersionUID = -499784420810650969L;
	/**
	 * 用户ID (用String， 考虑多个ID，现在只有一个ID)
	 */
	private String userId;
	/**
	 * 是否勾选
	 */
	private String marker;

	public boolean isCheck(){
		return StringUtils.equals(userId,marker);
	}
	public String getMarker() {
		return marker;
	}

	public void setMarker(String marker) {
		this.marker = marker;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
