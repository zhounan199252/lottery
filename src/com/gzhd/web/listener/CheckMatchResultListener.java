package com.gzhd.web.listener;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.gzhd.model.FootballBetModel;
import com.gzhd.service.itf.FootballBetService;
import com.gzhd.service.itf.MatchResultService;

public class CheckMatchResultListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {

	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {

		final ServletContext application = sce.getServletContext();

		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(application);
		final MatchResultService matchResultService = (MatchResultService) ac.getBean(MatchResultService.BEAN_NAME);
		final FootballBetService footballBetService = (FootballBetService) ac.getBean(FootballBetService.BEAN_NAME);

		Timer timer = new Timer();

		timer.schedule(new TimerTask() {

			@Override
			public void run() {
				checkResult(matchResultService, footballBetService);
			}
		}, 40000, 1000 * 60 * 10);
	}

	private void checkResult(MatchResultService matchResultService, FootballBetService footballBetService) {

		Map<String, String> resultMap = matchResultService.getMatchResultByDate();
		List<FootballBetModel> footballBetList = footballBetService.getNotFulfilFootballBet();

		List<String> existSeriesNumList = new ArrayList<String>();

		for (FootballBetModel model : footballBetList) {

			if ("series".equals(model.getType())) {

				if (!existSeriesNumList.contains(model.getSeriesNum())) {
					List<FootballBetModel> footballBetListOfSeriesNum = footballBetService.getFootballBetBySeriesNum(model.getSeriesNum());

					String matchId = footballBetListOfSeriesNum.get(0).getMatchId();
					if (StringUtils.isNotBlank(resultMap.get(matchId))) {
						boolean isValid = true;

						for (FootballBetModel betModel : footballBetListOfSeriesNum) {

							String winOrLose = betModel.getWinOrLose();

							String result = resultMap.get(betModel.getMatchId()); // 根据赛事id拿到比赛结果

							String[] results = result.split(";");

							if (!results[0].trim().equals(winOrLose.trim()) && !results[1].trim().equals(winOrLose.trim())) { // 没投中
								isValid = false;
							}
						}

						if (isValid) { // 全部都投中了
							footballBetService.updateFootballBetWinningBySeriesNum("true", model.getSeriesNum());
						} else {
							footballBetService.updateFootballBetWinningBySeriesNum("false", model.getSeriesNum());
						}
					}
					existSeriesNumList.add(model.getSeriesNum());
				}
			} else {

				String result = resultMap.get(model.getMatchId());
				
				if(StringUtils.isNotBlank(result)) {
					String winOrLose = model.getWinOrLose();

					String[] results = result.split(";");

					if (!results[0].trim().equals(winOrLose.trim()) && !results[1].trim().equals(winOrLose.trim())) {
						footballBetService.updateFootballBetWinningById("false", model.getId());
					} else {
						footballBetService.updateFootballBetWinningById("true", model.getId());
					}
				}
			}
		}
	}
}
