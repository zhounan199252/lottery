<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
<script src="${pageContext.request.contextPath}/globle/js/des.js"></script>
<script type="text/javascript">

	$(function() {
		
		// jqueryValidate 表单验证开始
		var validateForm = $("#form_add").validate({

			submitHandler : function(form) {// 当表单验证全部通过后，会执行此方法
				
				var passowrdEnc = strEnc($("#txt_password").val(), "${sessionScope.firstKey_fr}", "${sessionScope.secondKey_fr}", "${sessionScope.thirdKey_fr}"); 
				$("#txt_password").val(passowrdEnc);
				
				form.submit();
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.parent("td").next("td")); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则
				username : { //
					required : true,
					remote : { // 远程验证用户名是否已经存在，后台返回true或者false,true代表通过验证，false代表不通过，会显示提示信息 
						url : "${pageContext.request.contextPath}/chku.url",
						type : "post",
						data : { // 附带发送的数据
							"username" : function() {
								return $("#txt_username").val();
							} 
						}
					}
				},
				nickname : {
					required : true
				},
				password : {
					required : true,
					minlength : 8
				},
				rePassword : {
					required : true,
					equalTo : "#txt_password" // 表示与那个节点的数值相等
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
				username : { // 提示的位置要跟上面rules指定的位置一一对应
					required : "请输入用户名",
					remote : "用户名已存在"
				},
				nickname : {
					required : "请输入姓名"
				},
				password : {
					required : "请输入密码",
					minlength : "密码不能小于8位"
				},
				rePassword : {
					required : "请输入确认密码",
					equalTo : "两次输入的密码不相同"
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
<body>
	<div style="width: 68%;padding: 12px 0 0 15%" align="center">
	<div align="left" style="font-size: 20px;padding-bottom: 10px">
			当前位置：注册 (以下信息关乎兑奖成功与否，请确保信息的真实性，谢谢)
	</div>	
		<s:form action="/lre.url" id="form_add">
		<table class="table table-striped">
			<tr>
				<th style="width: 20%">真实姓名</th>
				<td style="width: 20%"><s:textfield name="nickname" id="txt_nickname" cssClass="control-text" maxLength="20"></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>用户名</th>
				<td><s:textfield name="username" id="txt_username" cssClass="control-text"  maxLength="20"></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>密码</th>
				<td><s:password name="password" id="txt_password" cssClass="control-text"  maxLength="50"></s:password></td>
				<td></td>
			</tr>
			<tr>
				<th>确认密码</th>
				<td><s:password name="rePassword" id="txt_rePassword" cssClass="control-text"  maxLength="20"></s:password></td>
				<td></td>
			</tr>
			
			<tr>
				<th>身份证号码</th>
				<td><s:textfield name="idCardNum" id="txt_idCardNum" cssClass="control-text"  maxLength="20"></s:textfield></td>
				<td></td>
			</tr>
			
			<tr>
				<th>电话号码</th>
				<td><s:textfield name="phoneNum" id="txt_phoneNum" cssClass="control-text"  maxLength="11"></s:textfield></td>
				<td></td>
			</tr>
			
			<tr>
				<th>
				</th>
				<td></td>
				<td></td>
			</tr>
		</table>
	</s:form>
					<button type="submit" class="button button-primary" onclick="addSave();">保存</button>
					<button type="reset" class="button" onclick="goBack();">取消</button>
	</div>


</body>
</html>