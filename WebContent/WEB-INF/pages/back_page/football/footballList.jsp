<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>

<script type="text/javascript">
	function doCount() {
		var checkboxs = $("[name=ids]:checked");

		var count = 0.0;
		var isValid = "true";
		for (var i = 0; i < checkboxs.length; i++) {
			var id = $(checkboxs[i]).prop("value");

			if ("无" != $("#" + id + "_seriesNum").text()) {

				BUI.Message.Alert("请先去除多串一的投注项！");
				isValid = "false";
				break;
			}

			var oddText = $("#" + id + "_odds").text();
			var multipleText = $("#" + id + "_multiple").text();

			count += parseFloat(parseFloat(oddText) * parseInt(multipleText));
		}

		if ("true" == isValid) {
			BUI.Message.Alert("您选择的" + checkboxs.length + "个投注项的总兑奖金额为：" + count.toFixed(2) + " 元！");
		}
	}

	function doFulfil(url) {

		var checkboxs = $("[name=ids]:checked");

		var isValid = "true";

		if (checkboxs.length <= 0) {
			BUI.Message.Alert("请至少选择一条投注项兑奖！");
			return false;
		}

		var checkboxs = $("[name=ids]:checked");

		var count = 0.0;
		var ids = "";
		for (var i = 0; i < checkboxs.length; i++) {
			var id = $(checkboxs[i]).prop("value");
			if ("无" != $("#" + id + "_seriesNum").text()) {

				BUI.Message.Alert("请先去除多串一的投注项！");
				isValid = "false";
				break;
			}

			var oddText = $("#" + id + "_odds").text();
			var multipleText = $("#" + id + "_multiple").text();

			count += parseFloat(parseFloat(oddText) * parseInt(multipleText));

			ids += id + ","
		}

		if ("true" == isValid) {
			BUI.Message.Confirm("您选择的" + checkboxs.length + "个投注项的总兑奖金额为：" + count.toFixed(2) + " 元！确定要对选中的 " + checkboxs.length + " 条投注项进行兑奖操作吗？", function() {

				var _url = url + "?id=" + ids.substring(0, ids.length - 1);
				location.href = _url;
			}, 'question');
		}
	}
</script>

</head>
<body>

	<div class="container" style="padding: 20px 0 0 30px; width: 100%">
		<div class="row" style="width: 100%;">
			<s:form action="footballBet!listFootballBet.action" method="post" id="form_search" cssClass="form-horizontal">
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">投注用户：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="user.nickname"></s:textfield>
						</div>
					</div>
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
					<%-- <div class="control-group span8">
						<label class="control-label">赔率：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="odds"></s:textfield>
						</div>
					</div> --%>

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
					<%-- <div class="control-group span8">
						<label class="control-label">投注项目：</label>
						<div class="controls">
							<s:select name="winOrLose" list="#{'胜':'胜','平':'平','负':'负','让球胜':'让球胜','让球平':'让球平','让球负':'让球负'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--"></s:select>
						</div>
					</div> --%>
					<div class="control-group span8">
						<label class="control-label">是否投中：</label>
						<div class="controls">
							<s:select name="isWinning" list="#{'no':'未开奖', 'true':'投中', 'false':'未投中'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--"></s:select>
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
						<button class="button" onclick="doCount();">统计单关兑奖金额</button>
					</label> <label class="control-label">
						<button class="button" id="showSeries">统计串号兑奖金额</button>
					</label> <label class="control-label">
						<button class="button" onclick="doFulfil('${pageContext.request.contextPath}/footballBet!doFulfil.action')">单关兑奖</button>
					</label> <label class="control-label">
						<button class="button" id="fulfilSeries">串号兑奖</button>
					</label> <label class="control-label">
						<button class="button" onclick="doRemove('${pageContext.request.contextPath}/footballBet!deleteFootballBet.action')">删除</button>
					</label> <label class="control-label">
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
							<th style="width: 2%"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)" title="全选"></th>
							<th style="width: 6%">投注用户</th>
							<th style="width: 10%">投注时间</th>
							<th style="width: 4%">类型</th>
							<th style="width: 8%">串号</th>
							<th style="width: 5%">主队</th>
							<th style="width: 5%">客队</th>
							<th style="width: 10%">比赛时间</th>
							<th style="width: 5%">投注项目</th>
							<th style="width: 5%">赔率</th>
							<th style="width: 5%">倍数</th>
							<!-- <th style="width: 5%">让球</th> -->

							<th style="width: 10%">是否投中</th>
							<th style="width: 10%">是否已兑奖</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>${user.nickname}</td>
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
								<%-- <td>${rangQiu}</td> --%>
								<td>
									<s:if test="isWinning == 'no'">
										未开奖
									</s:if> 
									<s:elseif test="isWinning == 'true'">
										<span style="color: red">投中</span>
									</s:elseif>
									<s:else>
										未投中
									</s:else>
								</td>
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


	<script type="text/javascript">
		BUI.use('bui/overlay', function(Overlay) {
			var dialog = new Overlay.Dialog({
				title : '填写串号',
				width : 250,
				height : 120,
				//配置文本
				bodyContent : '<h2>请输入需要统计的串号</h2><br>串号：<input type="text" id="txt_seriesNum" style="height:20px">',
				success : function() {
					//this.close();
					var seriesNum = $("#txt_seriesNum").val();
					if (seriesNum.length <= 0) {
						BUI.Message.Alert("请填写串号！");
						return false;
					}
					this.close();
					$.ajax({
						url : "${pageContext.request.contextPath}/footballBet!countBonusBySeriesNum.action",
						type : "post",
						data : {
							"seriesNum" : seriesNum
						},
						success : function(res) {
							var data = $.parseJSON(res);

							if ("false" == data.success) {
								BUI.Message.Alert("没有找到指定串号的投注记录！");
							} else {
								BUI.Message.Alert("该串号的兑奖金额为：" + data.bonus + " 元！");
								$("#txt_seriesNum").val("");
							}
						}
					});
				}
			});
			$('#showSeries').on('click', function() {
				dialog.show();
			});

			var dialog2 = new Overlay.Dialog({
				title : '填写串号',
				width : 250,
				height : 120,
				//配置文本
				bodyContent : '<h2>请输入需要兑奖的串号</h2><br>串号：<input type="text" id="txt_seriesNum" style="height:20px">',
				success : function() {
					//this.close();
					var seriesNum = $("#txt_seriesNum").val();
					if (seriesNum.length <= 0) {
						BUI.Message.Alert("请填写串号！");
						return false;
					}

					$.ajax({
						url : "${pageContext.request.contextPath}/footballBet!countBonusBySeriesNum.action",
						type : "post",
						data : {
							"seriesNum" : seriesNum
						},
						success : function(res) {
							var data = $.parseJSON(res);

							if ("false" == data.success) {
								BUI.Message.Alert("没有找到指定串号的投注记录！");
							} else {

								BUI.Message.Confirm("您选择的串号为 " + seriesNum + " 投注项的总兑奖金额为：" + data.bonus + " 元！确定要进行兑奖操作吗？", function() {

									location.href = "${pageContext.request.contextPath}/footballBet!fulfilBySeriesNum.action?seriesNum=" + seriesNum;
								}, 'question');

							}
						}
					});
				}
			});
			$('#fulfilSeries').on('click', function() {
				dialog2.show();
			});
		});
	</script>









</body>
</html>