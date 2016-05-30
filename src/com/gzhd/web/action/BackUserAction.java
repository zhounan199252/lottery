
package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.google.gson.JsonObject;
import com.gzhd.common.ConstantValues;
import com.gzhd.model.BackUserModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.BackUserService;
import com.gzhd.util.TimeUtil;
import com.opensymphony.xwork2.ActionContext;

/**
 * @Description:user 的action处理类
 * @author:黄威生
 * @time:2015年7月28日 上午10:05:24
 */
@Action(value = "backUser", results = { //
		@Result(name = "list", location = "/WEB-INF/pages/back_page/user/userList.jsp"), //
		@Result(name = "toList", location = "backUser!listBackUser.action", type = "redirectAction"),//
		@Result(name = "add", location = "/WEB-INF/pages/back_page/user/addUser.jsp"),//
		@Result(name = "edit", location = "/WEB-INF/pages/back_page/user/editUser.jsp")//
})
@Scope("prototype")
public class BackUserAction extends BaseAction<BackUserModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(BackUserAction.class);

	@Resource(name = BackUserService.BEAN_NAME)
	private BackUserService service;

	
	public void backLogin() {

		JsonObject json = new JsonObject();

		String sessionCode = (String) ActionContext.getContext().getSession().get(ConstantValues.SESSION_CODE);

		if (!model.getCode().equals(sessionCode)) {
			json.addProperty("success", false);
			json.addProperty("message", "验证码错误，请刷新后重新登陆！");
		} else {
			BackUserModel u = service.login(model);

			if (null == u) {
				json.addProperty("success", false);
				json.addProperty("message", "用户名或密码错误，请刷新后重新登陆！");
			} else {
				json.addProperty("success", true);
				json.addProperty("object", "backIndex!toBackIndex.action");

				// 若用户已经登陆，则移除登陆信息
				if (null != ActionContext.getContext().getSession().get(ConstantValues.BACK_CURRENT_USER_LOGIN)) {
					ActionContext.getContext().getSession().remove(ConstantValues.BACK_CURRENT_USER_LOGIN);
				}

				ActionContext.getContext().getSession().put(ConstantValues.BACK_CURRENT_USER_LOGIN, u);

				service.updateLoginTimeById(u.getId(), TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss"));
			}
		}

		writeDataToJsp(json.toString());
	}

	public String listBackUser() {

		PageModel pageModel = service.getForPageModel(model.getPageNum(), ConstantValues.PAGE_SIZE, model);

		ActionContext.getContext().put("pageModel", pageModel);

		return "list";
	}

	
	public String addBackUserPage() {

		return "add";
	}

	
	public String addBackUser() {
		
		String currentTime = TimeUtil.getCurDate("yyyy-MM-dd HH:mm:ss");
		
		model.setRegisterTime(currentTime);

		service.addUser(model);

		return "toList";
	}

	
	public String editBackUserPage() {

		BackUserModel user = service.getUserById(model.getId());
		ActionContext.getContext().getValueStack().push(user);

		return "edit";
	}

	
	public String editBackUser() {

		service.updateUser(model);

		return "toList";
	}

	
	public String deleteBackUser() {

		service.deleteUserById(model.getId());

		return "toList";
	}

	
	public String initBackUserPassword() {

		service.updatePasswordToDefault(model.getId());

		return "toList";
	}

	public void checkBackUsernameIsExist() {
		
		boolean isExit = service.checkBackUsernameIsExist(model.getUsername());
		
		writeJsonToJsp(isExit);
	}
}
