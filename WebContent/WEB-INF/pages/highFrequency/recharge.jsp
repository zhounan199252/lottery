<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账户充值</title>
<link href="${pageContext.request.contextPath}/bootstrap-3.3.5/css/bootstrap.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/globle/js/front_bootstrap/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/globle/js/md5.js"></script>
<script type="text/javascript">

   function randomString(len) {
　　len = len || 30;
　　var $chars = '0123456789';    /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
　　var maxPos = $chars.length;
　　var pwd = '';
　　for (i = 0; i < len; i++) {
　　　　pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
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
	 var  data= "<Ips><GateWayRsp><head><ReferenceID></ReferenceID><RspCode>000000</RspCode><RspMsg><![CDATA[交易成功！]]>"+
"</RspMsg><ReqDate>20160620232636</ReqDate><RspDate>20160620232756</RspDate><Signature>18c739ca80b6d5f811c884ade79ec43b"+
"</Signature></head><body><MerBillNo>00000100012311</MerBillNo><CurrencyType>156</CurrencyType><Amount"+
">0.1</Amount><Date>20160620</Date><Status>Y</Status><Msg><![CDATA[支付成功！]]></Msg><IpsBillNo>BO2016062016540222593"+
"</IpsBillNo><IpsTradeNo>2016062011063671694</IpsTradeNo><RetEncodeType>17</RetEncodeType><BankBillNo"+
">710002784421</BankBillNo><ResultType>0</ResultType><IpsBillTime>20160620232703</IpsBillTime></body>"+
"</GateWayRsp></Ips>"; 
 $("#pay1").val(data);  
 $("#paymoney1").submit();
 
}
	

function rechargeSave() {	
	   var  balance =parseFloat($("#txt_balance").val());
	   var  bank =  $('#bank option:selected') .val();
	   var date= getNowDate();   
	  var merBillNo = randomString();
	   var  signature= "<body><MerBillNo>"+merBillNo+"</MerBillNo><Amount>"+balance+"</Amount><Date>"+date+"</Date><CurrencyType>156</CurrencyType>"+
     "<GatewayType>01</GatewayType><Lang></Lang><Merchanturl>http://ttquwan.com/</Merchanturl><FailUrl></FailUrl>"+
    "<Attach></Attach><OrderEncodeType>5</OrderEncodeType><RetEncodeType>17</RetEncodeType><RetType>1</RetType>"+
    "<ServerUrl>http://ttquwan.com/</ServerUrl><BillEXP></BillEXP><GoodsName>彩票</GoodsName><IsCredit>1</IsCredit>"+
    "<BankCode>"+bank+"</BankCode><ProductType>1</ProductType></body>180566xYXXG0JJMAGd3SysQ496j6aAOa6e2jdluBRXcrWQw1Nzjb3YtFmD0S6meOYas6T350vAZdUqJDJC0Zq9pBoGSVK6P2Ycg7p7NfSzlMnVKkqKhfjN1BVzDyfOJWuXuWzD"; 
	   var hash = MD5(signature);
	 var  data= "<Ips><GateWayReq><head><Version>v1.0.0</Version><MerCode>180566</MerCode><MerName>ttquwan</MerName>"+
  "<Account>1805660014</Account><MsgId></MsgId><ReqDate>20160617162015</ReqDate><Signature>"+hash+"</Signature></head>"+
 "<body><MerBillNo>"+merBillNo+"</MerBillNo><Amount>"+balance+"</Amount><Date>"+date+"</Date><CurrencyType>156</CurrencyType>"+
 "<GatewayType>01</GatewayType><Lang></Lang><Merchanturl>http://ttquwan.com/</Merchanturl><FailUrl></FailUrl>"+
"<Attach></Attach><OrderEncodeType>5</OrderEncodeType><RetEncodeType>17</RetEncodeType><RetType>1</RetType>"+
"<ServerUrl>http://ttquwan.com/</ServerUrl><BillEXP></BillEXP><GoodsName>彩票</GoodsName><IsCredit>1</IsCredit>"+
"<BankCode>"+bank+"</BankCode><ProductType>1</ProductType></body></GateWayReq></Ips>"; 
 $("#pay").val(data);  
 $("#paymoney").submit();
 
}
	

</script>
</head>
<body>
<form  style="display:none;" action="https://newpay.ips.com.cn/psfp-entry/gateway/payment.do" method="post" id="paymoney"> 
<input name="pGateWayReq" value=""   id="pay"/>
</form> 
<form  style="display:none;" action="betmessage!bankRecharge.action" method="post" id="paymoney1"> 
<input name="paymentResult" value=""   id="pay1"/>
</form> 
    <table class="table table-striped">
			<tr>
				<th>用户名</th>
				<td><s:textfield name="username" id="txt_username" cssClass="control-text"  maxLength="20" readonly="true"></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>金额</th>
				<td><s:textfield name="balance" id="txt_balance" cssClass="control-text"  maxLength="20" value=""></s:textfield></td>
				<td></td>
			</tr>
				<tr>
				<th>银行名</th>
				<td><s:select list="#{'1100':'工商银行', '1101':'农业银行', '1106':'建设银行', '1102':'招商银行',
				                      '1103':'兴业银行', '1104':'中信银行', '1107':'中国银行', '1108':'交通银行',
				                      '1109':'浦发银行','1110':'民生银行', '1111':'华夏银行', '1112':'光大银行', '1119':'邮政银行'
				                      
				}" listKey="key" listValue="value" headerKey="" headerValue="-请选择-" name="bank"></s:select></td>
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


</body>
</html>