package com.gzhd.service.itf;

import com.gzhd.model.FootballBetModel;

public interface FootballBetService {

	public static final String BEAN_NAME = "com.gzhd.service.itf.FootballBetService";
	
	public String addFootballBet(FootballBetModel model, String userId, String curTime);
}
