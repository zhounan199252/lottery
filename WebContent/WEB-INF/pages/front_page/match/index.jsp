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
	$(function() {
		$(".for_active").click(function() {
			$(this).addClass("active");
			$(this).siblings("li").removeClass("active");
		});

		var currentDayData = "";
		var s = "";

		currentDayData = '${applicationScope.currentDayData}';

		s = $.parseJSON(currentDayData);
		
		var date = s[0].phase;
		
		date = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);

		var dataTable = "<table style='width:100%' border='1px'  class='table'><tr><td colspan='3' style='text-align:center'>" + date + "</td><t>";
		for (var i = 0; i < s.length; i++) {
			var single = s[i];
			
			dataTable += "<tr style='width:100%'><td style='width:30%'>" + single.match_name + "</td><td style='width:30%'>" + single.home_team + "</td><td style='width:30%'>" + single.away_team + "</td><tr>";
			
			
		}

		dataTable += "</table>";
		
		$("#currentDate").empty();
		$("#currentDate").append(dataTable);
		
		currentDayData = '${applicationScope.nextDayData}';

		//alert(currentDayData);

		s = $.parseJSON(currentDayData);

		for (var i = 0; i < s.length; i++) {
			console.info(s[i].match_name);
		}

		currentDayData = '${applicationScope.next2DayData}';
		//alert(currentDayData);

		s = $.parseJSON(currentDayData);

		for (var i = 0; i < s.length; i++) {
			console.info(s[i].match_name);
		}

	});
	
	function changeProject(div1, div2) {
		$("#" + div1).css("display", "block");
		$("#" + div2).css("display", "none");
	}
</script>

</head>
<body>
	<div style="margin-left: auto; margin-right: auto; border: 1px solid red; width: 68%; min-height: 60%; overflow: auto" align="center" id="main">
		<ul class="nav nav-pills" style="width: 100%">
			<li id="" style="" class="active for_active"  onclick="changeProject('football', 'basketball');"><a href="#"><span class="glyphicon glyphicon-th-large"></span>足球竞彩</a></li>
			<li id="" class="for_active" style="" onclick="changeProject('basketball', 'football');"><a href="#"><span class="glyphicon glyphicon-th-large" ></span>篮球竞彩</a></li>
		</ul>
		<div style="width: 100%;  border: 1px solid green;" id="football">
			<table border="1px" style="width: 100%" class="table">
				<tr style="width: 100%">
					<td style="width: 30%">赛事</td>
					<td  style="width: 30%">主队</td>
					<td  style="width: 30%">客队</td>
				</tr>
			</table>
			<div id="currentDate" style="width: 100%;">
				
			</div>
		</div>
		
		<div style="width: 100%;  border: 1px solid green; display: none" id="basketball">
			篮球
		</div>
	</div>
</body>
</html>