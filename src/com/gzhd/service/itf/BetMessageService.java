package com.gzhd.service.itf;

import com.gzhd.model.BetMessageModel;


public interface BetMessageService {
	
	public static final String BEAN_NAME = "com.gzhd.service.itf.BeatMessageService";

	/**
	 * 
	 *保存投注信息
	 */
	public String addBetMessage(BetMessageModel model);



}
