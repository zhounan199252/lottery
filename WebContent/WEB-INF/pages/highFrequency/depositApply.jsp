<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
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
			money : { 
				required : true,
				digits : true,
			},
			bankNum: {
				required : true,
				digits : true,
			}
		
		},
		messages : { // 当验证不通过时显示的错误信息，也可以不指定，使用默认的
			money : { // 提示的位置要跟上面rules指定的位置一一对应
				required : "请输入提现金额"
			},
			bankNum : {
				required : "请输入银行卡号"
	
			}
		}
	});
});


</script>
</head>
<body style="background:#FFC">

<div   style="width: 68%; padding: 12px 0 0 20%"   align="center" > 
               <h3>提现申请</h3>
				<form action="depositApply!addDepositApply.action" id="form_add" method="post">
              <table class="table" >
			<tr>
				<th>姓名</th>
				<td >${sessionScope.frontCurrentLoginUser.nickname}</td>
				<td><input type="hidden" value="${sessionScope.frontCurrentLoginUser.id}" name="userId" ></td>
			</tr>
			<tr>
				<th>金额</th>
				<td><s:textfield name="money" id="money"  style="width:300px;height:30px;" cssClass="control-text"  maxLength="8" value=""></s:textfield></td>
				<td></td>
			</tr>
				<tr>
				<th>银行卡号</th>
				<td><s:textfield name="bankNum" id="bankNum" style="width:300px;height:30px;" cssClass="control-text"  maxLength="20" value=""></s:textfield></td>
				<td></td>
			</tr>
			<tr>
					<th>
						<button type="submit" class="button" >保存</button>
						<button type="reset" class="button" onclick="goBack();">取消</button>
					</th>
					<td></td>
					<td></td>
				</tr>				
	 </table>
	 </form> 	
	 
	   
</div>



</body>
</html>