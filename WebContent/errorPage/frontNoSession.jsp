<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" charset="utf-8">
$(function(){
	BUI.Message.Confirm("${requestScope.msg}",function(){
		location.href = "${pageContext.request.contextPath}/tolo.url";

		//在被嵌套时就刷新上级窗口
		if(window.parent != window){
			window.parent.location.reload(true); 
		} 
	}, "question");
});

</script>
</head>
<body>
</body>
</html>
