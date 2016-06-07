
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/megamenu.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script>
	$(document).ready(function() {
		$(".megamenu").megamenu();
	});
</script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/simpleCart.min.js"></script>
</head>
<body>
		<!-- banner -->
	<div class="banner">
		<div class="container">
			<!-- Slider-starts-Here -->
			<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/responsiveslides.min.js"></script>
			<script>
				// You can also use "$(window).load(function() {"
				$(function() {
					// Slideshow 4
					$("#slider3").responsiveSlides({
						auto : true,
						pager : false,
						nav : true,
						speed : 500,
						namespace : "callbacks",
						before : function() {
							$('.events').append("<li>before event fired.</li>");
						},
						after : function() {
							$('.events').append("<li>after event fired.</li>");
						}
					});

				});
			</script>
			<!--//End-slider-script -->
			<div id="top" class="callbacks_container">
				<ul class="rslides" id="slider3">
					<li>
						<div class="banner-info">
							<div class="banner-info1">
								<div class="banner-inf">
									<h1>彩票，六合彩，体育彩票</h1>
									<p>
										彩票，六合彩，体育彩票<br> 优惠活动<br> 优惠活动<br>
									</p>

									<div class="buy">
										<a href="single.html">点击查看</a>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="banner-info">
							<div class="banner-info1">
								<div class="banner-inf">
									<h1>消息公告</h1>
									<p>
										消息公告<br> 优惠活动<br> 优惠活动<br>
									</p>
									<div class="buy">
										<a href="single.html">点击查看</a>
									</div>
								</div>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</div>


</body>
</html>