package com.gzhd.service.impl;

import java.io.Serializable;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.BetMessage;
import com.gzhd.model.BetMessageModel;
import com.gzhd.service.itf.BetMessageService;



@Service(BetMessageService.BEAN_NAME)
public class BetMessageServiceImpl  implements BetMessageService {
	
	private static final Logger logger = Logger.getLogger(BackUserServiceImpl.class);

	@Resource(name = BaseDao.BEAN_NAME)
	private BaseDao<BetMessage> baseDao;

	@Override
	public String addBetMessage(BetMessageModel model) {
		BetMessage betMessage= new BetMessage();

		BeanUtils.copyProperties(model, betMessage);
		Serializable s = baseDao.save(betMessage);
		
		return (String) s;
	}


}
