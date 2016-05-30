<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台登录界面</title>
<script type="text/javascript">
	$(function() {
		$("#txt_username").focus(); // 用户名框获取焦点

		$('#form_login').keydown(function(event) { // 回车事件（登陆）
			if (event && event.which == 13) {
				$('#btn_login').click();
				return false;
			}
			return true;
		});

		// jqueryValidate 表单验证开始
		var validateForm = $("#form_login").validate({
			
			success : "",

			submitHandler : function(form) {// 当表单验证全部通过后，会执行此方法
				submitForm();
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.parent("td").next("td")); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则
				username : { // field,email,password,rePassword等指的都是表单项的name属性
					required : true
				},
				password : {
					required : true
				},
				code : {
					required : true
				}
			},
			messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的
				username : { // 提示的位置要跟上面rules指定的位置一一对应
					required : "请输入用户名",
				},
				password : {
					required : "请输入密码"
				},
				code : {
					required : "请输入验证码"
				}
			}
		});
		// jqueryvalidate 表单验证结束
		
		
	});

	// 点击获取新的验证码
	function changeValidateCode(obj) {
		// 获取当前的时间作为参数,没实际意义，只为确保页面不会缓存
		var timenow = new Date().getTime();
		$(obj).attr("src", "${pageContext.request.contextPath}/securityCode!getCodeForBack.action?d=" + timenow);
	}

	/**
	 * 提交表单
	 */
	function submitForm() {
		$.ajax({
			url : "${pageContext.request.contextPath}/backUser!backLogin.action",
			type : "post",
			data : $("#form_login").serialize(),
			success : function(res) {
				var data = $.parseJSON(res);
				if (data.success) {
					location.href = "${pageContext.request.contextPath}/" + data.object;
				} else {
					alert(data.message);
				}
			}
		});
	}
</script>
</head>
<body>

	<s:form action="backUser!backLogin.action" namespace="/" id="form_login">
	
		<table>
			<tr>
				<td>用户名</td>
				<td><input type="text" name="username" id="txt_username"></td>
				<td></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input type="password" name="password" id="txt_password" ></td>
				<td></td>
			</tr>
			
			<tr>
				<td>验证码</td>
				<td><input type="text" name="code"></td>
				<td><img src="${pageContext.request.contextPath }/securityCode!getCodeForBack.action" id="img_code" onclick="changeValidateCode(this)" title="点击图片刷新验证码" style="width: 80px; height: 30px"/></td>
			</tr>
			
			<tr>
				<td><input type="button" value="登录" onclick="$('#form_login').submit();"> </td>
				<td></td>
				<td></td>
			</tr>
			
		</table>
	
	
	</s:form>


</body>
</html>