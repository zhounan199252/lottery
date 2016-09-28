<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<script src="${pageContext.request.contextPath}/globle/js/des.js"></script>
<script type="text/javascript">
	$(function() {

		// jqueryValidate 表单验证开始
		var validateForm = $("#form_changePassword").validate({

			submitHandler : function(form) {// 当表单验证全部通过后，会执行此方法

				var passowrdEnc = strEnc($("#txt_password").val(), "${sessionScope.firstKey_fu}", "${sessionScope.secondKey_fu}", "${sessionScope.thirdKey_fu}");
				$("#txt_password").val(passowrdEnc);

				form.submit();
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.parent("td").next("td")); // 指定显示错误信息的位置
			},
			rules : { // 指定验证规则
				oldPassword : { //
					required : true,
					remote : { // 远程验证用户名是否已经存在，后台返回true或者false,true代表通过验证，false代表不通过，会显示提示信息 
						url : "${pageContext.request.contextPath}/chkpass.url",
						type : "post",
						data : { // 附带发送的数据
							"password" : function() {

								var passowrdEnc = strEnc($("#txt_oldPassword").val(), "${sessionScope.firstKey_fc}", "${sessionScope.secondKey_fc}", "${sessionScope.thirdKey_fc}");

								return passowrdEnc;
							}
						}
					}
				},
				password : {
					required : true,
					minlength : 8
				},
				rePassword : {
					required : true,
					equalTo : "#txt_password" // 表示与那个节点的数值相等
				}
			},
			messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的
				oldPassword : { // 提示的位置要跟上面rules指定的位置一一对应
					required : "请输入原密码",
					remote : "原密码错误"
				},
				password : {
					required : "请输入新密码",
					minlength : "密码不能小于8位"
				},
				rePassword : {
					required : "请输入确认密码",
					equalTo : "两次输入的密码不相同"
				}
			}
		});
		// jqueryvalidate 表单验证结束
	});

	function addSave() {

		$("#form_changePassword").submit();
	}
</script>
</head>
<body style="background: #FFC">
	<div style="width: 48%; padding: 12px 0 0 20%" align="center">
		<s:form action="/cp.url" id="form_changePassword">
			<table class="table">
				<tr>
					<th>原密码</th>
					<td><s:password name="oldPassword" id="txt_oldPassword" cssClass="control-text" maxLength="50"></s:password></td>
					<td></td>
				</tr>
				<tr>
					<th>新密码</th>
					<td><s:password name="password" id="txt_password" cssClass="control-text" maxLength="50"></s:password></td>
					<td></td>
				</tr>
				<tr>
					<th>确认密码</th>
					<td><s:password name="rePassword" id="txt_rePassword" cssClass="control-text" maxLength="20"></s:password></td>
					<td></td>
				</tr>
					<tr>
					<th><button type="submit" class="button" onclick="addSave();">保存</button>
		                 <button type="reset" class="button" onclick="goBack();">取消</button></th>
					<td></td>
					<td></td>
				</tr>

			</table>
		</s:form>
		
	</div>
</body>
</html>