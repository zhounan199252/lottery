package com.gzhd.web.listener;

import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class LotteryDataListener implements ServletContextListener {

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
				
				
				
				
			}
		}, 2000, 3000);
	}
}
