<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<title>天天趣玩网_安全买彩票，幸福中大奖</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/megamenu.css" rel="stylesheet" type="text/css" media="all" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/globle/images/logo.ico" />

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".megamenu").megamenu();
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
		});

		$(".for_active").click(function() {
			$(this).addClass("active");
			$(this).siblings("li").removeClass("active");
		});

	});

	function gotoPage(url) {
		$("#iframe_main").prop("src", url);
	}
	
	function doLogout() {
		if(confirm("确定要退出吗？")) {
			gotoPage('${pageContext.request.contextPath}/flo.url');
		}
	}
</script>

<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/simpleCart.min.js">
	
</script>
</head>

<body >
	<!-- top-header -->
	<div class="top_bg" >
		<div class="container">
			<div class="header_top-sec">
				<div class="top_right">
					<ul>
						<li><a href="javascript:void(0)">你好,欢迎来到天天趣玩网彩票！</a></li>
					</ul>
				</div>
				<div class="top_left" id="nav">
					<ul class="">
						<s:if test="#session.frontCurrentLoginUser == null">
							<li><a href="javascript:gotoPage('${pageContext.request.contextPath}/tolo.url');">登录</a></li>
							<li>|</li>
							<li><a href="javascript:gotoPage('${pageContext.request.contextPath}/tore.url');">注册</a></li>
						</s:if>
						<s:else>
							<li>欢迎您，${sessionScope.frontCurrentLoginUser.nickname}</li>
							<li><a href="javascript:gotoPage('${pageContext.request.contextPath}/myC.url');">我的账户</a></li>
							<li><a href="javascript:gotoPage('${pageContext.request.contextPath}/myB.url');">投注记录</a></li>
							<li><a href="javascript:gotoPage('${pageContext.request.contextPath}/tcp.url');">修改密码</a></li>
							<li><a href="javascript:doLogout();">退出</a></li>
						</s:else>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 标题栏 -->
	<div class="header_top" style="height: 90px">
		<div class="container">
			<div class="logo">
				<a href="javascript:void(0)">天天趣玩网</a>
			</div>
			<div class="header_right">
				<div class="cart box_1">	
					<!-- <font style="color: red">TEL:5566335544</font>&nbsp; -->
					<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1904037944&site=qq&menu=yes"><img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/kefu.png" alt="在线客服" title="点击咨询在线客服"/></a>
				</div>
			
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	
	
	<!-- 菜单栏-->
	<div class="mega_nav">
		<div class="container">
			<div class="menu_sec">
				<!-- start header menu -->
				<ul class="megamenu skyblue">
					<li class="active grid for_active"><a class="color1" href="javascript:gotoPage('${pageContext.request.contextPath}/default.url');">首页</a></li>
					<li class="for_active"><a class="color1" href="javascript:gotoPage('${pageContext.request.contextPath}/an.url');">消息公告</a></li>
					<li class="for_active"><a class="color1" href="#">体育赛事</a></li>
					<li class="for_active"><a class="color1" href="#">彩票游戏</a></li>
					<li class="for_active"><a class="color1" onclick="javascript:gotoPage('${pageContext.request.contextPath}/numLottery.url');">六合彩</a></li>
					<li class="for_active"><a class="color1" href="javascript:gotoPage('${pageContext.request.contextPath}/fa.url');">优惠活动</a></li>
					<!-- <li><a class="color1" href="#">在线客服</a></li> -->
				</ul>
			</div>
		</div>
	</div>

	<!-- 主体部分 -->
	<div class="banner" style="height: 800px; width: 100%">
		<div class="container" style="height: 800px; width: 100%">
			<iframe width="100%" frameBorder="0" scrolling="no" id="iframe_main" src="${pageContext.request.contextPath}/default.url" style="width: 100%; height: 1000px"></iframe>
		</div>
	</div>
	
</body>
</html>