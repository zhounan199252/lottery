package com.gzhd.web.listener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.gzhd.util.StringUtil;
import com.gzhd.util.TimeUtil;

public class FootballDataListener implements ServletContextListener {
	
	private static final Logger logger = Logger.getLogger(FootballDataListener.class);

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {

		final ServletContext application = sce.getServletContext();

		Timer timer = new Timer();

		timer.schedule(new TimerTask() {

			@Override
			public void run() {
				getFootballData(application);
			}
		}, 2000, 1000 * 60 * 10);
	}

	/**
	 * @param 获取 当天，后一天，后两天的赛事数据
	 */
	private void getFootballData(ServletContext application) {
		
		String dataUrl = "http://api.caipiaokong.com/live/?name=jczq&format=json&uid=420845&token=4d5aa35ebeb48e7d3e4c8f7e16e1c7942c4cebee&phase=" ;
		
		BufferedReader br = null;
		URL url = null;
		HttpURLConnection con = null;
		StringBuilder response = null;
		String inputLine = "";

		try {
			url = new URL(dataUrl + TimeUtil.getCurDate("yyyyMMdd"));
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}
			
			application.setAttribute("currentDayData", response.toString());
			logger.info("currentDayData: " + response.toString());
			
			//==========================================
			
			url = new URL(dataUrl + TimeUtil.dateFormat(TimeUtil.getDateRelateToDate(new Date(), 1), "yyyyMMdd"));
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}
			
			application.setAttribute("nextDayData", response.toString());
			logger.info("nextDayData: " + response.toString());
			
			//==========================================
			
			url = new URL(dataUrl + TimeUtil.dateFormat(TimeUtil.getDateRelateToDate(new Date(), 2), "yyyyMMdd"));
			
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}
			
			application.setAttribute("next2DayData", response.toString());
			logger.info("next2DayData: " + response.toString());
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != br) {
					br.close();
				}
			} catch (Exception e1) {
				logger.error(e1);
				e1.printStackTrace();
			}
		}
	}
}







































