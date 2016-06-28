package com.gzhd.service.itf;

import com.gzhd.model.BetMessageModel;
import com.gzhd.model.DepositApplyModel;
import com.gzhd.model.PageModel;



public interface DepositApplyService {
	
	public static final String BEAN_NAME = "com.gzhd.service.itf.DepositApplyService";

	/**
	 * 
	 *保存开奖信息
	 */
	public String addDepositApply(DepositApplyModel model);
	
	
	
	/**
	 * 
	 *保存开奖信息
	 */
	public String updateDepositApply(DepositApplyModel model);
	
	/**
	 * 
	 *根据id获取信息
	 */
	public DepositApplyModel get(String id);
	
	/**
	 * 
	 *分页获取
	 */
	public PageModel getForPageModel(int pageNum, int pageSize,DepositApplyModel model);
	
	

}
