<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加用户</title>
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
				opentime : { //
					required : true
// 					remote : { // 远程验证用户名是否已经存在，后台返回true或者false,true代表通过验证，false代表不通过，会显示提示信息 
// 						url : "${pageContext.request.contextPath}/frontUser!checkFrontUsernameIsExist.action",
// 						type : "post",
// 						data : { // 附带发送的数据
// 							"opentime" : function() {
// 								return $("#opentime").val();
// 							} 
// 						}
//					}
				},
			
				opencode: {
					required : true,
					digits : true,
				}
			
			},
			messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的
				opentime : { // 提示的位置要跟上面rules指定的位置一一对应
					required : "请输入开奖日期",
					remote : "用户名已存在"
				},
				opencode : {
					required : "请输入开奖号码",
					minlength : "开奖号码为480位"
				}
			}
		});
		// jqueryvalidate 表单验证结束
	});


</script>
</head>
<body>
	<div style="width: 90%; padding: 12px 0 0 12px">
		<h2>永乐十分彩--添加开奖号码</h2>

		<s:form action="openMessage!saveYlsfcCode.action" id="form_add">
			<table class="table table-striped">
				<tr>
					<th style="width: 20%">开奖类型</th>
					<td style="width: 20%"><s:textfield name="type" id="type" readonly="true"  value="永乐十分彩"  cssClass="control-text" maxLength="20"></s:textfield></td>
					<td></td>
				</tr>
					<tr>
					<th>开奖日期</th>
					<td><s:textfield name="opentime" id="opentime" cssClass="control-text Wdate" readonly="true"  onClick="WdatePicker({dateFmt:'yyyyMMdd'})"></s:textfield></td>
					<td></td>
				</tr>
				<tr>
					<th>开奖号码</th>
					<td><s:textarea style="width:300px;height:400px;"  name="opencode" id="opencode"  cssClass="control-text" minLength="480"  maxLength="480"></s:textarea></td>
					<td></td>
				</tr>
				<tr>
					<th>
						<button type="submit" class="button button-primary" >保存</button>
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