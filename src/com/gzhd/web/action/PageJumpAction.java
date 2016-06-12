
package com.gzhd.web.action;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;


@Action(value = "pageJump", results = { 
		@Result(name = "toHighFrequency", location = "/WEB-INF/pages/highFrequency/index.jsp")
	
})


/**
 * 用于页面间的跳转
 */
@Scope("prototype")
public class PageJumpAction {


	/**
	 * 高频彩票
	 */
	public String toHighFrequency() {
		return "toHighFrequency";
	}
}
