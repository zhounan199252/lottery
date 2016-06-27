package com.gzhd.service.impl;


import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.OpenMessage;
import com.gzhd.model.OpenMessageModel;
import com.gzhd.service.itf.OpenMessageService;

@Service(OpenMessageService.BEAN_NAME)
public class OpenMessageServiceImpl implements OpenMessageService {

	
	
	
	@Resource(name = BaseDao.BEAN_NAME)
	private BaseDao<OpenMessage> baseDao;
	
	@Override
	public String addOpenMessage(OpenMessageModel model) {
		
		OpenMessage openMessage= new OpenMessage();

		BeanUtils.copyProperties(model, openMessage);
		baseDao.save(openMessage);
		
		return null;
	}

	@Override
	public OpenMessageModel getOpenMessage(OpenMessageModel model) {
	     
		Map<String, Object> params = new HashMap<String, Object>();

		StringBuilder queryHql = new StringBuilder(
				"from OpenMessage a where 1=1 ");

		if (StringUtils.isNotBlank(model.getType())) {
			queryHql.append(" and a.type like :type");
			params.put("type", "%%" + model.getType() + "%%" );
		}
        
		if (StringUtils.isNotBlank(model.getExpect())) {
			queryHql.append(" and a.expect like :expect");
			params.put("expect", "%%" + model.getExpect() + "%%" );
		}
		
		OpenMessage openMessage=baseDao.get(queryHql.toString(), params);
		if(openMessage!=null){
			BeanUtils.copyProperties(openMessage,model);	
		}else{
			model =null;
		}

		return model;
	}



}
