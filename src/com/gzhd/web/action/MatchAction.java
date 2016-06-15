
package com.gzhd.web.action;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

/**
 * @Description:user 的action处理类
 * @time:2015年7月28日 上午10:05:24
 */
@Action(value = "match", results = { //
		@Result(name = "toBackLogin", location = "backIndex!toBackLogin.action", type = "redirectAction"),//
		@Result(name = "matchIndex", location = "/WEB-INF/pages/front_page/match/index.jsp")//
})
@Scope("prototype")
public class MatchAction extends BaseAction<Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(MatchAction.class);

	public String toMatchIndex() {
		
		return "matchIndex";
	}
}
