<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
<title>登录界面</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globle/css/bootstrap.min.css" />

<style type="text/css">
html,body {
	height: 100%;
}
.box {
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6699FF', endColorstr='#6699FF'); /*  IE */
	background-image:linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-o-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-moz-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-webkit-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-ms-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	
	margin: 0 auto;
	position: relative;
	width: 100%;
	height: 100%;
}
.login-box {
	width: 100%;
	max-width:500px;
	height: 440px;
	position: absolute;
	top: 50%;

	margin-top: -200px;
	/*设置负值，为要定位子盒子的一半高度*/
	
}
@media screen and (min-width:500px){
	.login-box {
		left: 50%;
		/*设置负值，为要定位子盒子的一半宽度*/
		margin-left: -250px;
	}
}	

.form {
	width: 100%;
	max-width:500px;
	height: 415px;
	margin: 25px auto 0px auto;
	padding-top: 25px;
}	
.login-content {
	height: 340px;
	width: 100%;
	max-width:500px;
	background-color: rgba(255, 250, 2550, .6);
	float: left;
}		
	
	
.input-group {
	margin: 0px 0px 30px 0px !important;
}
.form-control,
.input-group {
	height: 40px;
}

.form-group {
	margin-bottom: 0px !important;
}
.login-title {
	padding: 20px 10px;
	background-color: rgba(0, 0, 0, .6);
}
.login-title h1 {
	margin-top: 10px !important;
}
.login-title small {
	color: #fff;
}

.link p {
	line-height: 20px;
	margin-top: 30px;
}
.btn-sm {
	padding: 8px 24px !important;
	font-size: 16px !important;
}
</style>

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
				error.appendTo(element.next("span")); // 指定显示错误信息的位置
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
<div class="box">
		<div class="login-box">
			<div class="login-title text-center">
				<h1><small>登录</small></h1>
			</div>
			<div class="login-content ">
			<div class="form">
			<form action="#" method="post" id="form_login">
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
							<input type="text" id="txt_username" name="username" class="form-control" placeholder="用户名" style="height: 40px">
							<span></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="password" id="txt_password" name="password" class="form-control" placeholder="密码" style="height: 40px">
							<span></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="text" name="code" class="form-control" placeholder="验证码" style="width: 140px;height: 40px">
							<span></span>
							<span style="padding:10px 0 0 8px">
								<img src="${pageContext.request.contextPath }/securityCode!getCodeForBack.action" id="img_code" onclick="changeValidateCode(this)" title="点击图片刷新验证码" style="width: 80px; height: 36px"/>
							</span>
						</div>
					</div>
				</div>
				<div class="form-group form-actions">
					<div class="col-xs-4 col-xs-offset-4 ">
						<button type="submit" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-off"></span> 登录</button>
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>
</div>

</body>

</html>