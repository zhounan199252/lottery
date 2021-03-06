package com.gzhd.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.Announcement;
import com.gzhd.model.AnnouncementModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.AnnouncementService;

@Service(value=AnnouncementService.BEAN_NAME)
public class AnnouncementServiceImpl implements AnnouncementService {
	
	@Resource(name=BaseDao.BEAN_NAME)
	private BaseDao<Announcement> baseDao;

	@Override
	public PageModel getForPageModel(int pageNum, int pageSize, AnnouncementModel model) {

		Map<String, Object> params = new HashMap<String, Object>();
		
		StringBuilder queryHql = new StringBuilder("from Announcement a where 1=1 ");
		
		if(StringUtils.isNotBlank(model.getType())) {
			queryHql.append(" and a.type = :type");
			params.put("type", model.getType());
		}
		
		if(StringUtils.isNotBlank(model.getTitle())) {
			queryHql.append(" and a.title like :title");
			params.put("title", model.getTitle());
		}
		
		if(StringUtils.isNotBlank(model.getPublishTimeBegin())) {
			queryHql.append(" and a.publishTime >= :publishTimeBegin");
			params.put("publishTimeBegin", model.getPublishTimeBegin());
		}
		
		if(StringUtils.isNotBlank(model.getStatus())) {
			queryHql.append(" and a.status = :status");
			params.put("status", model.getStatus());
		}
		
		if(StringUtils.isNotBlank(model.getPublishTimeEnd())) {
			queryHql.append(" and a.publishTime <= :publishTimeEnd");
			params.put("publishTimeEnd", model.getPublishTimeEnd());
		}
		
		queryHql.append(" order by a.publishTime desc, a.editTime desc");
		
		List<Announcement> list = baseDao.find(queryHql.toString() , params);
		
		List<AnnouncementModel> modelList = new ArrayList<AnnouncementModel>();
		
		for(Announcement announcement : list) {
			AnnouncementModel announcementModel = new AnnouncementModel();
			
			BeanUtils.copyProperties(announcement, announcementModel);
			
			modelList.add(announcementModel);
		}
		
		StringBuffer countHql = new StringBuffer("select count(1) ").append(queryHql);
		int allRows = baseDao.count(countHql.toString(), params).intValue();

		return new PageModel(pageNum, pageSize, list, allRows);
	}

	@Override
	public String addAnnouncement(AnnouncementModel model) {

		Announcement announcement = new Announcement();
		
		BeanUtils.copyProperties(model, announcement);
		
		Serializable res = baseDao.save(announcement);
		
		return (String)res;
	}

	@Override
	public AnnouncementModel getAnnouncementById(String id) {

		Announcement announcement = baseDao.get(Announcement.class, id);
		
		AnnouncementModel model = new AnnouncementModel();
		
		BeanUtils.copyProperties(announcement, model);
		
		return model;
	}

	@Override
	public void editAnnouncement(AnnouncementModel model) {

		Announcement announcement = baseDao.get(Announcement.class, model.getId());
		
		BeanUtils.copyProperties(model, announcement, new String[]{"publishTime", "editTime", "status"});
		
		baseDao.update(announcement);
		
	}

	@Override
	public void deleteAnnouncement(String id) {

		String[] ids = id.split(",");
		
		for(String singleId : ids) {
			
			Announcement announcement = baseDao.get(Announcement.class, singleId);
			
			baseDao.delete(announcement);
		}
		
	}

	@Override
	public void updateAnnouncementStatus(AnnouncementModel model) {
		
		String[] ids = model.getId().split(",");
		
		for(String id : ids) {
			Announcement announcement = baseDao.get(Announcement.class, id);
			
			announcement.setPublishTime(model.getPublishTime());
			announcement.setStatus(model.getStatus());
			
			baseDao.update(announcement);
		}
	}
}
































