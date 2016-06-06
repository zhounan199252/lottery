package com.gzhd.web.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;

import com.gzhd.common.ConstantValues;
import com.gzhd.model.AnnouncementModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.AnnouncementService;
import com.gzhd.util.SecurityHelper;
import com.opensymphony.xwork2.ActionContext;

@Action(value = "frontAnnouncement", results = { //
		@Result(name = "toAnnouncementList", location = "/WEB-INF/pages/front_page/announcement/announcementList.jsp"),//
		@Result(name = "toFavorList", location = "/WEB-INF/pages/front_page/announcement/announcementList.jsp")//
})
@Scope("prototype")
public class FrontAnnouncementAction extends BaseAction<AnnouncementModel> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Resource(name=AnnouncementService.BEAN_NAME)
	private AnnouncementService service;

	public String announcementList() {
		
		PageModel pageModel = service.getForPageModel(model.getPageNum(), ConstantValues.PAGE_SIZE, model);
		
		ActionContext.getContext().put("pageModel", pageModel);
		
		return "toAnnouncementList";
	}
	
	public String getSingleAnnouncement() {
		
		String id = model.getId();
		
		System.out.println(id);
		
		try {
			id = SecurityHelper.decode(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.setId(id);
		
		
		return "";
	}
}



















































