<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="background: #FFC">
	<div align="center">
		<div align="left" style="font-size: 20px; padding-left: 16%">当前位置：优惠活动>>${requestScope.favor.title}</div>
		<div style="width: 68%; overflow: auto">
			<h1>标题：${requestScope.favor.title}</h1>
			<br>
			<div id="div_content" style="width: 100%; height: 100%">${requestScope.favor.content}</div>
		</div>
	</div>
</body>
</html>