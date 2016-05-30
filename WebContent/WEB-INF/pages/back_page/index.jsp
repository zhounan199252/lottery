<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<title>后台管理主页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

	<div class="header">

		<div class="dl-title">彩票中心--后台管理系统</div>

		<div class="dl-log">
			欢迎您，<span class="dl-log-user">${sessionScope.backCurrentLoginUser.nickname}</span><a href="###" title="退出系统" class="dl-log-quit">[退出]</a>
		</div>
	</div>
	<div class="content">
		<div class="dl-main-nav">
			<ul id="J_Nav" class="nav-list ks-clear">
				<li class="nav-item dl-selected"><div class="nav-item-inner nav-home">首页</div></li>
			</ul>
		</div>
		<ul id="J_NavContent" class="dl-tab-conten">

		</ul>
	</div>

	<script>
		BUI.use('common/main', function() {
			var config = [ {
				id : 'menu',
				homePage : 'welcome',
				menu : [ {
					text : '系统管理',
					items : [ {
						id : 'welcome',
						text : '欢迎页面',
						href : '${pageContext.request.contextPath}/backIndex!toWelcomePage.action',
						closeable : false
					}, {
						id : 'back_user',
						text : '用户管理',
						href : '${pageContext.request.contextPath}/backUser!listBackUser.action'
					} ]
				}, {
					text : '应用管理',
					items : [ {
						id : 'message',
						text : '消息公告',
						href : 'main/operation.html'
					}, {
						id : 'function',
						text : '优惠活动',
						href : 'main/quick.html'
					} ]
				} ]
			} ];
			new PageUtil.MainPage({
				modulesConfig : config
			});
		});
	</script>
</body>
</html>
