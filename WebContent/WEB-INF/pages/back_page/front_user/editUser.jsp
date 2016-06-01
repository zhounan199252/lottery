<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑用户</title>
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
				username : { //
					required : true,
					remote : { // 远程验证用户名是否已经存在，后台返回true或者false,true代表通过验证，false代表不通过，会显示提示信息 
						url : "${pageContext.request.contextPath}/frontUser!checkFrontUsernameIsExist.action",
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


	function editSave() {
		
		$("#form_edit").submit();
	}

</script>
</head>
<body>
	<div style="width: 90%;padding: 12px 0 0 12px">
	<h2>前台用户管理--编辑用户</h2>
	
		<s:form action="frontUser!editFrontUser.action" id="form_edit">
		<s:hidden name="id"></s:hidden>
		<table class="table table-striped">
			<tr>
				<th style="width: 20%">姓名</th>
				<td style="width: 20%"><s:textfield name="nickname" id="txt_nickname" cssClass="control-text" maxLength="20"></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>用户名</th>
				<td><s:textfield name="username" id="txt_username" cssClass="control-text"  maxLength="20"></s:textfield></td>
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
					<button type="submit" class="button button-primary" onclick="editSave();">保存</button>
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