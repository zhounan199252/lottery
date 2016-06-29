package com.gzhd.web.listener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
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
import com.gzhd.model.BetMessageModel;
import com.gzhd.model.OpenMessageModel;
import com.gzhd.service.itf.BetMessageService;
import com.gzhd.service.itf.OpenMessageService;
import com.gzhd.util.StringUtil;


public class HighFrequencyDataListener implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(HighFrequencyDataListener.class);
	

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
		}, 2000, 1000 * 60 * 10);
	}

	/**
	 * @param 获取十一选5等数据
	 *         
	 */
	private void getHighFrequencyData(ServletContext application) {
		ApplicationContext ac = WebApplicationContextUtils
				.getWebApplicationContext(application);
		final OpenMessageService openMessageService = (OpenMessageService) ac.getBean("com.gzhd.service.itf.OpenMessageService");
		final BetMessageService  betMessageService = (BetMessageService) ac.getBean("com.gzhd.service.itf.BetMessageService");
		String dataUrl = "http://f.apiplus.cn/gd11x5-04.json";

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
	                             model.setType("广东11选5");
				            	if(openMessageService.getOpenMessage(model)==null){		
				            		openMessageService.addOpenMessage(model);
				            		openAward(betMessageService,model);
				            	
				            	}
				            	 			      
				             } 
				      }
			}
			Thread.sleep(5000); // 先睡眠5秒，否则接口网站会认为恶意操作
			dataUrl = "http://f.apiplus.cn/cqssc-04.json";
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
                             model.setType("重庆时时彩");
			            	if(openMessageService.getOpenMessage(model)==null){		
			            		openMessageService.addOpenMessage(model);	
			            	}
			            	 			      
			             } 
			      }
			}
			Thread.sleep(5000); // 先睡眠5秒，否则接口网站会认为恶意操作
			
			dataUrl = "http://f.apiplus.cn/bjpk10-04.json";
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
	                             model.setType("北京pk10");
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
	
	
	
	
	
	
	
	
	private void  openAward(BetMessageService  betMessageService,OpenMessageModel model){
		BetMessageModel  betMessageModel= new BetMessageModel();
		betMessageModel.setBetType(model.getType());
		betMessageModel.setExchangeFlag("待开奖");
		betMessageModel.setBetPeriod(model.getExpect());
		List<BetMessageModel> list=betMessageService.getAll(betMessageModel);
		 String ids="";
		for(BetMessageModel bet:list){	
			String childType= bet.getBetChildType();
			List<String> list1= Arrays.asList(model.getOpencode().split(","));
			List<String> list2= Arrays.asList(bet.getBetNum().split(","));
			boolean  flag =false;
			if(childType.equals("r2")||childType.equals("r3")||childType.equals("r4")||childType.equals("r5")){
				flag =list1.containsAll(list2) ;   
			}else if(childType.equals("r6")||childType.equals("r7")||childType.equals("r8")){
				flag =list2.containsAll(list1) ;
			}else if(childType.equals("q1")||childType.equals("q2")||childType.equals("q3")){
				flag =model.getOpencode().startsWith(bet.getBetNum()) ;
			}
			 if(flag){
			    	ids +=bet.getId()+",";
			    }
					
		}
		      if(ids.length()>1){
			  betMessageModel.setId(ids.substring(0, ids.length()-1));
			  betMessageModel.setExchangeFlag("1");
			  betMessageService.updateBetMessage(betMessageModel);	
		}
		
		
	}
	
	

}
