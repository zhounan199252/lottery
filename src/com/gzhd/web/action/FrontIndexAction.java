
package com.gzhd.web.action;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.model.BackUserModel;


@Action(value = "frontIndex", results = { //
		@Result(name = "toDefault", location = "/WEB-INF/pages/front_page/default.jsp")//
})
@Scope("prototype")
public class FrontIndexAction extends BaseAction<Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(FrontIndexAction.class);

	public String toDefault() {
		
		return "toDefault";
	}
	

}
