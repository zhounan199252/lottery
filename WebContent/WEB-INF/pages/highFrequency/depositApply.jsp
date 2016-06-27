<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账户充值</title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/globle/js/md5.js"></script>
<script type="text/javascript">


function addSave() {
	  var re = /^[0-9]+[.]?[0-9]*]*$/ ;
      if(!re.test($("#money").val())){
  	   alert("不是数字") ;return;
       }
	$("#form_add").submit();
}
	

</script>
</head>
<body style="background:#FFC">
<div   align="center" >
          <h3>提现申请</h3>
				<form action="${pageContext.request.contextPath}/depositApply!addDepositApply.action" id="form_add" method="post">
              <table class="table" style="width: 50%" >
			<tr>
				<th>姓名</th>
				<td >${sessionScope.frontCurrentLoginUser.nickname}</td>
				<td><input type="hidden" value="${sessionScope.frontCurrentLoginUser.id}" name="userId" ></td>
			</tr>
			<tr>
				<th>金额</th>
				<td><s:textfield name="money" id="money" cssClass="control-text"  maxLength="20" value=""></s:textfield></td>
				<td></td>
			</tr>
				<tr>
				<th>银行卡号</th>
				<td><s:textfield name="bankNum" id="bankNum" cssClass="control-text"  maxLength="20" value=""></s:textfield></td>
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
	 </form> 	   
	   
</div>



</body>
</html>