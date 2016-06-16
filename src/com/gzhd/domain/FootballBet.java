package com.gzhd.domain;

public class FootballBet {

	private String id;
	
	private FrontUser user;
	
	private String betTime;
	
	private String homeTeam;
	
	private String awayTeam;
	
	private String odds;
	
	private String rangQiu;
	
	private String winOrLose;
	
	private int multiple;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FrontUser getUser() {
		return user;
	}

	public void setUser(FrontUser user) {
		this.user = user;
	}

	public String getBetTime() {
		return betTime;
	}

	public void setBetTime(String betTime) {
		this.betTime = betTime;
	}

	public String getHomeTeam() {
		return homeTeam;
	}

	public void setHomeTeam(String homeTeam) {
		this.homeTeam = homeTeam;
	}

	public String getAwayTeam() {
		return awayTeam;
	}

	public void setAwayTeam(String awayTeam) {
		this.awayTeam = awayTeam;
	}

	public String getOdds() {
		return odds;
	}

	public void setOdds(String odds) {
		this.odds = odds;
	}

	public String getRangQiu() {
		return rangQiu;
	}

	public void setRangQiu(String rangQiu) {
		this.rangQiu = rangQiu;
	}

	public String getWinOrLose() {
		return winOrLose;
	}

	public void setWinOrLose(String winOrLose) {
		this.winOrLose = winOrLose;
	}

	public int getMultiple() {
		return multiple;
	}

	public void setMultiple(int multiple) {
		this.multiple = multiple;
	}

	
	
}
