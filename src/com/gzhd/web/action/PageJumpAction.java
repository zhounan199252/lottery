
package com.gzhd.web.action;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;



@Action(value = "pageJump", results = { 
		@Result(name = "toHighFrequency", location = "/WEB-INF/pages/highFrequency/index.jsp"),
		@Result(name = "toGd11x5", location = "/WEB-INF/pages/highFrequency/gd11x5.jsp"),
		@Result(name = "toSsq", location = "/WEB-INF/pages/highFrequency/ssq.jsp"),
		@Result(name = "toDlt", location = "/WEB-INF/pages/highFrequency/dlt.jsp"),
		@Result(name = "toCqssc", location = "/WEB-INF/pages/highFrequency/cqssc.jsp"),
		@Result(name = "toBjpk10", location = "/WEB-INF/pages/highFrequency/bjpk10.jsp"),
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
	 * 高频彩票
	 */
	public String toGd11x5() {
		return "toGd11x5";
	}
	/**
	 * 高频彩票
	 */
	public String toSsq() {
		return "toSsq";
	}
	/**
	 * 高频彩票
	 */
	public String toDlt() {
		return "toDlt";
	}
	/**
	 * 高频彩票
	 */
	public String toCqssc() {
		return "toCqssc";
	}
	/**
	 * 高频彩票
	 */
	public String toBjpk10() {
		return "toBjpk10";
	}
	
	/**
	 * 账户充值
	 */
	public String toBankRecharge() {
		return "toBankRecharge";
	}
	
}
