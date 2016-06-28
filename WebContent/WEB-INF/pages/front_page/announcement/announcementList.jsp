<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import=" java.util.*,com.gzhd.util.SecurityHelper"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body style="background: #FFC">
	<div align="center">
		<div class="row">
			<div class="control-group" style="width: 68%">
				<table class="table">
					<tr>
						<th>标题</th>
						<th>发布时间</th>
					</tr>

					<s:iterator value="#pageModel.recordList">
						<tr>
							<td><a href="${pageContext.request.contextPath}/san.url?id=<%=SecurityHelper.encode((String)request.getAttribute("id"))%>" target="_self" style="cursor: pointer;">${title }</a></td>
							<td>${publishTime}</td>
						</tr>
					</s:iterator>

				</table>


			</div>
		</div>
		<div class="row">
			<div class="control-group">
				<jsp:include page="/globle/jsp/pageView.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>