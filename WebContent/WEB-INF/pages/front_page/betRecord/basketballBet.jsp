<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

</head>
<body style="background:#FFC">

	<div class="container" style="padding: 20px 0 0 30px; width: 100%">
		<div class="row" style="width: 100%;">
			<s:form action="/tbb.url" method="post" id="form_search" cssClass="form-horizontal">
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">主队：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="homeTeam"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">客队：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="awayTeam"></s:textfield>
						</div>
					</div>

					<div class="control-group span8">
						<label class="control-label">类型：</label>
						<div class="controls">
							<s:select name="type" list="#{'single':'单关','series':'多串一'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--"></s:select>
						</div>
					</div>

					<div class="control-group span8">
						<label class="control-label">是否已兑奖：</label>
						<div class="controls">
							<s:select name="isFulfil" list="#{'yes':'已兑奖','no':'未兑奖'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--"></s:select>
						</div>
					</div>
				</div>
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">串号：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="seriesNum"></s:textfield>
						</div>
					</div>

					<div class="control-group span12">
						<label class="control-label">投注时间：</label>
						<div class="controls">
							<s:textfield cssClass="control-text Wdate" name="betTimeBegin" readonly="true" id="txt_betTimeBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(txt_betTimeEnd)}'})"></s:textfield>
							-
							<s:textfield cssClass="control-text Wdate" name="betTimeEnd" readonly="true" id="txt_betTimeEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(txt_betTimeBegin)}'})"></s:textfield>
						</div>
					</div>

					<div class="control-group span12">
						<label class="control-label">比赛时间：</label>
						<div class="controls">
							<s:textfield cssClass="control-text Wdate" name="matchTimeBegin" readonly="true" id="txt_matchTimeBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(txt_matchTimeEnd)}'})"></s:textfield>
							-
							<s:textfield cssClass="control-text Wdate" name="matchTimeEnd" readonly="true" id="txt_matchTimeEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(txt_matchTimeBegin)}'})"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">投注项目：</label>
						<div class="controls">
							<s:select name="winOrLose" list="#{'胜':'胜','平':'平','负':'负','让球胜':'让球胜','让球平':'让球平','让球负':'让球负'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--"></s:select>
						</div>
					</div>

				</div>
				<div class="row" style="width: 100%">

					<div class="control-group span6"></div>
				</div>
			</s:form>
		</div>
	</div>

	<div class="container" style="width: 100%; padding-left: 8px">
		<div class="row" style="width: 100%;">
			<div class="row" style="padding: 10px 0 0 10px;">
				<div class="control-group span24">
					<label class="control-label">
						<button class="button" onclick="doSearch();">搜索</button>
					</label> <label class="control-label">
						<button class="button" onclick="doClear();">清空</button>
					</label>
				</div>
			</div>
			<div class="row" style="width: 100%">
				<div class="control-group span24" style="width: 98%">
					<table class="table table-striped table-bordered">
						<tr>
							<th style="width: 10%">投注时间</th>
							<th style="width: 8%">类型</th>
							<th style="width: 8%">串号</th>
							<th style="width: 8%">主队</th>
							<th style="width: 8%">客队</th>
							<th style="width: 10%">比赛时间</th>
							<th style="width: 8%">投注项目</th>
							<th style="width: 8%">赔率</th>
							<th style="width: 8%">倍数</th>
							<th style="width: 8%">让分</th>

							<th style="width: 10%">是否已兑奖</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td>${betTime}</td>
								<td><s:if test="type == 'single'">
										单关
									</s:if> <s:else>
										多串一
									</s:else></td>
								<td id="${id}_seriesNum">${seriesNum}</td>
								<td>${homeTeam}</td>
								<td>${awayTeam}</td>
								<td>${matchTime}</td>
								<td>${winOrLose}</td>
								<td id="${id}_odds">${odds}</td>
								<td id="${id}_multiple">${multiple}</td>
								<td>${rangQiu}</td>
								<td><s:if test="isFulfil == 'yes'">
										已兑奖
									</s:if> <s:else>
										<span style="color: red">未兑奖</span>
									</s:else></td>
							</tr>
						</s:iterator>

					</table>


				</div>
			</div>
			<div class="row" style="padding-left: 10px">
				<div class="control-group span24 ">
					<jsp:include page="/globle/jsp/pageView.jsp"></jsp:include>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>