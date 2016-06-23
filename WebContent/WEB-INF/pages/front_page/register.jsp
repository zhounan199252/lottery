<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
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
				error.appendTo(element.parent("li").first()); // 指定显示错误信息的位置
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
<body style="overflow: scroll;background:#FFC" >
	<div class="reg-form">
		<div class="container" >
			<div class="reg" >
				<h3>注册用户</h3>
				<p>欢迎您！请输入以下注册信息<span style="color:red">(以下信息关乎兑奖成功与否，请确保信息的真实性，谢谢)</span> </p>
				<form action="${pageContext.request.contextPath}/lre.url" id="form_add" method="post">
					<ul >
						<li class="text-info">真实姓名:</li>
						<li><input type="text" value="" style="height: 30px" name="nickname" id="txt_nickname" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">用户名(只能字母和数字组合):</li>
						<li><input type="text" value="" style="height: 30px" name="username" id="txt_username" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">密码:</li>
						<li><input type="password" value="" style="height: 30px" name="password" id="txt_password" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">确认密码:</li>
						<li><input type="password" value="" style="height: 30px" name="rePassword" id="txt_rePassword" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">移动号码:</li>
						<li><input type="text" value="" style="height: 30px" name="phoneNum" id="txt_phoneNum" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">身份证号码:</li>
						<li><input type="text" value="" style="height: 30px" name="idCardNum" id="txt_idCardNum" maxlength="20"></li>
						<li></li>
					</ul>
					<ul>
						<li class="text-info">推荐人:</li>
						<li><input type="text" value="" style="height: 30px" name="recommender" id="txt_recommender" maxlength="20"></li>
						<li></li>
					</ul>
					<input type="submit" value="注册" onclick="addSave();"> 
				</form>
			</div>
		</div>
	</div>
</body>
</html>