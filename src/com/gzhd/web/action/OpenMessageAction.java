package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.model.BetMessageModel;
import com.gzhd.model.OpenMessageModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.BetMessageService;
import com.gzhd.service.itf.OpenMessageService;
import com.opensymphony.xwork2.ActionContext;


@Action(value = "openMessage", results = { 
		@Result(name = "openMessage", location = "/WEB-INF/pages/highFrequency/openMessage.jsp"),
		@Result(name = "ylsfcAddCode", location = "/WEB-INF/pages/highFrequency/ylsfcAddCode.jsp"),
		@Result(name = "toList", location = "openMessage!openMessage.action", type = "redirectAction")
		
	
	
})


/**
 * 管理永乐十分彩
 */
@Scope("prototype")
public class OpenMessageAction  extends BaseAction<OpenMessageModel>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Resource(name = OpenMessageService.BEAN_NAME)
	private OpenMessageService openMessageService;
	
	
	/**
	 * 后台查看开奖信息
	 */
	public String openMessage() {
		PageModel pageModel = openMessageService.getForPageModel(
				model.getPageNum(), ConstantValues.PAGE_SIZE, model);

		ActionContext.getContext().put("pageModel", pageModel);
		return "openMessage";
	}
	
	
	/**
	 * 后台添加永乐十分彩开奖号码
	 */
	public String ylsfcAddCode() {
		return "ylsfcAddCode";
	}
	
	/**
	 * 后台添加永乐十分彩开奖号码
	 */
	public String saveYlsfcCode() {
	    String  opencode=model.getOpencode();
		  int total=opencode.length()/5;
		
		  for(int i=0;i<total;i++){
			  model.setOpencode(opencode.substring(0+5*i, 5+5*i));
			  model.setExpect(i+1+"");
			  openMessageService.addOpenMessage(model);
		  }
		return "toList";
	}
	
	
	
	/**
	 * 删除
	 */
	public String deleteById() {

		openMessageService.deleteById(model.getId());

		return "toList";
	}

}
