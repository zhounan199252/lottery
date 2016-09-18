<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账户充值</title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/globle/js/md5.js"></script>
<script type="text/javascript">

   function randomString() {
   var  len =  30;
   var chars = '0123456789';   
   var pwd = '';
   var maxPos=chars.length;
   for (var i = 0; i < len; i++) {
   pwd += chars.charAt(Math.floor(Math.random() * maxPos));
   }
   return pwd;
   }
  
  
function getNowDate() {
    var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
     }
     if (strDate >= 0 && strDate <= 9) {
         strDate = "0" + strDate;
     }
   
    var currentDate =""+ date.getFullYear()+ month+strDate;
    return currentDate;

} 
	
function recharge() {	
	  var re = /^[0-9]+[.]?[0-9]*]*$/ ;
      if(!re.test($("#txt_balance").val())){
  	   alert("不是数字") ;return;
       }
	   var  balance =parseFloat($("#txt_balance").val());  
	   var  bank =  $('#bank option:selected').val();	   
	   if(bank==""){ alert("请选择银行"); return;}
	   var date= getNowDate();   
	   var merBillNo = randomString();
	   var userId= '${sessionScope.frontCurrentLoginUser.id}';
	   var  signature= "<body><MerBillNo>"+merBillNo+"</MerBillNo><Amount>"+balance+"</Amount><Date>"+date+"</Date><CurrencyType>156</CurrencyType>"+
     "<GatewayType>01</GatewayType><Lang></Lang><Merchanturl>http://ttquwan.com/betmessage!bankRecharge.action</Merchanturl><FailUrl></FailUrl>"+
    "<Attach>"+userId+"</Attach><OrderEncodeType>5</OrderEncodeType><RetEncodeType>17</RetEncodeType><RetType>1</RetType>"+
    "<ServerUrl>http://ttquwan.com</ServerUrl><BillEXP></BillEXP><GoodsName>彩票</GoodsName><IsCredit>1</IsCredit>"+
    "<BankCode>"+bank+"</BankCode><ProductType>1</ProductType></body>180566SP1uQZrWcmt1HXZc3h7dpmtDyL0wLU35rD788XZESTTunm1rFCzKqVWvDuZJceA8PpJMbCCw7cznr64wEuqDhA9TAl1KxcHbc3BYl8oheB3bTw2B2mHeM1jcKpg950NK"; 
	   var hash = MD5(signature);
	 var  data= "<Ips><GateWayReq><head><Version>v1.0.0</Version><MerCode>180566</MerCode><MerName>ttquwan</MerName>"+
  "<Account>1805660014</Account><MsgId></MsgId><ReqDate>20160617162015</ReqDate><Signature>"+hash+"</Signature></head>"+
 "<body><MerBillNo>"+merBillNo+"</MerBillNo><Amount>"+balance+"</Amount><Date>"+date+"</Date><CurrencyType>156</CurrencyType>"+
 "<GatewayType>01</GatewayType><Lang></Lang><Merchanturl>http://ttquwan.com/betmessage!bankRecharge.action</Merchanturl><FailUrl></FailUrl>"+
"<Attach>"+userId+"</Attach><OrderEncodeType>5</OrderEncodeType><RetEncodeType>17</RetEncodeType><RetType>1</RetType>"+
"<ServerUrl>http://ttquwan.com</ServerUrl><BillEXP></BillEXP><GoodsName>彩票</GoodsName><IsCredit>1</IsCredit>"+
"<BankCode>"+bank+"</BankCode><ProductType>1</ProductType></body></GateWayReq></Ips>"; 
 $("#pay").val(data);  
 $("#paymoney").submit();
 
}
	

</script>
</head>
<body style="background: #FFC">
	<div style="width: 68%; padding: 12px 0 0 20%"    align="center">
	  <h3>网银充值</h3>
		<table class="table" >
			<tr>
				<th>姓名</th>
				<td >${sessionScope.frontCurrentLoginUser.nickname}</td>

				<td></td>
			</tr>
			<tr>
				<th>金额</th>
				<td><s:textfield name="balance" id="txt_balance" cssClass="control-text" maxLength="20" value=""></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>银行名</th>
				<td><s:select list="#{'1100':'工商银行', '1101':'农业银行', '1106':'建设银行', '1102':'招商银行',
				                      '1103':'兴业银行', '1104':'中信银行', '1107':'中国银行', '1108':'交通银行',
				                      '1109':'浦发银行','1110':'民生银行', '1111':'华夏银行', '1112':'光大银行', '1119':'邮政银行'
				                      
				}" listKey="key" listValue="value" headerKey="" headerValue="-请选择-" id="bank"></s:select></td>
				<td></td>
			</tr>
			<tr>
				<th>
					<button type="submit" class="button button-primary" onclick="recharge();">保存</button>
					<button type="reset" class="button" onclick="goBack();">取消</button>
				</th>
				<td></td>
				<td></td>
			</tr>

		</table>

		<div align="left">
			网银充值需知：<br> 最低存款为￥100人民币，最高存款无限制。 未开通网银的会员，请您去银行柜台办理。 如有任何问题，请24小时线上客服!<br> 为了防止会员支付密码泄露和资金安全问题天天现金网只支持第三方网银转账充值存款方式，目前提供23个网银在线支付，中国工商银行、中国农业银行、中国建设银行，中国邮政银行，信业银行，民生银行，上海银行，等等以下银行可选择 ，也支持信用卡转账充值存款方式，支持15种信用卡转账充值方式，您选择方便的转帐方式转帐完成后，在页面下方填写您的汇款金额，转账支付成功，额度将立即自动加入您的天天现金网会员帐户，十分钟之内金额没有到平台帐户，请即时联系天天在线客服
		</div>

	<form style="display: none;"  action="https://newpay.ips.com.cn/psfp-entry/gateway/payment.do" method="post" id="paymoney">
		<input name="pGateWayReq" value="" id="pay" />
	</form>

</div>
    <div style="width: 68%; padding: 12px 0 0 20%"    align="center">
	  <h3> 支付宝充值</h3>
		<div align="left">
       
		                 收款人账号：<span class="label label-primary">wangjia08@foxmail.com</span><br>
		                 收款人姓名：<span class="label label-primary">符成海</span>  <br>
		                支付宝充值需知：进行支付宝转账的时候付款说明里面要填写您的平台用户名或姓名方可自动到账，如有问题请及时联系在线客服咨询
		                
		    <h4> 支付宝链接   <a  target="_blank" class="color1" href="https://auth.alipay.com/login/index.htm">https://auth.alipay.com/login/index.htm</a></h4>   
		</div>
</div>

</body>
</html>