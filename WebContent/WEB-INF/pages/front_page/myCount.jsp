<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {

		// jqueryValidate 表单验证开始
		var validateForm = $("#form_add").validate({

			submitHandler : function(form) {// 当表单验证全部通过后，会执行此方法
				form.submit();
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.parent("td").next("td")); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则

				nickname : {
					required : true
				},
				idCardNum : {
					required : true
				},
				phoneNum : {
					required : true,
					digits : true
				}
			},
			messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的

				nickname : {
					required : "请输入姓名"
				},
				idCardNum : {
					required : "请输入身份证号码"
				},
				phoneNum : {
					required : "请输入电话号码",
					digits : "请输入正确格式的电话号码"
				}
			}
		});
		// jqueryvalidate 表单验证结束
	});

	function addSave() {

		$("#form_add").submit();
	}
</script>
</head>
<body style="background: #FFC">
	<div class="container" style="width: 68%; padding: 14px 0 20px 0">
		<span style="font-size: 24px; color: blue"> 您的账户当前余额为：${balance}，如要充值，请联系客服！！ </span>
	</div>

	<div align="center" style="width: 100%">
		<s:form action="/cfu.url" id="form_add" cssStyle="width: 68%">
			<s:hidden name="id"></s:hidden>
			<table class="table">
				<tr>
					<th style="width: 20%">真实姓名</th>
					<td style="width: 20%"><s:textfield name="nickname" id="txt_nickname" cssClass="control-text" maxLength="20"></s:textfield></td>
					<td></td>
				</tr>
				<tr>
					<th>用户名</th>
					<td><s:textfield name="username" id="txt_username" cssClass="control-text" maxLength="20" readonly="true"></s:textfield></td>
					<td></td>
				</tr>

				<tr>
					<th>身份证号码</th>
					<td><s:textfield name="idCardNum" id="txt_idCardNum" cssClass="control-text" maxLength="20"></s:textfield></td>
					<td></td>
				</tr>

				<tr>
					<th>电话号码</th>
					<td><s:textfield name="phoneNum" id="txt_phoneNum" cssClass="control-text" maxLength="11"></s:textfield></td>
					<td></td>
				</tr>

				<tr>
					<th>
						<button type="submit" class="button button-primary" onclick="addSave();">保存</button>
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