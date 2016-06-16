package com.gzhd.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.FootballBet;
import com.gzhd.domain.FrontUser;
import com.gzhd.model.FootballBetModel;
import com.gzhd.service.itf.FootballBetService;

@Service(value=FootballBetService.BEAN_NAME)
public class FootballBetServiceImpl implements FootballBetService {
	
	@Resource(name=BaseDao.BEAN_NAME)
	private BaseDao<FootballBet> baseDao;
	
	@Resource(name=BaseDao.BEAN_NAME)
	private BaseDao<FrontUser> frontUserDao;

	@Override
	public String addFootballBet(FootballBetModel model, String userId, String curTime) {

		FrontUser frontUser = frontUserDao.get(FrontUser.class, userId);
		
		String[] datas = model.getData().split("&");
		
		FootballBet footballBet = null;
		
		for(String singleData : datas) {
			
			//33676;英格兰;威尔士;2016-06-16 20:45:00;1.42;无;胜;倍数
			String[] singleDatas = singleData.split(";");
			
			footballBet = new FootballBet();
			
			footballBet.setHomeTeam(singleDatas[1]);
			footballBet.setAwayTeam(singleDatas[2]);
			footballBet.setOdds(singleDatas[4]);
			footballBet.setBetTime(curTime);
			footballBet.setMultiple(Integer.parseInt(singleDatas[7]));
			footballBet.setUser(frontUser);
			footballBet.setRangQiu(singleDatas[5]);
			footballBet.setWinOrLose(singleDatas[6]);
			
			baseDao.save(footballBet);
		}
		
		return "ok";
	}

	
}
