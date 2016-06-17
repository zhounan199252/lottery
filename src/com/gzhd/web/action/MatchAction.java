
package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.domain.FrontUser;
import com.gzhd.model.FrontUserModel;
import com.gzhd.service.itf.FrontUserService;
import com.opensymphony.xwork2.ActionContext;

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
	
	@Resource(name = FrontUserService.BEAN_NAME)
	private FrontUserService service;

	public String toMatchIndex() {
		
		FrontUserModel user = (FrontUserModel) ActionContext.getContext().getSession().get(ConstantValues.FRONT_CURRENT_USER_LOGIN);
		
		if(null != user) {
			FrontUserModel userModel = service.getUserById(user.getId());
			
			ActionContext.getContext().put("balance", userModel.getBalance());
		}
		
		return "matchIndex";
	}
}
