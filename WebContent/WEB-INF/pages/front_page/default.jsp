
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
									<h1>体育赛事</h1>
									<p>
										篮球竞彩<br> 足球竞彩<br>
									</p>

									<div class="buy">
										<a href="">点击查看</a>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="banner-info">
							<div class="banner-info1">
								<div class="banner-inf">
									<h1>六合彩</h1>
									<p>
										广东十一选五<br>双色球<br>大乐透<br>七星彩<br>
									</p>
									<div class="buy">
										<a href="">点击查看</a>
									</div>
								</div>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</div>

	<!-- //banner -->


	<!-- cate -->
	<div class="cate">
		<div class="container">
			<div class="cate-left">
				<h3>
					本站彩种<span>Lottery project</span>
				</h3>
			</div>
			<div class="cate-right">
				<!-- slider -->
				<ul id="flexiselDemo1">
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/football.jpg" alt="足球竞彩" title="足球竞彩" class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/basketball.jpg" alt="篮球竞彩" title="篮球竞彩" class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/dlt.jpg" alt="大乐透" title="大乐透" class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/ssq.jpg" alt="双色球" title="双色球" class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/qxc.jpg" alt="七星彩" title="七星彩" class="img-responsive" />
						</div>
					</li>
				</ul>
				<script type="text/javascript">
					$(window).load(function() {
						$("#flexiselDemo1").flexisel({
							visibleItems : 4,
							animationSpeed : 1000,
							autoPlay : true,
							autoPlaySpeed : 3000,
							pauseOnHover : true,
							enableResponsiveBreakpoints : true,
							responsiveBreakpoints : {
								portrait : {
									changePoint : 480,
									visibleItems : 3
								},
								landscape : {
									changePoint : 640,
									visibleItems : 4
								},
								tablet : {
									changePoint : 768,
									visibleItems : 3
								}
							}
						});

					});
				</script>
				<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery.flexisel.js"></script>
			</div>
			<!-- //slider -->
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- //cate -->
	<div class="footer-copy" style="height: 160px">
		
		<p style="color: black">
			Copyright &copy; 2015 - 2016.<a href="http://www.ttquwan.com" target="_blank">天天趣玩网</a> 版权所有 <a href="http://www.ttquwan.com/tbul.url" target="_blank" title="后台管理" class="color1">后台管理</a><br> 提醒：购买彩票有风险，在线投注需谨慎，不向未满18周岁的青少年出售彩票及提供彩票代购服务
		</p>
	</div>
</body>
</html>