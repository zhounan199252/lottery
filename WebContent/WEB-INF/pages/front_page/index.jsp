<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>彩票中心主页</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/globle/images/logo.ico" />
<!-- //js -->
<!-- start-smoth-scrolling -->
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/move-top.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script>
<!-- start-smoth-scrolling -->
<!-- start menu -->
<link href="${pageContext.request.contextPath}/globle/css/front_bootstrap/megamenu.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script>$(document).ready(function(){$(".megamenu").megamenu();});</script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/megamenu.js"></script>
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/simpleCart.min.js"> </script>
</head>
	
<body>

<!-- top-header -->
<div class="top_bg">
	<div class="container">
		<div class="header_top-sec">
			<div class="top_left">
				<ul>
					<li><a href="login.html">登录</a></li>
					<li class="top_link"><a href="login.html">我的账户</a></li>					
				</ul>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<!-- top-header -->

<!-- logo-cart -->
<div class="header_top">
	<div class="container">
		<div class="logo">
		 	<a href="index.html">体育博彩网站</a>			 
		</div>
		<div class="header_right">
			<div class="cart box_1">
				<a href="checkout.html">
				    <span class="simpleCart_total  total"></span> 
					<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/cart1.png" alt=""/>
				</a>
				<p><a href="javascript:;" class="simpleCart_empty"></a></p>
				<div class="clearfix"> </div>
			</div>				 
		</div>
		<div class="clearfix"></div>	
	</div>
</div>
<!-- //logo-cart -->

<!-- 在线客服 -->
 <div   style="position: absolute; text-align: center; float: left; width: 10%; height: 10%; z-index: 10001; left: 90%; top: 80%; border: 2px">
	    <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1904037944&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1904037944:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
	</div>
	
<div class="mega_nav">
	 <div class="container">
		 <div class="menu_sec">
		 <!-- start header menu -->
		<ul class="megamenu skyblue">
			<li class="active grid"><a class="color1" onclick="showFirstPage();">首页</a></li>
			<li><a  class="color1" href="#">消息公告</a>
				
			</li>
			<li><a class="color1" href="#">体育赛事</a>
				
			</li>				
			<li><a class="color1" href="#">彩票游戏</a>
				
			</li>
			<li><a class="color1" onclick="gotoPage('${pageContext.request.contextPath}/lottery/lottery.jsp');">六合彩</a>
				
			</li>				
			<li><a  class="color1" href="#">优惠活动</a>
				
			</li>
			<li><a  class="color1" href="#">在线客服</a>
				
			</li>								
		</ul> 
		 </div>
	  </div>
</div>

<!-- banner -->
	<div class="banner">
		<div class="container">
<!-- Slider-starts-Here -->
				<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/responsiveslides.min.js"></script>
				 <script>
				 
				 /**
		                  跳转到指定的页面
				 */
				   function gotoPage(url) {
					$("#top").css("display", "none"); 
					$("#iframe_main").prop("src", url);
				  }
				   /**
		                 显示首页
				 */
				   function showFirstPage() {
					$("#top").css("display", "block"); 
					$("#iframe_main").prop("src","");
				  }
				 
				    // You can also use "$(window).load(function() {"
				    $(function () {
				      // Slideshow 4
				      $("#slider3").responsiveSlides({
				        auto: true,
				        pager: false,
				        nav: true,
				        speed: 500,
				        namespace: "callbacks",
				        before: function () {
				          $('.events').append("<li>before event fired.</li>");
				        },
				        after: function () {
				          $('.events').append("<li>after event fired.</li>");
				        }
				      });
				
				    });
				  </script>
			<!--//End-slider-script -->
				<div  id="top" class="callbacks_container"  >
				<ul class="rslides" id="slider3">
					<li>
						<div class="banner-info">
							<div class="banner-info1">
								<div class="banner-inf">
									<h1>彩票，六合彩，体育彩票</h1>
									<p>彩票，六合彩，体育彩票<br>
									优惠活动<br>		
									优惠活动<br>								
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
									<p>消息公告<br>
									优惠活动<br>		
									优惠活动<br>								
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
			<iframe  height="100%" width="100%" frameBorder="0" scrolling="auto" id="iframe_main"></iframe>
		</div>
	</div>
<!-- //banner -->


<!-- cate -->
	<div class="cate">
		<div class="container">
			<div class="cate-left">
				<h3>娱乐项目<span>Entertainment project</span></h3>
			</div>
			<div class="cate-right">
				<!-- slider -->
				<ul id="flexiselDemo1">			
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/tyss.jpg" alt=" " class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/zryl.jpg" alt=" " class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/sjtz.jpg" alt=" " class="img-responsive" />
						</div>
					</li>
					<li>
						<div class="sliderfig-grid">
							<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/ssc.jpg" alt=" " class="img-responsive" />
						</div>
					</li>
					</ul>
					<script type="text/javascript">
							$(window).load(function() {
								$("#flexiselDemo1").flexisel({
									visibleItems: 4,
									animationSpeed: 1000,
									autoPlay: true,
									autoPlaySpeed: 3000,    		
									pauseOnHover: true,
									enableResponsiveBreakpoints: true,
									responsiveBreakpoints: { 
										portrait: { 
											changePoint:480,
											visibleItems: 3
										}, 
										landscape: { 
											changePoint:640,
											visibleItems:4
										},
										tablet: { 
											changePoint:768,
											visibleItems: 3
										}
									}
								});
								
							});
					</script>
					<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery.flexisel.js"></script>
			</div>
<!-- //slider -->
			<div class="clearfix"> </div>
		</div>
	</div>
<!-- //cate -->

	<div class="footer-copy">
		<p>Copyright &copy; 2015.Company name All rights 程靓坤 <a href="#" target="_blank" title="程靓坤">程靓坤</a> - Collect from <a href="#" title="程靓坤" target="_blank">网页模板</a></p>
	</div>
</body>
</html>