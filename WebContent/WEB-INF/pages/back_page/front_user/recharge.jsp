<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账户充值</title>
<script type="text/javascript">

	$(function() {
		
		// jqueryValidate 表单验证开始
		var validateForm = $("#form_recharge").validate({

			submitHandler : function(form) {// 当表单验证全部通过后，会执行此方法
				form.submit();
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.parent("td").next("td")); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则
				balance : {
					required : true,
					number : true
				}
			},
			messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的
				balance : {
					required : "请输入金额",
					number : "金额必须为数字"
				}
			}
		});
		// jqueryvalidate 表单验证结束
	});


	function rechargeSave() {
		
		$("#form_recharge").submit();
	}

</script>
</head>
<body>
	<div style="width: 90%; padding: 12px 0 0 12px">
		<h2>前台用户管理--账户充值</h2>

		<s:form action="frontUser!recharge.action" id="form_recharge">
			<s:hidden name="id"></s:hidden>
			<table class="table table-striped">
				<tr>
					<th style="width: 20%">姓名</th>
					<td style="width: 20%"><s:textfield name="nickname" id="txt_nickname" cssClass="control-text" maxLength="20" readonly="true"></s:textfield></td>
					<td></td>
				</tr>
				<tr>
					<th>用户名</th>
					<td><s:textfield name="username" id="txt_username" cssClass="control-text" maxLength="20" readonly="true"></s:textfield></td>
					<td></td>
				</tr>
				<tr>
					<th>金额</th>
					<td><s:textfield name="balance" id="txt_balance" cssClass="control-text" maxLength="20" value=""></s:textfield></td>
					<td></td>
				</tr>
				<tr>
					<th>
						<button type="submit" class="button button-primary" onclick="rechargeSave();">保存</button>
						<button type="reset" class="button" onclick="goBack();">取消</button>
					</th>
					<td></td>
					<td></td>
				</tr>
			</table>
		</s:form>
	</div>


</body>
</html>