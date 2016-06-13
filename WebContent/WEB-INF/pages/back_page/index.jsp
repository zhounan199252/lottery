<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<title>天天趣玩网--后台管理页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	function doLogout() {

		BUI.Message.Confirm('确认要退出本系统吗？', function() {
			location.href = "${pageContext.request.contextPath}/backUser!logout.action";
		}, 'question');
	}
</script>
</head>
<body>

	<div class="header">


		<div class="dl-title" align="center">天天趣玩网--后台管理系统</div>

		<div class="dl-log">
			欢迎您，
			<%-- <span class="dl-log-user">${sessionScope.backCurrentLoginUser.nickname}</span> --%>
			<span> <a id="systemOperate" href="javascript:void(0);" class="dl-log-quit" title="系统操作" style="padding: 0 25px 0 0">${sessionScope.backCurrentLoginUser.nickname}</a>
			</span>
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
						text : '后台用户管理',
						href : '${pageContext.request.contextPath}/backUser!listBackUser.action'
					} ]
				}, {
					text : '应用管理',
					items : [ {
						id : 'message',
						text : '消息发布',
						href : '${pageContext.request.contextPath}/backAnnouncement!listAnnouncement.action'
					}, {
						id : 'front_user',
						text : '前台用户管理',
						href : '${pageContext.request.contextPath}/frontUser!listFrontUser.action'
					} ,{
						id : 'front_user',
						text : '前台用户投注信息',
						href : '${pageContext.request.contextPath}/betmessage!listBackBetMessage.action'
					}]
				} ]
			} ];
			new PageUtil.MainPage({
				modulesConfig : config
			});
		});

		BUI.use('bui/menu', function(Menu) {
			dropMenu = new Menu.PopMenu({
				trigger : '#systemOperate',
				autoRender : true,
				triggerEvent : 'mouseenter',
				triggerHideEvent : 'mouseleave',
				autoHideType : 'leave',
				width : 140,
				zIndex : 10001,
				children : [ {
					id : 'logout',
					content : "退出系统"
				}, {
					id : "changePassowrd",
					content : "修改密码"
				} ]
			});
			dropMenu.on('itemselected', function() {
				//alert(dropMenu2.getSelectedText() + '：' + dropMenu2.getSelectedValue());
				if (dropMenu.getSelectedValue() == "logout") {
					doLogout();
				} else {

				}
			});

		});
	</script>
</body>
</html>
