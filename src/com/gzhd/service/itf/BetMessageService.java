package com.gzhd.service.itf;

import java.util.List;

import com.gzhd.model.BetMessageModel;
import com.gzhd.model.PageModel;


public interface BetMessageService {
	
	public static final String BEAN_NAME = "com.gzhd.service.itf.BetMessageService";

	/**
	 * 
	 *保存投注信息
	 */
	public String addBetMessage(BetMessageModel model);
	
	/**
	 * 
	 *分页获取
	 */
	public PageModel getForPageModel(int pageNum, int pageSize,BetMessageModel model);
	
	/**
	 * 
	 *获取
	 */
	public List<BetMessageModel> getAll(BetMessageModel model);
	/**
	 * @Description:根据id删除信息
	 * @param id
	 * @return:void
	 * @exception:
	 * @time:2015年7月28日 上午9:46:44
	 */
	public void deleteById(String id);
	
	
	/**
	 * @Description:更新投注信息
	 * @param model
	 * @return:void
	 * @exception:
	 * @time:2015年7月28日 上午9:35:33
	 */
	public void updateBetMessage(BetMessageModel model);



}
