
package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.model.FootballBetModel;
import com.gzhd.model.FrontUserModel;
import com.gzhd.service.itf.FootballBetService;
import com.gzhd.util.TimeUtil;
import com.opensymphony.xwork2.ActionContext;


@Action(value = "footballBet", results = { //
		@Result(name = "toMatch", location = "match!toMatchIndex.action", type = "redirectAction"),//
})
@Scope("prototype")
public class FootballBetAction extends BaseAction<FootballBetModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(FootballBetAction.class);
	
	@Resource(name=FootballBetService.BEAN_NAME)
	private FootballBetService service;
	

	public String addFootballBet() {
		
		FrontUserModel userModel = (FrontUserModel) ActionContext.getContext().getSession().get(ConstantValues.FRONT_CURRENT_USER_LOGIN);
		
		String curtime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		
		service.addFootballBet(model, userModel.getId(), curtime);
		
		return "toMatch";
	}
}
