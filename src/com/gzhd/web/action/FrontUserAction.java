
package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.google.gson.JsonObject;
import com.gzhd.common.ConstantValues;
import com.gzhd.model.FrontUserModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.FrontUserService;
import com.gzhd.util.Des;
import com.gzhd.util.TimeUtil;
import com.opensymphony.xwork2.ActionContext;


@Action(value = "frontUser", results = { //
		@Result(name = "list", location = "/WEB-INF/pages/back_page/front_user/userList.jsp"), //
		@Result(name = "toList", location = "frontUser!listFrontUser.action", type = "redirectAction"),//
		@Result(name = "add", location = "/WEB-INF/pages/back_page/front_user/addUser.jsp"),//
		@Result(name = "edit", location = "/WEB-INF/pages/back_page/front_user/editUser.jsp"),//
		@Result(name = "toRechargePage", location = "/WEB-INF/pages/back_page/front_user/recharge.jsp"),//
		@Result(name = "toDefault", location = "frontIndex!toDefault.action", type = "redirectAction")//
})
@Scope("prototype")
public class FrontUserAction extends BaseAction<FrontUserModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(FrontUserAction.class);

	@Resource(name = FrontUserService.BEAN_NAME)
	private FrontUserService service;
	
	public void frontLogin() {

		JsonObject json = new JsonObject();

		String sessionCode = (String) ActionContext.getContext().getSession().get(ConstantValues.FRONT_SESSION_CODE);

		if (!model.getCode().equals(sessionCode)) {
			json.addProperty("success", false);
			json.addProperty("message", "验证码错误，请刷新后重新登陆！");
		} else {
			
			String firstKey = (String)ActionContext.getContext().getSession().get("firstKey_f");
			String secondKey = (String)ActionContext.getContext().getSession().get("secondKey_f");
			String thirdKey = (String)ActionContext.getContext().getSession().get("thirdKey_f");
			
			String passwordDesc = Des.strDec(model.getPassword(), firstKey, secondKey, thirdKey);   //对密码进行解密
			
			model.setPassword(passwordDesc);
			
			FrontUserModel u = service.login(model);

			if (null == u) {
				json.addProperty("success", false);
				json.addProperty("message", "用户名或密码错误，请刷新后重新登陆！");
			} else {
				json.addProperty("success", true);
				json.addProperty("object", "/");

				// 若用户已经登陆，则移除登陆信息
				if (null != ActionContext.getContext().getSession().get(ConstantValues.FRONT_CURRENT_USER_LOGIN)) {
					ActionContext.getContext().getSession().remove(ConstantValues.FRONT_CURRENT_USER_LOGIN);
				}

				ActionContext.getContext().getSession().put(ConstantValues.FRONT_CURRENT_USER_LOGIN, u);

				service.updateLoginTimeById(u.getId(), TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss"));
			}
		}

		writeDataToJsp(json.toString());
	}

	public String listFrontUser() {

		PageModel pageModel = service.getForPageModel(model.getPageNum(), ConstantValues.PAGE_SIZE, model);

		ActionContext.getContext().put("pageModel", pageModel);

		return "list";
	}

	
	public String addFrontUserPage() {

		return "add";
	}

	
	public String addFrontUser() {
		
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		
		model.setRegisterTime(currentTime);

		service.addUser(model);

		return "toList";
	}

	
	public String editFrontUserPage() {

		FrontUserModel user = service.getUserById(model.getId());
		ActionContext.getContext().getValueStack().push(user);

		return "edit";
	}

	
	public String editFrontUser() {

		service.updateUser(model);

		return "toList";
	}

	
	public String deleteFrontUser() {

		service.deleteUserById(model.getId());

		return "toList";
	}

	
	public String initFrontUserPassword() {

		service.updatePasswordToDefault(model.getId());

		return "toList";
	}

	public void checkFrontUsernameIsExist() {
		
		boolean isExit = service.checkFrontUsernameIsExist(model.getUsername());
		
		writeJsonToJsp(isExit);
	}
	
	public String toRechargePage() {
		
		FrontUserModel user = service.getUserById(model.getId());
		ActionContext.getContext().getValueStack().push(user);
		
		return "toRechargePage";
	}
	
	public String recharge() {
		
		service.updateUserBalanceById(model);
		
		return "toList";
	}
	
	
	public String register() {
		
		String firstKey = (String)ActionContext.getContext().getSession().get("firstKey_fr");
		String secondKey = (String)ActionContext.getContext().getSession().get("secondKey_fr");
		String thirdKey = (String)ActionContext.getContext().getSession().get("thirdKey_fr");
		
		String passwordDesc = Des.strDec(model.getPassword(), firstKey, secondKey, thirdKey);   //对密码进行解密
		
		model.setPassword(passwordDesc);
		
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		
		model.setRegisterTime(currentTime);

		service.addUser(model);
		
		return "toDefault";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
