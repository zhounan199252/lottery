
package com.gzhd.web.action;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;



@Action(value = "pageJump", results = { 
		@Result(name = "toHighFrequency", location = "/WEB-INF/pages/highFrequency/index.jsp"),
		@Result(name = "toBankRecharge", location = "/WEB-INF/pages/highFrequency/recharge.jsp")
	
})


/**
 * 用于页面间的跳转
 */
@Scope("prototype")
public class PageJumpAction  extends BaseAction<Object>{


	/**
	 * 高频彩票
	 */
	public String toHighFrequency() {
		return "toHighFrequency";
	}
	
	/**
	 * 账户充值
	 */
	public String toBankRecharge() {
		return "toBankRecharge";
	}
	
}
