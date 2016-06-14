<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>

	<div class="container" style="padding: 20px 0 20px 0; width: 68%">
	<div class="row" style="width: 100%;">
			<s:form action="myB.url" method="post" id="form_search" cssClass="form-horizontal">
			</s:form>
		</div>
		<span style="font-size: 20px; color: red"> 以下为您的已投注信息： </span>
	</div>

	<div class="container" style="width: 68%; padding-left: 8px">
		<div class="row" style="width: 100%;">
			<div class="row" style="width: 100%">
				<div class="control-group span24" style="width: 98%">
					<table class="table table-striped table-bordered">
						<tr>
<!-- 							<th style="width: 30px"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)" title="全选"></th> -->
<!-- 							<th>投注人</th> -->
							<th>投注类型</th>
							<th>投注期数</th>
							<th>投注倍数</th>
							<th>投注号码</th>
							<th>投注日期</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
<%-- 								<td><input type="checkbox" name="ids" value="${id}"></td> --%>
<%-- 								<td>${betPersonName}</td> --%>
								<td>${betType}</td>
								<td>${betPeriod}</td>
								<td>${betQuan}</td>
								<td>${betNum}</td>
								<td>${betDate}</td>
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


	<div></div>








	<script type="text/javascript">
		BUI.use('bui/form', function(Form) {
			new Form.Form({
				srcNode : '#form_search'
			}).render();
		});
	</script>
</body>
</html>