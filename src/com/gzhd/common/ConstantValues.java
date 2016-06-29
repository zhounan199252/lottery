package com.gzhd.common;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:系统所有常量
 * @time:2015年7月24日 下午4:34:14
 */
public class ConstantValues {
	
	/**
	 * 超级管理员的用户名
	 */
	public static final String ADMINISTRATOR_USERNAME = "admin";

	 
	/**
	 * 前台已登录用户
	 */
	public static final String FRONT_CURRENT_USER_LOGIN = "frontCurrentLoginUser";
	
	/**
	 * 后台已登录用户
	 */
	public static final String BACK_CURRENT_USER_LOGIN = "backCurrentLoginUser";
	
	
	/**
	 * 后台当前验证码 
	 */
	public static final String BACK_SESSION_CODE = "backSessionCode";
	
	/**
	 * 前台当前验证码
	 */
	public static final String FRONT_SESSION_CODE = "frontSessionCode";
	
	
	/**
	 * 分页大小
	 */
	public static final int PAGE_SIZE = 10;
	
	/**
	 * 中奖金额
	 */
	
	public static  Map<String, String> getAwardMoney(){
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("r2", "6");
		map.put("r3", "19");
		map.put("r4", "78");
		map.put("r5", "540");
		map.put("r6", "90");
		map.put("r7", "26");
		map.put("r8", "9");
		map.put("q1", "13");
		map.put("q2", "130");
		map.put("q3", "1170");
		map.put("x1", "10");
		map.put("x2", "100");
		map.put("x3", "1000");
		map.put("x5", "100000");
		
		map.put("s0", "0");
		map.put("s1", "0");
		map.put("s2", "0");
		map.put("s3", "3000");
		map.put("s4", "200");
		map.put("s5", "10");
		map.put("s6", "5");
		
		
		map.put("d0", "0");
		map.put("d1", "0");
		map.put("d2", "0");
		map.put("d3", "0");
		map.put("d4", "200");
		map.put("d5", "10");
		map.put("d6", "5");
		return map;
		
		
		
	}
	
}
