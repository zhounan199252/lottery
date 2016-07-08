<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<title>网站内部发生错误...</title>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/globle/images/logo.ico" />
<STYLE type=text/css>
body {
	margin: 0 auto;
	background: #FFF;
	text-align: center;
}

a:link {
	text-decoration: none;
	color: #03F;
}

a:visited {
	text-decoration: none;
	color: #F60;
}

a:hover {
	text-decoration: underline;
	color: #F60;
}

a:active {
	text-decoration: none;
	colorwhite;
}

.main {
	margin: 0 auto;
}

.con {
	margin: 0 auto;
	width: 540px;
}

.errorPic {
	margin: 0 auto;
	width: 329px;
	height: 211px;
	padding: 10px;
}

.errorNotes {
	
}

.errorNotes ul {
	height: 30px;
}

.errorNotes li {
	float: left;
	width: 150px;
	text-align: center;
	line-height: 30px;
	list-style: none;
}

.re {
	margin: 0 auto;
	width: 280px;
	text-align: center;
}

.re .title {
	text-align: center;
	line-height: 30px;
	font-size: 20px;
	font-weight: bold;
	color: #F00;
}

.re dt {
	text-align: left;
	line-height: 30px;
}
</STYLE>
<BODY>
	<div class="main">
		<div class="con">
			<div class="errorPic">
				<img src="${pageContext.request.contextPath}/globle/images/500.jpg">
			</div>
			<div class="errorNotes">
				<div class="re">
					<div class="title">抱歉，网站内部发生错误……</div>
					<dl>
						<dt>
							1、如果您有紧急情况，请<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1904037944&site=qq&menu=yes">联系客服</a>
						</dt>
						<dt>
							2、或者<a href="javascript:history.go(-1);">返回上一页</a>
						</dt>
					</dl>
				</div>
			</div>
		</div>
	</div>