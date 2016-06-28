package com.gzhd.web.action;



import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.model.DepositApplyModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.DepositApplyService;
import com.gzhd.util.TimeUtil;
import com.opensymphony.xwork2.ActionContext;


@Action(value = "depositApply", results = {
		@Result(name = "list", location = "/WEB-INF/pages/highFrequency/depositHandle.jsp"),
		@Result(name = "myCount",location = "frontUser!myCount.action", type = "redirectAction") })
@Scope("prototype")
public class DepositApplyAction extends BaseAction<DepositApplyModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	@Resource(name = DepositApplyService.BEAN_NAME)
	private DepositApplyService depositApplyService;
	
	
	
	
	public String addDepositApply() {
		model.setStatus("待处理");
		model.setApplyTime(TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss"));
		depositApplyService.addDepositApply(model);
		return "myCount";
		
	}
	
	
	public String updateDepositApply() {
		String[] ids = model.getId().split(",");
		for (String sigleId : ids) {
			model.setId(sigleId);
			model.setStatus("已处理");
			model.setHandletime(TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss"));
			depositApplyService.updateDepositApply(model);
		}	
		
		
		return null;
		
	}
	
	/**
	 * 跳转后台查看提现申请
	 */

	public String listDepositMessage() {

		PageModel pageModel = depositApplyService.getForPageModel(
				model.getPageNum(), ConstantValues.PAGE_SIZE, model);

		ActionContext.getContext().put("pageModel", pageModel);

		return "list";

	}


}
