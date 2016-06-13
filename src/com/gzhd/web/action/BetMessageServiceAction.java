package com.gzhd.web.action;



import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.springframework.context.annotation.Scope;

import com.gzhd.model.BetMessageModel;
import com.gzhd.service.itf.BetMessageService;
import com.gzhd.util.TimeUtil;


@Action(value = "betmessage", results = { 
})
@Scope("prototype")
public class BetMessageServiceAction  extends BaseAction<BetMessageModel>  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(BetMessageServiceAction.class);

	@Resource(name = BetMessageService.BEAN_NAME)
	private BetMessageService betMessageService;

	
	
	public void addBetMessage() {
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		model.setBetDate(currentTime);
		String id= betMessageService.addBetMessage(model);
		writeJsonToJsp(id);
	}


}
