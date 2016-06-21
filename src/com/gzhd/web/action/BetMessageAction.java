package com.gzhd.web.action;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
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
		@Result(name = "myCount",location = "frontUser!myCount.action", type = "redirectAction"),
		@Result(name = "toList", location = "betmessage!listBackBetMessage.action", type = "redirectAction") })
@Scope("prototype")
public class BetMessageAction extends BaseAction<BetMessageModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//private static final Logger logger = Logger.getLogger(BetMessageAction.class);

	@Resource(name = BetMessageService.BEAN_NAME)
	private BetMessageService betMessageService;
	@Resource(name = FrontUserService.BEAN_NAME)
	private FrontUserService frontUserService;

	public void addBetMessage() {
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		model.setBetDate(currentTime);
		FrontUserModel frontUserModel = frontUserService.getUserById(model
				.getBetPerson());
		if (!frontUserModel.equals("") && frontUserModel != null) {
			double yue = frontUserModel.getBalance();
			double amount = Double.valueOf(model.getBetQuan())
					* model.getBetPrice();
			if (yue >= amount) {
				frontUserModel.setBalance(amount*(-1));
				frontUserService.updateUserBalanceById(frontUserModel);
				String id = betMessageService.addBetMessage(model);
				if (id != null) {
					writeJsonToJsp("投注成功");
				} else {
					writeJsonToJsp("投注失败，请重新下注");
				}
			} else {
				writeJsonToJsp("金额不足，请联系客服人员充值");
			}

		}

	}
	
	public String bankRecharge()  {
		
		Map params  =  ActionContext.getContext().getParameters();	
		 String[] result=	(String[]) params.get("paymentResult");	
		try {
			Document doc =  DocumentHelper.parseText(result[0]);
			Element rootElt = doc.getRootElement(); // 获取根节点
			Element gateWayRsp = rootElt.element("GateWayRsp"); 
			Element head = gateWayRsp.element("head"); 
			String  rspCode= head.elementText(("RspCode"));
			
			Element body = gateWayRsp.element("body"); 
			String  amount= body.elementText(("Amount"));
			String  attach= body.elementText(("Attach"));	
	        if(rspCode.equals("000000")){
				String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
				model.setBetDate(currentTime);
				FrontUserModel frontUserModel = frontUserService.getUserById(attach);
				if (!frontUserModel.equals("") && frontUserModel != null) {
					BigDecimal   b   =   new   BigDecimal(Double.valueOf(amount));
					 double   f1   =   b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
						frontUserModel.setBalance(f1);
						frontUserService.updateUserBalanceById(frontUserModel);	
	            }
			 
	        }			
			     
		} catch (DocumentException e) {	
			e.printStackTrace();
		}
		ActionContext.getContext().put("bankRecharge", "充值成功，请查询余额");
		 return "myCount";  

	}

	/**
	 * 跳转后台查看用户投注信息界面
	 */

	public String listBackBetMessage() {

		PageModel pageModel = betMessageService.getForPageModel(
				model.getPageNum(), ConstantValues.PAGE_SIZE, model);

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

	/**
	 * 修改投注信息
	 */

	public String updateBetMessage() {

		betMessageService.updateBetMessage(model);

		return "toList";
	}

}
