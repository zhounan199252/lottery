package com.gzhd.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.gzhd.dao.itf.BaseDao;
import com.gzhd.domain.BackUser;
import com.gzhd.domain.FootballBet;
import com.gzhd.domain.FrontUser;
import com.gzhd.model.FootballBetModel;
import com.gzhd.model.FrontUserModel;
import com.gzhd.model.PageModel;
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
		
		
		double balance = frontUser.getBalance();
		double remain = balance - model.getTotalCount();
		
		if(remain < 0) {   //如果余额不足
			return "";
		}
		
		String[] datas = model.getData().split("&");
		
		FootballBet footballBet = null;
		
		for(String singleData : datas) {
			
			//33676;英格兰;威尔士;2016-06-16 20:45:00;1.42;无;胜;倍数
			String[] singleDatas = singleData.split(";");
			
			footballBet = new FootballBet();
			
			footballBet.setHomeTeam(singleDatas[1]);
			footballBet.setAwayTeam(singleDatas[2]);
			footballBet.setOdds(Double.parseDouble(singleDatas[4]));
			footballBet.setBetTime(curTime);
			footballBet.setMultiple(Integer.parseInt(singleDatas[8]));
			footballBet.setUser(frontUser);
			footballBet.setRangQiu(singleDatas[5]);
			footballBet.setWinOrLose(singleDatas[6]);
			footballBet.setMatchTime(singleDatas[7]);
			
			baseDao.save(footballBet);
		}
		
		frontUser.setBalance(remain);
		
		frontUserDao.update(frontUser);   //更新账户余额
		
		return "ok";
	}

	@Override
	public PageModel getForPageModel(int pageNum, int pageSize, FootballBetModel model) {


		Map<String, Object> params = new HashMap<String, Object>();
		StringBuffer queryHql = new StringBuffer("from FootballBet b where 1=1 ");
		
		if(null != model.getUser() && StringUtils.isNotBlank(model.getUser().getNickname())) {
			queryHql.append(" and b.user.nickname like :nickname");
			params.put("nickname", "%%" + model.getUser().getNickname() + "%%");
		}
		
		if(StringUtils.isNotBlank(model.getHomeTeam())) {
			queryHql.append(" and b.homeTeam like :homeTeam");
			params.put("homeTeam", "%%" + model.getHomeTeam() + "%%");
		}
		
		if(StringUtils.isNotBlank(model.getAwayTeam())) {
			queryHql.append(" and b.awayTeam like :awayTeam");
			params.put("awayTeam", "%%" + model.getAwayTeam() + "%%");
		}
		
		if(StringUtils.isNotBlank(model.getIsFulfil())) {
			queryHql.append(" and b.isFulfil like :isFulfil");
			params.put("isFulfil", "%%" + model.getIsFulfil() + "%%");
		}
		
		if(StringUtils.isNotBlank(model.getWinOrLose())) {
			queryHql.append(" and b.winOrLose like :winOrLose");
			params.put("winOrLose", "%%" + model.getWinOrLose() + "%%");
		}
		
		
		if(StringUtils.isNotBlank(model.getBetTimeBegin())) {
			queryHql.append(" and b.betTime >= :betTimeBegin");
			params.put("betTimeBegin", model.getBetTimeBegin());
		}
		
		if(StringUtils.isNotBlank(model.getBetTimeEnd())) {
			queryHql.append(" and b.betTime <= :betTimeEnd");
			params.put("betTimeEnd", model.getBetTimeEnd());
		}
		
		if(StringUtils.isNotBlank(model.getMatchTimeBegin())) {
			queryHql.append(" and b.matchTime >= :matchTimeBegin");
			params.put("matchTimeBegin", model.getMatchTimeBegin());
		}
		
		if(StringUtils.isNotBlank(model.getMatchTimeEnd())) {
			queryHql.append(" and b.matchTime <= :matchTimeEnd");
			params.put("matchTimeEnd", model.getMatchTimeEnd());
		}

		queryHql.append(" order by b.isFulfil asc, b.betTime desc"); // 

		List<FootballBet> list = baseDao.find(queryHql.toString(), params, pageNum, pageSize);

		List<FootballBetModel> userModels = new ArrayList<FootballBetModel>();
		for (FootballBet u : list) {
			FootballBetModel footballBetModel = new FootballBetModel();
			BeanUtils.copyProperties(u, footballBetModel);
			userModels.add(footballBetModel);
		}

		StringBuffer countHql = new StringBuffer("select count(1) ").append(queryHql);
		int allRows = baseDao.count(countHql.toString(), params).intValue();

		return new PageModel(pageNum, pageSize, list, allRows);
	}

	@Override
	public void deleteFootballBet(String id) {

		String[] ids = id.split(",");
		
		for(String sigleId : ids) {
			FootballBet footballBet = baseDao.get(FootballBet.class, sigleId);

			baseDao.delete(footballBet);
		}
		
	}

	@Override
	public void updateFulfilStatus(String id) {

		String[] ids = id.split(",");
		
		for(String sigleId : ids) {
			FootballBet footballBet = baseDao.get(FootballBet.class, sigleId);
			
			footballBet.setIsFulfil("yes");

			baseDao.update(footballBet);
		}
		
	}

	
}
