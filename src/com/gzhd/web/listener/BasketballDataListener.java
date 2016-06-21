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

public class BasketballDataListener implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(BasketballDataListener.class);

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

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
	 * @param 获取篮球
	 *            上一天，当天，后一天的赛事数据
	 */
	private void getFootballData(ServletContext application) {

		String dataUrl = "http://api.caipiaokong.com/live/?name=jclq&format=json&uid=420845&token=4d5aa35ebeb48e7d3e4c8f7e16e1c7942c4cebee&phase=";

		BufferedReader br = null;
		URL url = null;
		HttpURLConnection con = null;
		StringBuilder response = null;
		String inputLine = "";

		try {
			String lastDayUrl = dataUrl + TimeUtil.dateFormat(TimeUtil.getDateRelateToDate(new Date(), -1), "yyyyMMdd");
			url = new URL(lastDayUrl);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}

			String json = null;

			if (response.toString().length() > 100) {

				json = response.toString().replaceAll("\"0\"", "\"t0\"").replaceAll("\"1\"", "\"t1\"").replaceAll("\"3\"", "\"t3\"");
				application.setAttribute("currentDayBasketballData", json);
				//logger.info("json1:" + json);
			}
			Thread.sleep(5000); // 先睡眠5秒，否则接口网站会认为恶意操作
			// ==========================================
			String nextDayUrl = dataUrl + TimeUtil.getCurDate("yyyyMMdd");
			url = new URL(nextDayUrl);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}

			if (response.toString().length() > 100) {

				json = response.toString().replaceAll("\"0\"", "\"t0\"").replaceAll("\"1\"", "\"t1\"").replaceAll("\"3\"", "\"t3\"");
				application.setAttribute("nextDayBasketballData", json);
				//logger.info("json2:" + json);
			}
			Thread.sleep(5000);
			// ==========================================
			String next2DayUrl = dataUrl + TimeUtil.dateFormat(TimeUtil.getDateRelateToDate(new Date(), 1), "yyyyMMdd");
			url = new URL(next2DayUrl);

			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}

			if (response.toString().length() > 100) {
				json = response.toString().replaceAll("\"0\"", "\"t0\"").replaceAll("\"1\"", "\"t1\"").replaceAll("\"3\"", "\"t3\"");
				application.setAttribute("next2DayBasketballData", json);
				//logger.info("json3:" + json);
			}
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
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
