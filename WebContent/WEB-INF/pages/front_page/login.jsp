<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import=" java.util.*,com.gzhd.util.SecurityHelper"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
<title>登录界面</title>

<script src="${pageContext.request.contextPath}/globle/js/des.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/simpleCart.min.js"></script>
<script type="application/x-javascript">
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 


</script>
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/megamenu.css" rel="stylesheet" type="text/css" media="all" />

<style type="text/css">
html, body {
	height: 100%;
}

.box {
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#6699FF',
		endColorstr='#6699FF'); /*  IE */
	background-image: linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image: -o-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image: -moz-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image: -webkit-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image: -ms-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	margin: 0 auto;
	position: relative;
	width: 100%;
	height: 100%;
}

.login-box {
	width: 100%;
	max-width: 500px;
	height: 440px;
	position: absolute;
	top: 50%;
	margin-top: -200px;
	/*设置负值，为要定位子盒子的一半高度*/
}

@media screen and (min-width:500px) {
	.login-box {
		left: 50%;
		/*设置负值，为要定位子盒子的一半宽度*/
		margin-left: -250px;
	}
}

.form {
	width: 100%;
	max-width: 500px;
	height: 415px;
	margin: 25px auto 0px auto;
	padding-top: 25px;
}

.login-content {
	height: 340px;
	width: 100%;
	max-width: 500px;
	background-color: rgba(255, 250, 2550, .6);
	float: left;
}

.input-group {
	margin: 0px 0px 30px 0px !important;
}

.form-control, .input-group {
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
				error.appendTo(element.parent("li").first()); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则
				username : { // field,email,password,rePassword等指的都是表单项的name属性
					required : true
				},
				passwordForLogin : {
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
				passwordForLogin : {
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
		$(obj).attr("src", "${pageContext.request.contextPath}/cff.url?d=" + timenow);
	}

	/**
	 * 提交表单
	 */
	function submitForm() {

		var passowrdEnc = strEnc($("#txt_passwordForLogin").val(), "${sessionScope.firstKey_f}", "${sessionScope.secondKey_f}", "${sessionScope.thirdKey_f}");
		$("#txt_password").val(passowrdEnc);

		$.ajax({
			url : "${pageContext.request.contextPath}/rlo.url",
			type : "post",
			data : $("#form_login").serialize(),
			success : function(res) {
				var data = $.parseJSON(res);
				if (data.success) {
					parent.location.href = "${pageContext.request.contextPath}/" + data.object;
				} else {
					BUI.Message.Alert(data.message);
					//alert(data.message);
				}
			}
		});
	}
</script>

</head>

<body>
	<div class="login" >
		<div class="container">
			<div class="login-grids">
				<div class="col-md-6 log">
					<h3>登录</h3>
					<div class="strip"></div>
					<form action="${pageContext.request.contextPath }/rlo.url" method="post" id="form_login">
					<ul>
						<li class="text-info">用户名:</li>
						<li><input type="text" value="" style="height: 30px" name="username" id="txt_username" maxlength="20"/></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">密码:</li>
						<li>
							<input type="password" value="" style="height: 30px" name="passwordForLogin" id="txt_passwordForLogin" maxlength="20"/>
							<input type="hidden" name="password" id="txt_password" maxlength="20"/>
						</li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">验证码:<img src="${pageContext.request.contextPath }/cff.url" id="img_code" onclick="changeValidateCode(this)" title="点击图片刷新验证码" style="width: 80px; height: 36px"/></li>
						<li><input type="text" style="height: 30px"  name="code" maxlength="20"/></li>
						<li></li>
					</ul>
						<input type="submit" value="登录" onclick="$('#form_login').submit();" id="btn_login"/> 
					</form>
					<a href="#">忘记密码 ？请联系在线客服</a>
				</div>

			</div>
		</div>
	</div>


</body>

</html>