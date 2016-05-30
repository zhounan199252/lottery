
package com.gzhd.web.action;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.model.BackUserModel;


@Action(value = "backIndex", results = { //
		@Result(name = "toBackIndex", location = "/WEB-INF/pages/back_page/index.jsp"),//
		@Result(name = "toBackLogin", location = "/WEB-INF/pages/back_page/login.jsp"),//
		@Result(name = "toWelcomePage", location = "/WEB-INF/pages/back_page/welcome.jsp")//
})
@Scope("prototype")
public class BackIndexAction extends BaseAction<BackUserModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(BackIndexAction.class);

	public String toBackLogin() {
		
		return "toBackLogin";
	}
	
	public String toBackIndex() {
		
		return "toBackIndex";
	}
	
	public String toWelcomePage() {
		
		return "toWelcomePage";
	}

}
