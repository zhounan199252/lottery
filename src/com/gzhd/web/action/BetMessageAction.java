package com.gzhd.web.action;



import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.model.BetMessageModel;
import com.gzhd.model.FrontUserModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.BetMessageService;
import com.gzhd.service.itf.FrontUserService;
import com.gzhd.util.TimeUtil;
import com.opensymphony.xwork2.ActionContext;


@Action(value = "betmessage", results = { 
		@Result(name = "list", location = "/WEB-INF/pages/highFrequency/backBetMessage.jsp"),
		@Result(name = "list", location = "betmessage!listBackBetMessage.action", type = "redirectAction")
})
@Scope("prototype")
public class BetMessageAction  extends BaseAction<BetMessageModel>  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(BetMessageAction.class);

	@Resource(name = BetMessageService.BEAN_NAME)
	private BetMessageService betMessageService;
	@Resource(name = FrontUserService.BEAN_NAME)
	private FrontUserService frontUserService;
	
	
	public void addBetMessage() {
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		model.setBetDate(currentTime);
		FrontUserModel frontUserModel = frontUserService.getUserById(model.getBetPerson());
		if(!frontUserModel.equals("")&&frontUserModel!=null){
			double   yue =   frontUserModel.getBalance();
			double  amount = Double.valueOf(model.getBetQuan())*model.getBetPrice();
			if(yue>=amount){
				frontUserModel.setBalance(yue-amount);
				frontUserService.updateUserBalanceById(frontUserModel);
				String id= betMessageService.addBetMessage(model);
				if(id!=null){
					writeJsonToJsp("投注成功");	
				}else{
					writeJsonToJsp("投注失败，请重新下注");		
				}
			}else{
				writeJsonToJsp("金额不足，请联系客服人员充值");
			}
			
		}
		
	
		
	}
	
	/**
	 * 跳转后台查看用户投注信息界面
	 */
	
	public String listBackBetMessage() {
		
		PageModel pageModel = betMessageService.getForPageModel(model.getPageNum(), ConstantValues.PAGE_SIZE, model);
		
		ActionContext.getContext().put("pageModel", pageModel);
		
		return "list";
		
	}
	
	
	/**
	 * 删除投注信息
	 */
	public String deleteById() {

		betMessageService.deleteById(model.getId());

		return "toList";
	}



}
