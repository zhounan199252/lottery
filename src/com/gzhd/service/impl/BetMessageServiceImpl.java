package com.gzhd.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.Announcement;
import com.gzhd.domain.BetMessage;
import com.gzhd.model.AnnouncementModel;
import com.gzhd.model.BetMessageModel;
import com.gzhd.model.PageModel;
import com.gzhd.service.itf.BetMessageService;
import com.gzhd.service.itf.FrontUserService;



@Service(BetMessageService.BEAN_NAME)
public class BetMessageServiceImpl  implements BetMessageService {
	
	private static final Logger logger = Logger.getLogger(BackUserServiceImpl.class);

	@Resource(name = BaseDao.BEAN_NAME)
	private BaseDao<BetMessage> baseDao;
	@Resource(name = FrontUserService.BEAN_NAME)
	private FrontUserService frontUserService;
	
	
	@Override
	public String addBetMessage(BetMessageModel model) {
		BetMessage betMessage= new BetMessage();

		BeanUtils.copyProperties(model, betMessage);
		Serializable s = baseDao.save(betMessage);
		
		return (String) s;
	}

	@Override
	public PageModel getForPageModel(int pageNum, int pageSize,
			BetMessageModel model) {
	
Map<String, Object> params = new HashMap<String, Object>();
		
		StringBuilder queryHql = new StringBuilder("from BetMessage a where 1=1 ");
		
		if(StringUtils.isNotBlank(model.getBetType())) {
			queryHql.append(" and a.betType = :betType");
			params.put("betType", model.getBetType());
		}
		
		if(StringUtils.isNotBlank(model.getBetPersonName())) {		
		model.setBetPerson( frontUserService.getIdByFrontUsername(model.getBetPersonName()));	  	
		}
		
		
		if(StringUtils.isNotBlank(model.getBetPerson())) {
			queryHql.append(" and a.betPerson = :betPerson");
			params.put("betPerson",model.getBetPerson());
		}
		if(StringUtils.isNotBlank(model.getBetPeriod())) {
			queryHql.append(" and a.betPeriod = :betPeriod");
			params.put("betPeriod",model.getBetPeriod());
		}
			
		queryHql.append(" order by a.betDate desc");
		
		List<BetMessage> list = baseDao.find(queryHql.toString() , params);
		
		List<BetMessageModel> modelList = new ArrayList<BetMessageModel>();
		
		for(BetMessage betMessage: list) {
			BetMessageModel betMessageModel = new BetMessageModel();
			
			BeanUtils.copyProperties(betMessage, betMessageModel);
				betMessageModel.setBetPersonName(frontUserService.getUserById(betMessageModel.getBetPerson()).getUsername()) ;	
			modelList.add(betMessageModel);
		}
		
		StringBuffer countHql = new StringBuffer("select count(1) ").append(queryHql);
		int allRows = baseDao.count(countHql.toString(), params).intValue();

		return new PageModel(pageNum, pageSize, modelList, allRows);
	}


}
