<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<style type="text/css">
div {
	margin-top: 10px;
	margin-bottom: 10px;
}
</style>
<body style="background: #FFC">

	<div align="center" id="main" style="height: 100%; overflow: auto;">
		<div style="width: 1086px;" align="left">

			<span class="label label-primary">【天天现金网】(www.ttquwan.com)</span>
			<div>
				<h3>拥有多元化的产品，使用最公平、公正、公开的系统，在市场上的众多博彩网站中，我们自豪的提供会员最优惠的回馈，给予合作伙伴最优势的营利回报! 无论您拥有的是网络资源，或是人脉资源，都欢迎您来加入天天现金网合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。天天现金网绝对可以共享联盟的选择.</h3>

			</div>

			<div align="center">
				<img src="${pageContext.request.contextPath}/globle/images/front_bootstrap/lmhz.png">
			</div>

			<span class="label label-primary">【联盟注册申请】</span>
			<div>
				<h3>请随时向天天现金网客服提出申请，并确实填写联系方式，一定要确实留下真实有效个人资料，天天现金网会评估审核联盟申请讯息，并将申请结果立即向您回应，注册联盟代理资料完全正确无误否则后果自负。</h3>
				<h3>联盟佣金计算，结算区间为本月1号至本月结束，将下级会员盈利，以联盟方案分红公式计算，扣除联盟体系会员相应的优惠、行政费用后，佣金由代理客服于每个月的5号左右与代理核对佣金后，在每个月的5号左右将佣金直接汇入代理联盟指定之银行帐号。每月代理联盟业绩于结算后归零重新开始。</h3>
				<h3>警告:请谨记任何使用不诚实方法以骗取代理佣金者将取消代理资格并永久冻结账户，佣金一律不予发还！</h3>


			</div>


			<div>
				<span class="label label-primary">推广链接</span>
				<h3>
					<a class="color1" href="${pageContext.request.contextPath}/tore.url?id=${sessionScope.frontCurrentLoginUser.id}">http://ttquwan.com?id=${sessionScope.frontCurrentLoginUser.id}</a>
				</h3>
			</div>


		</div>
	</div>

</body>
</html>
