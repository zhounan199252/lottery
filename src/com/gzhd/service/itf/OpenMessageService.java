package com.gzhd.service.itf;

import com.gzhd.model.OpenMessageModel;



public interface OpenMessageService {
	
	public static final String BEAN_NAME = "com.gzhd.service.itf.OpenMessageService";

	/**
	 * 
	 *保存开奖信息
	 */
	public String addOpenMessage(OpenMessageModel model);
	
	
	/**
	 * 
	 *查询信息
	 */
	public OpenMessageModel getOpenMessage(OpenMessageModel model);
}
