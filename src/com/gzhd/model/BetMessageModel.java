package com.gzhd.model;

public class BetMessageModel {
	
	private String id;

	private String betPeriod;  //投注期数
	private String   betType;   //投注类型
	private String betPerson;   //投注人
	
	private String betQuan;    //投注数量
    
	
	private String betNum;   //投注号码

	private String betDate;    //投注日期
	
	private int pageNum = 1;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBetPeriod() {
		return betPeriod;
	}

	public void setBetPeriod(String betPeriod) {
		this.betPeriod = betPeriod;
	}

	public String getBetPerson() {
		return betPerson;
	}

	public void setBetPerson(String betPerson) {
		this.betPerson = betPerson;
	}

	public String getBetQuan() {
		return betQuan;
	}

	public void setBetQuan(String betQuan) {
		this.betQuan = betQuan;
	}

	public String getBetNum() {
		return betNum;
	}

	public void setBetNum(String betNum) {
		this.betNum = betNum;
	}

	public String getBetDate() {
		return betDate;
	}

	public void setBetDate(String betDate) {
		this.betDate = betDate;
	}
	
	
	public String getBetType() {
		return betType;
	}

	public void setBetType(String betType) {
		this.betType = betType;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	
}
