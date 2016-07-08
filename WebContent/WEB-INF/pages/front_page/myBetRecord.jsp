<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$(".for_active2").on("click", function() {
			
			$(this).addClass("active");
			$(this).siblings("li").removeClass("active");
			
			var id = $(this).attr("id");
			
			$("#" + id + "_mian").css("display", "block");
			$("#" + id + "_mian").siblings("div").css("display", "none");
		});
		
	});
</script>
</head>
<body style="background: #FFC">
	<div style="width: 80%; padding:14px 0 0 20%" align="center" id="main">
		<ul class="nav nav-pills" style="width: 100%; background: #FFC">
			<li id="numberBet" style="" class="active for_active2"><a href="javascript:void(0)"><span class="glyphicon glyphicon-th-large"></span>数字彩</a></li>
			<li id="football" style="" class="for_active2"><a href="javascript:void(0)"><span class="glyphicon glyphicon-th-large"></span>足球竞彩</a></li>
			<li id="basketball" class="for_active2" style=""><a href="javascript:void(0)"><span class="glyphicon glyphicon-th-large"></span>篮球竞彩</a></li>
		</ul>


		<div class="container" style="width: 100%; padding-left: 8px" id="numberBet_mian">
			<iframe width="100%" frameBorder="0" id="iframe_main" src="${pageContext.request.contextPath}/myB.url" style="width: 100%; height: 100%"></iframe>
		</div>


		<div class="container" style="width: 100%; padding-left: 8px; display: none" id="football_mian">
			<iframe width="100%" frameBorder="0" id="iframe_main" src="${pageContext.request.contextPath}/tfb.url" style="width: 100%; height: 1000px"></iframe>
		</div>
		<div class="container" style="width: 100%; padding-left: 8px; display: none" id="basketball_mian">
			<iframe width="100%" frameBorder="0" id="iframe_main" src="${pageContext.request.contextPath}/tbb.url" style="width: 100%; height: 1000px"></iframe>
		</div>


	</div>
</body>
</html>











































