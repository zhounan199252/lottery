<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
</head>
<body style="background: #FFC">

	
		<div class="row" style="width: 68%; padding: 12px 0 0 20%">
			<s:form action="frontUser!listFrontUser.action" method="post" id="form_search" cssClass="form-horizontal">
			</s:form>
		</div>

		<div class="row" style="width: 68%; padding: 12px 0 0 20%" >
			<div class="row" style="width: 100%">
				<div class="control-group span24" style="width: 98%">
					<table class="table">
						<tr>
							<th style="width: 30px"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)" title="全选"></th>
							<th>姓名</th>
							<th>用户名</th>
							<th>购买金额</th>
							<th>推荐人</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>${nickname}</td>
								<td>${username}</td>
								<td>${consumption}</td>
								<td>${recommender}</td>				
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