<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="background:#FFC">

	<div class="row" style="width: 100%;">
				<s:form action="myB.url" method="post" id="form_search" cssClass="form-horizontal">
				</s:form>
			</div>
			<%-- <span style="font-size: 20px; color: red"> 数字彩记录： </span> --%>
			<div class="row" style="width: 100%;">
				<div class="row" style="width: 100%">
					<div class="control-group span24" style="width: 100%">
						<table class="table table-striped table-bordered">
							<tr>
								<th>投注类型</th>
								<th>投注期数</th>
								<th>投注倍数</th>
								<th>投注号码</th>
								<th>投注日期</th>
								<th>是否兑奖</th>
							</tr>

							<s:iterator value="#pageModel.recordList">
								<tr>
									<td>${betType}</td>
									<td>${betPeriod}</td>
									<td>${betQuan}</td>
									<td>${betNum}</td>
									<td>${betDate}</td>
									<td>${exchangeFlag}</td>
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

</body>
</html>