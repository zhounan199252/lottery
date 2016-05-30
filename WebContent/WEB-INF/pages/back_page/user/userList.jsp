<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>

<script type="text/javascript">
	function doInitPassword(url) {
		var checkboxs = $("[name=ids]:checked");
		
		if(checkboxs.length <= 0) {
			BUI.Message.Alert("请选择一个用户进行密码初始化！");
			return false;
		}
		
		if(checkboxs.length > 1) {
			BUI.Message.Alert("每次只能选择一个用户进行密码初始化！");
			return false;
		}
		
		BUI.Message.Confirm('确认要初始化该用户的密码为 88888888 么？',function(){
			 
			var id = $(checkboxs).prop("value");
			 
			 var _url = url + "?id=" + id;
			 location.href = _url;
	     },'question');
	}
	
</script>

</head>
<body>

	<form action="${pageContext.request.contextPath}/backUser!listBackUser.action" method="post" id="form_search"></form>


	<div class="container span24">
		<div class="row span24">
			<div class="row" style="padding: 10px 0 0 10px">
				<div class="control-group span24">
					<label class="control-label">
						<button class="button" onclick="doAdd('${pageContext.request.contextPath}/backUser!addBackUserPage.action');">添加</button>
					</label> <label class="control-label">
						<button class="button" onclick="doUpdate('${pageContext.request.contextPath}/backUser!editBackUserPage.action')">编辑</button>
					</label> <label class="control-label">
						<button class="button" onclick="doRemove('${pageContext.request.contextPath}/backUser!deleteBackUser.action');">删除</button>
					</label>
					<label class="control-label">
						<button class="button" onclick="doInitPassword('${pageContext.request.contextPath}/backUser!initBackUserPassword.action');">初始化密码</button>
					</label>
				</div>
			</div>
			<div class="row span24">
				<div class="control-group span24">
					<table class="table table-striped table-bordered">
						<tr>
							<th style="width: 30px"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)"></th>
							<th>姓名</th>
							<th>用户名</th>
							<th>注册时间</th>
							<th>上次登录时间</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>${nickname}</td>
								<td>${username}</td>
								<td>${registerTime}</td>
								<td>${lastLoginTime}</td>
							</tr>
						</s:iterator>

					</table>


				</div>
			</div>
			<div class="row" style="padding-left: 10px">
				<div class="control-group span24 ">
					<jsp:include page="/globle/jsp/pageView.jsp"></jsp:include>
				</div>
			</div>
		</div>


	</div>























</body>
</html>