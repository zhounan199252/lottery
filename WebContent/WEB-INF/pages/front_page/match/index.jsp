<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>

<script type="text/javascript">
	var selectedItemIds = [];
	var selectedTypeValue = "single";

	var selectedItemIdsForBasketball = [];
	var selectedTypeValueForBasketball = "single";

	/** 
	 *删除数组指定下标或指定对象 
	 */
	Array.prototype.remove = function(obj) {
		for (var i = 0; i < this.length; i++) {
			var temp = this[i];
			if (!isNaN(obj)) {
				temp = i;
			}
			if (temp == obj) {
				for (var j = i; j < this.length; j++) {
					this[j] = this[j + 1];
				}
				this.length = this.length - 1;
			}
		}
	}

	function changeProject(div1, div2) {
		$("#" + div1).css("display", "block");
		$("#" + div2).css("display", "none");
	}

	$(function() {
		$(".for_active2").click(function() {
			$(this).addClass("active");
			$(this).siblings("li").removeClass("active");
		});

		setInterval(reflushData, 1000 * 60 * 10)
		reflushData();

		setInterval(reflushDataForBasketball, 1000 * 60 * 10)
		reflushDataForBasketball();

		var message = "${requestScope.message}";
		if (message) {
			alert("投注成功！");
		}

		$("input:radio[name='type']").click(function() {
			var trs = $("#bet_table").children("tbody").children("tr");

			if ("series" == $(this).val()) {
				$(".td_multiple").css("display", "none");

				$("#series_multiple").css("visibility", "visible");
				selectedTypeValue = "series";
				//*

				var currentSelectedTrs = [];
				for (var i = 0; i < trs.length; i++) {
					var id = $(trs[i]).attr("id");

					if (currentSelectedTrs.indexOf(id) == -1) {
						currentSelectedTrs.push(id);
					} else {
						$(trs[i]).children("td:eq(7)").children("button").click();
					}
				}

			} else {
				$(".td_multiple").css("display", "block");
				$("#series_multiple").css("visibility", "hidden");

				selectedTypeValue = "single";

				for (var i = 0; i < trs.length; i++) {

					$(trs[i]).css("visibility", "visible");
				}
			}

			cacularTotalCount();
		});

		$("input:radio[name='typeForBasketball']").click(function() {
			var trs = $("#bet_tableForBasketball").children("tbody").children("tr");

			if ("series" == $(this).val()) {
				$(".td_multipleForBasketball").css("display", "none");

				$("#series_multipleForBasketball").css("visibility", "visible");
				selectedTypeValueForBasketball = "series";
				//*

				var currentSelectedTrs = [];
				for (var i = 0; i < trs.length; i++) {
					var id = $(trs[i]).attr("id");

					if (currentSelectedTrs.indexOf(id) == -1) {
						currentSelectedTrs.push(id);
					} else {
						$(trs[i]).children("td:eq(7)").children("button").click();
					}
				}

			} else {
				$(".td_multipleForBasketball").css("display", "block");
				$("#series_multipleForBasketball").css("visibility", "hidden");

				selectedTypeValueForBasketball = "single";

				for (var i = 0; i < trs.length; i++) {

					$(trs[i]).css("visibility", "visible");
				}
			}

			cacularTotalCountForBasketball();
		});

	});

	function reflushData() {
		var data1 = '${applicationScope.currentDayData}';
		var data2 = '${applicationScope.nextDayData}';
		var data3 = '${applicationScope.next2DayData}';

		var matchHtml = "";
		for (var i = 0; i < 3; i++) {
			var parseData = "";
			if (i == 0) {
				parseData = data1;
			} else if (i == 1) {
				parseData = data2;
			} else {
				parseData = data3;
			}

			if (parseData.length == 0) {
				continue;
			}

			var data = $.parseJSON(parseData);

			matchHtml += '<table style="width: 100%; border: 1px solid green; text-align: center" border="1px" class="table">';
			for (var j = 0; j < data.length; j++) {

				var match = data[j];

				var currentTime = "${applicationScope.currentTime}";
				if (match.time_endsale < currentTime) {
					continue;
				}

				if (j == 0) {
					currentDay = match.phase.substring(0, 4) + '年' + match.phase.substring(4, 6) + '月' + match.phase.substring(6, 8) + '日';
					matchHtml += '<tr><td colspan="9" style="text-align: left">' + currentDay + '</tr>';
				}

				matchHtml += '<tr class="' + currentDay + '_tr">';
				matchHtml += '<td style="width: 12%">' + match.official_num + '&nbsp;&nbsp;<span style="color: red; text-align: right">' + match.match_name + '</span></td>';
				matchHtml += '<td style="width: 8%" title="停售时间：' + match.time_endsale + '">' + match.time_endsale.substring(11, 16) + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_胜_td" class="selectItem" data-id="' + match.id + '_胜" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_spf.t3 + ';无;胜;' + match.match_date + '"><span id="team_name">' + match.home_team + '</span>&nbsp;&nbsp;<span style="color: red">' + match.current_spf.t3 + '</span></td>';
				matchHtml += '<td style="width: 8%" id="' + match.id + '_平_td" class="selectItem" data-id="' + match.id + '_平" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_spf.t1 + ';无;平;' + match.match_date + '">' + match.current_spf.t1 + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_负_td" class="selectItem" data-id="' + match.id + '_负" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_spf.t0 + ';无;负;' + match.match_date + '"><span style="color: red">' + match.current_spf.t0 + '</span>&nbsp;&nbsp;' + match.away_team + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_让球胜_td" class="selectItem" data-id="' + match.id + '_让球胜" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_rqspf.t3 + ';' + match.handicap + ';让球胜;' + match.match_date + '">' + match.home_team + '&nbsp;<span style="color: red">' + match.handicap + '</span>&nbsp;&nbsp;<span style="color: green">' + match.current_rqspf.t3 + '</span></td>';
				matchHtml += '<td style="width: 8%" id="' + match.id + '_让球平_td" class="selectItem" data-id="' + match.id + '_让球平" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_rqspf.t1 + ';' + match.handicap + ';让球平;' + match.match_date + '">' + match.current_rqspf.t1 + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_让球负_td" class="selectItem" data-id="' + match.id + '_让球负" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_rqspf.t0 + ';' + match.handicap + ';让球负;' + match.match_date + '"><span style="color: green">' + match.current_rqspf.t0 + '</span>&nbsp;&nbsp;' + match.away_team + '</td></tr>';
			}

			matchHtml += '</table>';
		}

		$("#football_matchData").empty();
		$("#football_matchData").append(matchHtml);

		$(".selectItem").click(function() {

			var id = $(this).attr("data-id");
			//alert($(this).css("background-color"));

			if ("rgb(255, 255, 0)" == $(this).css("background-color")) {
				$(this).css("background-color", "white");

				selectedItemIds.remove(id);
			} else {
				$(this).css("background-color", "yellow");

				selectedItemIds.push(id);
			}

			var bet_table_html = $("#bet_table").html();

			if (bet_table_html.indexOf(id) != -1) { //已存在，就删除选中

				$("#" + id).parent("td").parent("tr").remove();

			} else { //未存在，就添加到投注表中
				var option = $(this).attr("data-option");

				//33676;英格兰;威尔士;2016-06-16 20:45:00;1.42;无;胜
				//33676;英格兰;威尔士;2016-06-16 20:45:00;2.48;-1;让球胜
				var options = option.split(";");

				var selected = '<tr id="' + options[0] + '_tr">';
				selected += '<td style="width: 13%">' + options[3] + '</td>';
				selected += '<td style="width: 13%">' + options[1] + '</td>';
				selected += '<td style="width: 13%">' + options[2] + '</td>';
				selected += '<td style="width: 13%">' + options[4] + '</td>';
				selected += '<td style="width: 13%">' + options[5] + '</td>';
				selected += '<td style="width: 13%">' + options[6] + '</td>';
				selected += '<td style="width: 220px"  class="td_multiple"><button onclick="minusNum(this)">-</button>&nbsp;&nbsp;<input readonly="readonly" type="text" style="width: 80px" value="1" data-option="' + option + '" id="' + options[0] + '_' + options[6] + '_multiple">&nbsp;&nbsp;<button onclick="plusNum(this)">+</button></td>';
				selected += '<td style="width: 5%"><button onclick="deleteSelected(this);" onclick="" id="' + options[0] + '_' + options[6] + '">删除</button>';
				selected += "</tr>";
				$("#bet_table").append(selected);
			}

			if ("series" == selectedTypeValue) {
				$("#rad_single").click();
				$("#rad_series").click();
			}

			cacularTotalCount();
		});

		for (var index = 0; index < selectedItemIds.length; index++) {
			$("td[data-id='" + selectedItemIds[index] + "']").css("background-color", "yellow");
		}
	}

	function reflushDataForBasketball() {
		var data1 = '${applicationScope.currentDayBasketballData}';
		var data2 = '${applicationScope.nextDayBasketballData}';
		var data3 = '${applicationScope.next2DayBasketballData}';

		var matchHtml = "";
		for (var i = 0; i < 3; i++) {
			var parseData = "";
			if (i == 0) {
				parseData = data1;
			} else if (i == 1) {
				parseData = data2;
			} else {
				parseData = data3;
			}

			if (parseData.length == 0) {
				continue;
			}

			var data = $.parseJSON(parseData);

			matchHtml += '<table style="width: 100%; border: 1px solid green; text-align: center" border="1px" class="table">';
			for (var j = 0; j < data.length; j++) {

				var match = data[j];

				var currentTime = "${applicationScope.currentTime}";
				if (match.time_endsale < currentTime) {
					continue;
				}

				if (j == 0) {
					currentDay = match.phase.substring(0, 4) + '年' + match.phase.substring(4, 6) + '月' + match.phase.substring(6, 8) + '日';
					matchHtml += '<tr><td colspan="9" style="text-align: left">' + currentDay + '</tr>';
				}

				matchHtml += '<tr class="' + currentDay + '_tr">';
				matchHtml += '<td style="width: 12%">' + match.official_num + '&nbsp;&nbsp;<span style="color: red; text-align: right">' + match.match_name + '</span></td>';
				matchHtml += '<td style="width: 8%" title="停售时间：' + match.time_endsale + '">' + match.time_endsale.substring(11, 16) + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_胜_td" class="selectItemForBasketball" data-id="' + match.id + '_胜" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_sf.t3 + ';无;胜;' + match.match_date + '"><span id="team_name">' + match.home_team + '</span>&nbsp;&nbsp;<span style="color: red">' + match.current_sf.t3 + '</span></td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_负_td" class="selectItemForBasketball" data-id="' + match.id + '_负" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_sf.t0 + ';无;负;' + match.match_date + '"><span style="color: red">' + match.current_sf.t0 + '</span>&nbsp;&nbsp;' + match.away_team + '</td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_让分胜_td" class="selectItemForBasketball" data-id="' + match.id + '_让分胜" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_rfsf.t3 + ';' + match.handicap + ';让分胜;' + match.match_date + '">' + match.home_team + '&nbsp;<span style="color: red">' + match.handicap + '</span>&nbsp;&nbsp;<span style="color: green">' + match.current_rfsf.t3 + '</span></td>';
				matchHtml += '<td style="width: 15%" id="' + match.id + '_让分负_td" class="selectItemForBasketball" data-id="' + match.id + '_让分负" data-option="' + match.id + ';' + match.home_team + ';' + match.away_team + ';' + match.time_endsale + ';' + match.current_rfsf.t0 + ';' + match.handicap + ';让分负;' + match.match_date + '"><span style="color: green">' + match.current_rfsf.t0 + '</span>&nbsp;&nbsp;' + match.away_team + '</td></tr>';
			}

			matchHtml += '</table>';
		}

		$("#basketball_matchData").empty();
		$("#basketball_matchData").append(matchHtml);

		$(".selectItemForBasketball").click(function() {

			var id = $(this).attr("data-id");
			//alert($(this).css("background-color"));

			if ("rgb(255, 255, 0)" == $(this).css("background-color")) {
				$(this).css("background-color", "white");

				selectedItemIdsForBasketball.remove(id);
			} else {
				$(this).css("background-color", "yellow");

				selectedItemIdsForBasketball.push(id);
			}

			var bet_table_html = $("#bet_tableForBasketball").html();

			if (bet_table_html.indexOf(id) != -1) { //已存在，就删除选中

				$("#" + id).parent("td").parent("tr").remove();

			} else { //未存在，就添加到投注表中
				var option = $(this).attr("data-option");

				var options = option.split(";");

				var selected = '<tr id="' + options[0] + '_tr">';
				selected += '<td style="width: 13%">' + options[3] + '</td>';
				selected += '<td style="width: 13%">' + options[1] + '</td>';
				selected += '<td style="width: 13%">' + options[2] + '</td>';
				selected += '<td style="width: 13%">' + options[4] + '</td>';
				selected += '<td style="width: 13%">' + options[5] + '</td>';
				selected += '<td style="width: 13%">' + options[6] + '</td>';
				selected += '<td style="width: 220px"  class="td_multipleForBasketball"><button onclick="minusNumForBasketball(this)">-</button>&nbsp;&nbsp;<input readonly="readonly" type="text" style="width: 80px" value="1" data-option="' + option + '" id="' + options[0] + '_' + options[6] + '_multiple">&nbsp;&nbsp;<button onclick="plusNumForBasketball(this)">+</button></td>';
				selected += '<td style="width: 5%"><button onclick="deleteSelectedForBasketball(this);" onclick="" id="' + options[0] + '_' + options[6] + '">删除</button>';
				selected += "</tr>";
				$("#bet_tableForBasketball").append(selected);
			}

			if ("series" == selectedTypeValueForBasketball) {
				$("#rad_singletypeForBasketball").click();
				$("#rad_seriestypeForBasketball").click();
			}

			cacularTotalCountForBasketball();
		});

		for (var index = 0; index < selectedItemIdsForBasketball.length; index++) {
			$("td[data-id='" + selectedItemIdsForBasketball[index] + "']").css("background-color", "yellow");
		}
	}

	function plusNum(node) { //倍数加1  
		var value = $(node).siblings("input").val();

		$(node).siblings("input").val(parseInt(value) + 1);

		cacularTotalCount();
	}

	function minusNum(node) { //倍数减1
		var value = $(node).siblings("input").val();

		if (value != 1) {
			$(node).siblings("input").val(parseInt(value) - 1);
		}

		cacularTotalCount();
	}

	function plusNumFroSeries(node) { //倍数加1  
		var value = $(node).siblings("input").val();

		$(node).siblings("input").val(parseInt(value) + 1);

		cacularTotalCount();
	}

	function minusNumFroSeries(node) { //倍数减1
		var value = $(node).siblings("input").val();

		if (value != 1) {
			$(node).siblings("input").val(parseInt(value) - 1);
		}

		cacularTotalCount();
	}

	function deleteSelected(node) {

		var id = $(node).attr("id");
		$("#" + id + "_td").css("background-color", "white");

		$(node).parent('td').parent('tr').remove();

		cacularTotalCount();
	}

	function plusNumForBasketball(node) { //倍数加1  
		var value = $(node).siblings("input").val();

		$(node).siblings("input").val(parseInt(value) + 1);

		cacularTotalCountForBasketball();
	}

	function minusNumForBasketball(node) { //倍数减1
		var value = $(node).siblings("input").val();

		if (value != 1) {
			$(node).siblings("input").val(parseInt(value) - 1);
		}

		cacularTotalCountForBasketball();
	}

	function plusNumFroSeriesForBasketball(node) { //倍数加1  
		var value = $(node).siblings("input").val();

		$(node).siblings("input").val(parseInt(value) + 1);

		cacularTotalCountForBasketball();
	}

	function minusNumFroSeriesForBasketball(node) { //倍数减1
		var value = $(node).siblings("input").val();

		if (value != 1) {
			$(node).siblings("input").val(parseInt(value) - 1);
		}

		cacularTotalCountForBasketball();
	}

	function deleteSelectedForBasketball(node) {

		var id = $(node).attr("id");
		$("#" + id + "_td").css("background-color", "white");

		$(node).parent('td').parent('tr').remove();

		cacularTotalCountForBasketball();
	}

	function cacularTotalCount() { //计算总额

		if ("single" == selectedTypeValue) {
			var inputValues = $("#bet_table input");

			var totalValue = 0;
			for (var i = 0; i < inputValues.length; i++) {
				totalValue += parseInt($(inputValues[i]).val());
			}

			$("#totalCount").val(totalValue * 2);
		} else {
			var series_multiple = $("#txt_series_multiple").val();

			$("#totalCount").val(parseInt(series_multiple) * 2); //*
		}
	}

	function cacularTotalCountForBasketball() { //计算总额

		if ("single" == selectedTypeValueForBasketball) {
			var inputValues = $("#bet_tableForBasketball input");

			var totalValue = 0;
			for (var i = 0; i < inputValues.length; i++) {
				totalValue += parseInt($(inputValues[i]).val());
			}

			$("#totalCountForBasketball").val(totalValue * 2);
		} else {
			var series_multiple = $("#txt_series_multipleForBasketball").val();

			$("#totalCountForBasketball").val(parseInt(series_multiple) * 2); //*
		}
	}

	function betSubmit() {

		var currentTime = "${applicationScope.currentTime}";
		//var currentTime = "2016-06-23 12:04:06";
		var trs = $("#bet_table input");

		var isValid = "true";
		var data = [];

		if ("single" == selectedTypeValue) {
			for (var i = 0; i < trs.length; i++) {
				var option = $(trs[i]).attr("data-option");
				var options = option.split(";");
				var endSaleTime = options[3];
				var currentTime = "${applicationScope.currentTime}";
				if (endSaleTime < currentTime) {
					alert("请先去除已经过期的投注项，谢谢！");

					isValid = "false";

					break;
				}

				var multiple = $("#" + options[0] + "_" + options[6] + "_multiple").val();

				$("#txt_type").val("single");
				data.push(option + ";" + multiple + ";single;football");
			}
		} else {
			for (var i = 0; i < trs.length; i++) {

				var parentTrVisibility = $(trs[i]).parent("td").parent("tr").css("visibility");
				if ("hidden" == parentTrVisibility) {
					continue;
				}

				var option = $(trs[i]).attr("data-option");
				var options = option.split(";");
				var endSaleTime = options[3];
				var currentTime = "${applicationScope.currentTime}";
				if (endSaleTime < currentTime) {
					alert("请先去除已经过期的投注项，谢谢！");

					isValid = "false";

					break;
				}

				var multiple = $("#txt_series_multiple").val();
				$("#txt_type").val("series");

				data.push(option + ";" + multiple + ";series;football");
			}
		}

		if (isValid == "false") {
			return false;
		}

		var totalCount = $("#totalCount").val();

		var balance = "${requestScope.balance}";

		if (!balance) {
			alert("请先登录，谢谢！");
			return false;
		}

		if (parseFloat(balance) < parseFloat(totalCount)) {
			alert("抱歉！您的余额只剩：" + balance + " 元,请先充值或减少投注项！");
			return false;
		}

		$("#txt_bet_data").val(data.join("&"));
		$("#txt_totalCount").val(totalCount);
		$("#bet_form").submit();
	}

	function betSubmitForBasketball() {

		var currentTime = "${applicationScope.currentTime}";
		//var currentTime = "2016-06-23 12:04:06";
		var trs = $("#bet_tableForBasketball input");

		var isValid = "true";
		var data = [];

		if ("single" == selectedTypeValueForBasketball) {
			for (var i = 0; i < trs.length; i++) {
				var option = $(trs[i]).attr("data-option");
				var options = option.split(";");
				var endSaleTime = options[3];
				var currentTime = "${applicationScope.currentTime}";
				if (endSaleTime < currentTime) {
					alert("请先去除已经过期的投注项，谢谢！");

					isValid = "false";

					break;
				}

				var multiple = $("#" + options[0] + "_" + options[6] + "_multiple").val();

				$("#txt_typeForBasketball").val("single");
				data.push(option + ";" + multiple + ";single;basketball");
			}
		} else {
			for (var i = 0; i < trs.length; i++) {

				var parentTrVisibility = $(trs[i]).parent("td").parent("tr").css("visibility");
				if ("hidden" == parentTrVisibility) {
					continue;
				}

				var option = $(trs[i]).attr("data-option");
				var options = option.split(";");
				var endSaleTime = options[3];
				var currentTime = "${applicationScope.currentTime}";
				if (endSaleTime < currentTime) {
					alert("请先去除已经过期的投注项，谢谢！");

					isValid = "false";

					break;
				}

				var multiple = $("#txt_series_multipleForBasketball").val();
				$("#txt_typeForBasketball").val("series");

				data.push(option + ";" + multiple + ";series;basketball");
			}
		}

		if (isValid == "false") {
			return false;
		}

		var totalCount = $("#totalCountForBasketball").val();

		var balance = "${requestScope.balance}";

		if (!balance) {
			alert("请先登录，谢谢！");
			return false;
		}

		if (parseFloat(balance) < parseFloat(totalCount)) {
			alert("抱歉！您的余额只剩：" + balance + " 元,请先充值或减少投注项！");
			return false;
		}

		$("#txt_bet_dataForBasketball").val(data.join("&"));
		$("#txt_totalCounForBasketballt").val(totalCount);
		
		$("#bet_formForBasketball").submit();
	}
