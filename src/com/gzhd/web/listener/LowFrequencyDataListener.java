package com.gzhd.web.listener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Timer;
import java.util.TimerTask;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.gzhd.domain.OpenMessage;
import com.gzhd.model.OpenMessageModel;
import com.gzhd.service.itf.OpenMessageService;
import com.gzhd.util.StringUtil;


public class LowFrequencyDataListener implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(LowFrequencyDataListener.class);
	

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
				getHighFrequencyData(application);
			}
		}, 2000, 1000*60*60*24);
	}

	/**
	 * @param 获取十一选5等数据
	 *         
	 */
	private void getHighFrequencyData(ServletContext application) {
		ApplicationContext ac = WebApplicationContextUtils
				.getWebApplicationContext(application);
		final OpenMessageService openMessageService = (OpenMessageService) ac.getBean("com.gzhd.service.itf.OpenMessageService");

		String dataUrl = "http://f.apiplus.cn/ssq-01.json";

		BufferedReader br = null;
		URL url = null;
		HttpURLConnection con = null;
		StringBuilder response = null;
		String inputLine = "";  
		String  data= null;
		JSONArray jsonArray=null;
		JSONObject jsonObject = null;
		

		try {
			url = new URL(dataUrl);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}
			if (response.toString().length() > 100) {
				   data= response.toString();
				    jsonObject = JSONObject.parseObject(data);
				    jsonArray=   jsonObject.getJSONArray("data"); 	 
				    for (int i = 0; i < jsonArray.size(); i++) {  
				             JSONObject object = (JSONObject)jsonArray.get(i); 
				             OpenMessageModel model = (OpenMessageModel)JSONObject.toJavaObject(object,OpenMessageModel.class);
				             if(model != null){
	                             model.setType("双色球");
				            	if(openMessageService.getOpenMessage(model)==null){		
				            		openMessageService.addOpenMessage(model);	
				            	}
				            	 			      
				             } 
				      }
			}
			Thread.sleep(5000); // 先睡眠5秒，否则接口网站会认为恶意操作
			dataUrl = "http://f.apiplus.cn/dlt-01.json";
			url = new URL(dataUrl);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json;charset=utf-8");

			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			response = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				response.append(StringUtil.convert(inputLine));
			}
			if (response.toString().length() > 100) {
                 data= response.toString();
			    jsonObject = JSONObject.parseObject(data);
			    jsonArray=   jsonObject.getJSONArray("data");
			    for (int i = 0; i < jsonArray.size(); i++) {  
			             JSONObject object = (JSONObject)jsonArray.get(i); 
			             OpenMessageModel model = (OpenMessageModel)JSONObject.toJavaObject(object,OpenMessageModel.class);
			             if(model != null){
                             model.setType("大乐透");
			            	if(openMessageService.getOpenMessage(model)==null){		
			            		openMessageService.addOpenMessage(model);	
			            	}
			            	 			      
			             } 
			      }
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