</script>

</head>
<body>
	<div style="margin-left: auto; margin-right: auto; border: 1px solid red; width: 68%; height: 100%; overflow: auto;" align="center" id="main">
		<ul class="nav nav-pills" style="width: 100%">
			<li id="" style="" class="active for_active2" onclick="changeProject('football', 'basketball');"><a href="#"><span class="glyphicon glyphicon-th-large"></span>足球竞彩</a></li>
			<li id="" class="for_active2" style="" onclick="changeProject('basketball', 'football');"><a href="#"><span class="glyphicon glyphicon-th-large"></span>篮球竞彩</a></li>
		</ul>
		<div style="width: 100%;" id="football">
			<table border="1px" style="width: 100%; text-align: center;" class="table">
				<tr style="width: 100%">
					<td colspan="2" style="width: 12%">赛事</td>
					<td style="width: 8%">停售时间</td>
					<td style="width: 15%">胜</td>
					<td style="width: 8%">平</td>
					<td style="width: 15%">负</td>
					<td style="width: 15%">让球胜</td>
					<td style="width: 8%">让球平</td>
					<td style="width: 15%">让球负</td>
				</tr>
			</table>
			<div style="width: 100%" id="football_matchData"></div>
			<div style="border: 1px solid blue; width: 100%; min-height: 300px; overflow: auto;" id="bet_div">
				<div style="width: 100%">
					过关方式：<input type="radio" name="type" value="single" checked="checked" id="rad_single">单关&nbsp;<input type="radio" id="rad_series" name="type" value="series">多串一&nbsp;&nbsp; <span style="color: red; font-size: 20px">当前投注总额：<input type="text" style="width: 100px" id="totalCount" value="0" readonly="readonly">元
					</span>&nbsp;&nbsp;
					<button onclick="betSubmit();">提交投注</button>
					&nbsp;&nbsp; <span id="series_multiple" style="visibility: hidden;">倍数：
						<button id="" onclick="minusNumFroSeries(this)">-</button> <input type="text" id="txt_series_multiple" value="1" style="width: 80px" readonly="readonly">
						<button id="" onclick="plusNumFroSeries(this)">+</button>
					</span>
				</div>
				<table border="1px" style="width: 100%; text-align: center;" class="table" id="bet_table">
					<thead>
						<tr>
							<td style="width: 10%">停售时间</td>
							<td style="width: 13%">主队</td>
							<td style="width: 13%">客队</td>
							<td style="width: 13%">赔率</td>
							<td style="width: 13%">让球</td>
							<td style="width: 13%">胜负</td>
							<td style="width: 220px;" class="td_multiple">倍数</td>
							<td style="width: 5%">操作</td>
						</tr>
					</thead>
				</table>
			</div>
		</div>

		<div style="width: 100%; border: 1px solid green; display: none" id="basketball">
			<table border="1px" style="width: 100%; text-align: center;" class="table">
				<tr style="width: 100%">
					<td colspan="2" style="width: 12%">赛事</td>
					<td style="width: 8%">停售时间</td>
					<td style="width: 15%">胜</td>
					<td style="width: 15%">负</td>
					<td style="width: 15%">让分胜</td>
					<td style="width: 15%">让分负</td>
				</tr>
			</table>
			<div style="width: 100%" id="basketball_matchData"></div>
			<div style="border: 1px solid blue; width: 100%; min-height: 300px; overflow: auto;" id="bet_divForBasketball">
				<div style="width: 100%">																		
					过关方式：<input type="radio" name="typeForBasketball" value="single" checked="checked" id="rad_singletypeForBasketball">单关&nbsp;<input type="radio" id="rad_seriestypeForBasketball" name="typeForBasketball" value="series">多串一&nbsp;&nbsp; <span style="color: red; font-size: 20px">当前投注总额：<input type="text" style="width: 100px" id="totalCountForBasketball" value="0" readonly="readonly">元
					</span>&nbsp;&nbsp;
					<button onclick="betSubmitForBasketball();">提交投注</button>
					&nbsp;&nbsp;<span id="series_multipleForBasketball" style="visibility: hidden;"> 倍数：
						<button id="" onclick="minusNumFroSeriesForBasketball(this)">-</button> <input type="text" id="txt_series_multipleForBasketball" value="1" style="width: 80px" readonly="readonly">
						<button id="" onclick="plusNumFroSeriesForBasketball(this)">+</button>
					</span>
				</div>
				<table border="1px" style="width: 100%; text-align: center;" class="table" id="bet_tableForBasketball">
					<thead>
						<tr>
							<td style="width: 10%">停售时间</td>
							<td style="width: 13%">主队</td>
							<td style="width: 13%">客队</td>
							<td style="width: 13%">赔率</td>
							<td style="width: 13%">让分</td>
							<td style="width: 13%">胜负</td>
							<td style="width: 220px;" class="td_multipleForBasketball">倍数</td>
							<td style="width: 5%">操作</td>
						</tr>
					</thead>
				</table>
			</div>
		</div>

	</div>

	<form action="${pageContext.request.contextPath}/subfootbet.url" style="display: none" method="post" id="bet_form">
		<input type="text" id="txt_bet_data" name="data"> <input type="text" id="txt_totalCount" name="totalCount"> <input type="text" id="txt_type" name="type">
	</form>

	<form action="${pageContext.request.contextPath}/subfootbet.url" style="display: none" method="post" id="bet_formForBasketball">
		<input type="text" id="txt_bet_dataForBasketball" name="data"> <input type="text" id="txt_totalCountForBasketball" name="totalCount"> <input type="text" id="txt_typeForBasketball" name="type">
	</form>
</body>
</html>