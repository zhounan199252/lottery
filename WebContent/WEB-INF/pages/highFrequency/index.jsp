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
 .checked{
 color:white;
 background-color:red; 
 }
 
 .span_cicle{
border-radius: 14px;
border:1px solid #000; 
margin-bottom: 5px;
}
 .span_style{
}
</style>

 <script>
 $(function(){ 
  $("#gd11x5").click();
<!--   pay() ;-->
	 });
 
 function waring(message) {
	var  waring='<div  style="position:absolute;left:30%;top:40%;" class="alert alert-info alert-dismissible" role="alert">'+
		 '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
		 '<strong>提示:</strong>'+message+'</div>';
	     $("#main").append(waring);
	  
 }
 
 

 function pay() {
         var  data= "<Ips> <GateWayReq> <head> <Version>v7.0.0</Version> <MerCode>180566</MerCode> "+
           "<MerName></MerName> <Account>6222620710</Account> <MsgId></MsgId><ReqDate>20160617162015</ReqDate>"+ 
          "<Signature>17</Signature> </head> <body>"+ 
       "<MerBillNo>00000100012311</MerBillNo> <Amount>1.0</Amount> <Date>20160617</Date> <CurrencyType>156</CurrencyType >"+ 
      "<GatewayType>01</GatewayType> <Lang></Lang> <Merchanturl>http://ttquwan.com/</Merchanturl> <FailUrl></FailUrl>"+ 
      "<Attach></Attach> <OrderEncodeType>5</OrderEncodeType> <RetEncodeType>17</RetEncodeType> <RetType>1</RetType>"+
      "<ServerUrl>http://ttquwan.com/</ServerUrl> <BillEXP></BillEXP> <GoodsName>zhounan</GoodsName> <IsCredit>1</IsCredit>"+ 
      "<BankCode>1108</BankCode> <ProductType>1</ProductType></body> </GateWayReq></Ips>"; 
      $("#pay").val(data);  
      $("#paymoney").submit();
 }
 
      
 
  var expect="";
  var expect2="";
  var expect3="";
  var expect4="";
 //查看当前最新开奖期数
	function lookExpect(name) {
	  
		$.ajax({
			url : "http://f.apiplus.cn/"+name+"-1.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
		    async:false,
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {   
			       if(name=="ssq"){
			       expect=  data[0].expect;	
			       }else if(name=="dlt"){ 
			       expect2=  data[0].expect;	
				   }else if(name=="qxc"){ 
				    expect3=  data[0].expect;	
				   }else if(name=="bjpk10"){ 
				    expect3=  data[0].expect;
				    var date1 = new Date();
				    var date2 = eval('new Date(' + data[0].opentime.replace(/\d+(?=-[^-]+$)/,
                      function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
                      if(date1.getTime()-date2.getTime()<300000){
                        expect4=  data[0].expect;	
				      }else if(date1.getTime()-date2.getTime()>9*60*60*1000+180000){
                        expect4=  data[0].expect;	
				      }else if(date1.getTime()-date2.getTime()>9*60*60*1000+600000){
                        expect4=  parseInt(data[0].expect)+1;	
				      }else{
				       expect4= parseInt(data[0].expect)+1;
				      }
				    }  
				 }
				}
			});		
	}
	
	
//获取当前21选5期数	
 function getNowPeroid(name) {
     var date = new Date();
     var month = date.getMonth() + 1;
     var strDate = date.getDate();
     var hour = date.getHours();
     var minute= date.getMinutes();
    
     if (month >= 1 && month <= 9) {
        month = "0" + month;
     }
     if (strDate >= 0 && strDate <= 9) {
         strDate = "0" + strDate;
     }
      var peroid="";
      if(name=="gd11x5"){
       peroid = parseInt((hour-9)*6+minute/10);
       if(peroid >= 1 && peroid <= 9){
    	 peroid = "0" + peroid;
       }
      }else if(name=="cqssc"){
        if(hour>=10){
         peroid = parseInt(24+(hour-10)*6+minute/10);
        }else if(hour>=22){
         peroid = parseInt(96+(hour-22)*12+minute/5);
        }else if(hour<2){
         peroid = parseInt((hour-0)*12+minute/5);
        }else if(hour>=2&&hour<10){
         peroid = parseInt(23);
        }
        if(peroid >= 1 && peroid <= 9){
    	 peroid = "00" + peroid;
       }else if(peroid >= 10 && peroid <= 99){
    	 peroid = "0" + peroid;
       }  
      }
   
     var currentperoid = date.getFullYear()+ month+strDate+ peroid;
     return currentperoid;

 }  

   function timeLimate(name){
      var date = new Date();
      var day = date.getDay();
      var hours = date.getHours();
      if(day==2||day==4||day==6){
       if(hours==21&&name=="ssq"){
         return  false; 
        }else if(hours==20&&name=="dlt"){
         return  false; 
        }
        }
      
      if(day==0||day==2||day==5){
          if(hours==20&&name=="qxc"){
            return  false; 
           }
       } 
     
      if((hours<9||hours>22)&&name=="gd11x5"){
        return  false; 
       } 
       if((hours<9)&&name=="bjpk10"){
        return  false; 
       }     
       return  true;
   }
 
 
 //选号
 function check(node) {
	 if(!$(node).hasClass("checked")){
      $(node).addClass("checked");
	 }else{
	  $(node).removeClass("checked");
	 } 
	 
 }
 
 //判断选号是否正确
  function checkLengh(name) {
       if(name=="gd11x5"){
        var num = $("#select"+name).children(".checked").length;
        if(num<2||num>5){
			return false;
			}
       }else if(name=="ssq"){
       var num1 = $("#select1"+name).children(".checked").length;
       var num2 = $("#select2"+name).children(".checked").length;
        if(num1!="6"||num2!="1"){
			return false;
			}
       }else if(name=="dlt"){
       var num3 = $("#select1"+name).children(".checked").length;
       var num4 = $("#select2"+name).children(".checked").length;
        if(num3!="5"||num4!="2"){
			return false;
			} 
       }else if(name=="qxc"){
    	      for(var i=1;i<=7;i++){
 	    	 var num5=$("#select"+i+name).children(".checked").length;
 	    	   if(num5!="1"){
     			return false;
     			} 
              }
 	   }else if(name=="cqssc"){
    	      for(var i=1;i<=5;i++){
 	    	 var num6=$("#select"+i+name).children(".checked").length;
 	    	   if(num6!="1"){
     			return false;
     			} 
              }
 	       }else if(name=="bjpk10"){
    	      for(var i=1;i<=10;i++){
 	    	 var num7=$("#select"+i+name).children(".checked").length;
 	    	   if(num7!="1"){
     			return false;
     			} 
              }
 	       }
           	
  
	 return true;
 }
 
  
  

 
  //下注
 function buy(name) {
	           var  betPeriod="";
	           var betNum="";
	           var betType="";
	           var betQuan="";
	           var betPerson="";
	           var  id="";
	           if(name=="1"){
	        	   id="gd11x5";
	        	   if(timeLimate(id)==false){
	        		   waring("已过投注时间");
	        	     return;
	        	    }
	        	    if(checkLengh(id)==false){
	        	    	waring("请选择2-5个号码");
	        	     return;
	        	    }
	        	    betType="广东11选5";
	        	   betPeriod =parseInt(getNowPeroid(id))+1;
	        	   $("#select"+id).children(".checked").each(function (index, domEle) { 
	                   var num= $(domEle).text(); 
	                     betNum =betNum+num+",";
	  			   });
	           }else if(name=="2"){
	        	   id="ssq";
	        	   lookExpect(id);
	        	    if(timeLimate(id)==false){
	        	    	waring("21-22点禁止下注");
	        	     return;
	        	    }
	        	   if(checkLengh(id)==false){
	        		   waring("只能选择6个红球。1个蓝球");
	        	     return;
	        	    }
	        	   betType="双色球";
	        	    if(expect!=""){
	        	    betPeriod =parseInt(expect)+1;
	        	   }else {
	        		   waring("获取期数错误");
	        	   return;
	        	   }
	        	    $("#select1"+id).children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
	        	    $("#select2"+id).children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	           }else if(name=="3"){
	        	      id="dlt";
	        	      lookExpect(id);
	                 if(timeLimate(id)==false){
	                waring("20-21点禁止下注");
	        	     return;
	        	     }
	        	     if(checkLengh(id)==false){
	        	     waring("只能选择5个红球。2个蓝球");
	        	     return;
	        	    }
	        	     betType="大乐透";
	        	    if(expect2!=""){
	        	    betPeriod = parseInt(expect2)+1;
	        	     }else {
	        	     waring("获取期数错误");
	        	     return;
	        	    }
	        	    
	        	     
	        	     $("#select1"+id).children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+num+",";
		   			   });
		        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
		        	    $("#select2"+id).children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+num+",";
		   			   });
	           }else if(name=="4"){
	        	      id="qxc";
	        	      lookExpect(id);
	                 if(timeLimate(id)==false){
	                waring("20-21点禁止下注");
	        	     return;
	        	     }
	        	     if(checkLengh(id)==false){
	        	     waring("请每位选择一个");
	        	     return;
	        	    }
	        	     betType="七星彩";
	        	    if(expect3!=""){
	        	    betPeriod = parseInt(expect3)+1;
	        	     }else {
	        	     waring("获取期数错误");
	        	     return;
	        	    }
	  
	        	     for(var i=1;i<=7;i++){
	        	    	  $("#select"+i+id).children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+num+",";
			   			   });
	        	     }
	        	   
	           }else if(name=="5"){
	        	      id="cqssc";
	        	      if(timeLimate(id)==false){
	        		   waring("已过投注时间");
	        	     return;
	        	    }
	        	    if(checkLengh(id)==false){
	        	    	waring("请每位选择一个");
	        	     return;
	        	    }
	        	    betType="重庆时时彩";
	        	   betPeriod =parseInt(getNowPeroid(id))+1;
	        	     
	        	     for(var i=1;i<=5;i++){
	        	    	  $("#select"+i+id).children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+num+",";
			   			   });
	        	     }
	        	   
	           }else if(name=="6"){
	        	      id="bjpk10";
	        	       lookExpect(id);
	        	      if(timeLimate(id)==false){
	        		   waring("已过投注时间");
	        	       return;
	        	      }
	        	       if(checkLengh(id)==false){
	        	    	waring("请每位选择一个");
	        	        return;
	        	      }
	        	      betType="北京pk10";
	        	      if(expect4!=""){
	        	       betPeriod = parseInt(expect4)+1;
	        	      }else {
	        	      waring("获取期数错误");
	        	       return;
	        	     }
	       
	            	     for(var i=1;i<=10;i++){
	        	    	  $("#select"+i+id).children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+num+",";
			   			   });
	        	     }
	        	   
	           }
	           
	            betNum=betNum.substring(0, betNum.length-1);
	            //判断投注人是否为空
	            betPerson='${sessionScope.frontCurrentLoginUser.id}';
	            if(betPerson==""){
	            	waring("请先登录，再进行投注");
		        	return;	
	            }
	            //判断投注倍数是否为整数
	          betQuan= $("#quan"+id).val().trim();
	           var re = /^[1-9]+[0-9]*]*$/ ;
	           if(!re.test(betQuan)){
	        	     waring("投注倍数为整数");
	        	     return;betQuan==1;
	             }	  
	          var url= "${pageContext.request.contextPath}/addBetM.url"; 
	          $.ajax({
	  			url :url,
	  			type : "post",
	  			data:{
	  				"betPeriod":betPeriod,
	  				 "betNum":betNum,
	  				"betQuan":betQuan,
	  				"betType":betType,
	  				"betPerson":betPerson
	  				
	  			},
	  			success : function(result) {
	  			  var data=	$.parseJSON(result);
	  				waring(data);
                    expect="";
                    expect2="";
                    expect3="";
                    expect4="";
	  			},
	  			error: function (jqXHR, textStatus, errorThrown) {
	  				alert(textStatus);
	  			}

	  		});
 }
 
 //查看开奖信息
	function look(name) {
		$.ajax({
			url : "http://f.apiplus.cn/"+name+"-30.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#div"+name).find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1"+name).append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	
	
	function tabchange(name) {
		$("#"+name).addClass("active");
		$("#"+name).siblings("li").removeClass("active");
	    $("#div"+name).show();
		$("#div"+name).siblings("div").hide();  
			for(var i=1;i<=10;i++){
       	    	  $("#select"+i+name).children(".checked").each(function (index, domEle) { 
       	    	   $(domEle).removeClass("checked");
		   			   });
       	           }
	}
 

</script>
 

 <body>
 
 <div align="center"   id="main">
<ul  class="nav nav-pills" style="width:1086px;" >
<li    id="gd11x5" class="active"   onclick="tabchange('gd11x5');look('gd11x5');" ><a href="#"><span class="glyphicon glyphicon-th-large" ></span> 广东十一选五</a>  </li>  
<li   id="ssq"  onclick="tabchange('ssq');look('ssq');" ><a href="#"><span class="glyphicon glyphicon-th-large" ></span> 双色球   </a>  </li>
<li   id="dlt"  onclick="tabchange('dlt');look('dlt');" > <a href="#"><span class="glyphicon glyphicon-th-large" ></span>大乐透   </a>   </li>
<!--<li     onclick="tabchange('qxc');look('qxc');" > <a href="#"><span class="glyphicon glyphicon-th-large" ></span>七星彩   </a>   </li>-->
<li   id="cqssc"  onclick="tabchange('cqssc');look('cqssc');" > <a href="#"><span class="glyphicon glyphicon-th-large" ></span>重庆时时彩   </a>   </li>
<li   id="bjpk10"  onclick="tabchange('bjpk10');look('bjpk10');" > <a href="#"><span class="glyphicon glyphicon-th-large" ></span>北京pk10   </a>   </li>
</ul>



 <div   id="divgd11x5"  style="display:none;width:1086px;"  align="left">
 
 <div class="panel panel panel-info"  style="width: 50%;height:541px;float:right" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1gd11x5" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body"  >
  <div  class="well well-lg"  id='select1gd11x5'> <div style='margin-bottom: 5px;'>选号区:</div>
  <span onclick='check(this)' class="span_cicle">01</span>
  <span onclick='check(this)' class="span_cicle">02</span>
  <span onclick='check(this)' class="span_cicle">03</span>
  <span onclick='check(this)' class="span_cicle">04</span>
  <span onclick='check(this)' class="span_cicle">05</span>
  <span onclick='check(this)' class="span_cicle">06</span>
  <span onclick='check(this)' class="span_cicle">07</span>
  <span onclick='check(this)' class="span_cicle">08</span>
  <span onclick='check(this)' class="span_cicle">09</span>
  <span onclick='check(this)' class="span_cicle">10</span>
  <span onclick='check(this)' class="span_cicle">11</span>
  </div>
   <div  class="well well-lg" > <div style='margin-bottom: 5px;'>操作区:</div>
       投注倍数<input id='quangd11x5'></input>   
  <button type='button' class='btn btn-default' onclick='buy(1)'>购买</button>
  </div> 
  </div>
</div>

</div>


<div   id="divssq" style="display:none;width:1086px;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1ssq" >
 </div>
</div>

<div class="panel panel panel-info"style="width: 50%;; height: 541px">
<div class="panel-heading">购买</div>
<div class="panel-body">
<div class="well well-lg">
<div style='margin-bottom: 5px;'>选号区:</div>
<div class="well well-lg">
<div>前区:</div>
<div style="height: 60px" id='select1ssq'>
<span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  <span onclick='check(this)' class="span_cicle">11</span> 
  <span onclick='check(this)' class="span_cicle">12</span> 
  <span onclick='check(this)' class="span_cicle">13</span> 
  <span onclick='check(this)' class="span_cicle">14</span> 
  <span onclick='check(this)' class="span_cicle">15</span> 
  <span onclick='check(this)' class="span_cicle">16</span> 
  <span onclick='check(this)' class="span_cicle">17</span> 
  <span onclick='check(this)' class="span_cicle">18</span> 
  <span onclick='check(this)' class="span_cicle">19</span> 
  <span onclick='check(this)' class="span_cicle">20</span> 
  <span onclick='check(this)' class="span_cicle">21</span> 
  <span onclick='check(this)' class="span_cicle">22</span> 
  <span onclick='check(this)' class="span_cicle">23</span> 
  <span onclick='check(this)' class="span_cicle">24</span> 
  <span onclick='check(this)' class="span_cicle">25</span> 
  <span onclick='check(this)' class="span_cicle">26</span> 
  <span onclick='check(this)' class="span_cicle">27</span> 
  <span onclick='check(this)' class="span_cicle">28</span> 
  <span onclick='check(this)' class="span_cicle">29</span> 
  <span onclick='check(this)' class="span_cicle">30</span> 
  <span onclick='check(this)' class="span_cicle">31</span> 
  <span onclick='check(this)' class="span_cicle">32</span> 
  <span onclick='check(this)' class="span_cicle">33</span> 
</div>
</div>
<div class="well well-lg">
<div>后区:</div>
<div style="height: 40px" id='select2ssq'>
<span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  <span onclick='check(this)' class="span_cicle">11</span> 
  <span onclick='check(this)' class="span_cicle">12</span> 
  <span onclick='check(this)' class="span_cicle">13</span> 
  <span onclick='check(this)' class="span_cicle">14</span> 
  <span onclick='check(this)' class="span_cicle">15</span> 
  <span onclick='check(this)' class="span_cicle">16</span> 
</div>
</div>
</div>
<div class="well well-lg">
<div style='margin-bottom: 5px;'>操作区:</div>
投注倍数<input id='quanssq'></input>
<button type='button' class='btn btn-default' onclick='buy(2)'>购买</button>
</div>
</div>
</div>

</div>




<div   id="divdlt"  style="display:none;width: 1086px;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1dlt" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" > 
<div  class="well well-lg"  > <div style='margin-bottom: 5px;'>选号区:</div> 
  <div  class="well well-lg" ><div>前区:</div> 
  <div  style="height:60px" id='select1dlt'>
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  <span onclick='check(this)' class="span_cicle">11</span> 
  <span onclick='check(this)' class="span_cicle">12</span> 
  <span onclick='check(this)' class="span_cicle">13</span> 
  <span onclick='check(this)' class="span_cicle">14</span> 
  <span onclick='check(this)' class="span_cicle">15</span> 
  <span onclick='check(this)' class="span_cicle">16</span> 
  <span onclick='check(this)' class="span_cicle">17</span> 
  <span onclick='check(this)' class="span_cicle">18</span> 
  <span onclick='check(this)' class="span_cicle">19</span> 
  <span onclick='check(this)' class="span_cicle">20</span> 
  <span onclick='check(this)' class="span_cicle">21</span> 
  <span onclick='check(this)' class="span_cicle">22</span> 
  <span onclick='check(this)' class="span_cicle">23</span> 
  <span onclick='check(this)' class="span_cicle">24</span> 
  <span onclick='check(this)' class="span_cicle">25</span> 
  <span onclick='check(this)' class="span_cicle">26</span> 
  <span onclick='check(this)' class="span_cicle">27</span> 
  <span onclick='check(this)' class="span_cicle">28</span> 
  <span onclick='check(this)' class="span_cicle">29</span> 
  <span onclick='check(this)' class="span_cicle">30</span> 
  <span onclick='check(this)' class="span_cicle">31</span> 
  <span onclick='check(this)' class="span_cicle">32</span> 
  <span onclick='check(this)' class="span_cicle">33</span> 
  <span onclick='check(this)' class="span_cicle">34</span> 
  <span onclick='check(this)' class="span_cicle">35</span> 
   </div >
  </div >
  <div  class="well well-lg" ><div>后区:</div> 
  <div  style="height:40px" id='select2dlt'>
   <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  <span onclick='check(this)' class="span_cicle">11</span> 
  <span onclick='check(this)' class="span_cicle">12</span>
   </div > 
  </div>
  </div> 
  <div  class="well well-lg"> <div style='margin-bottom: 5px;'>操作区:</div> 
       投注倍数<input id='quandlt'></input>   
  <button type='button' class='btn btn-default' onclick='buy(3)'>购买</button>
  </div> 
 </div>
</div>
</div>


<div   id="divqxc"  style="display:none;width: 1086px;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1qxc" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" > 
<div  class="well well-lg" > <div style='margin-bottom: 5px;'>选号区:</div> 
 <div   style="height:200px" > 
  <div   id='select1qxc'  class="span_style" ><span  class="span_style">第一位:</span > 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
   <div   id='select2qxc' class="span_style" ><span class="span_style">第二位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select3qxc'  class="span_style"><span class="span_style">第三位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select4qxc' class="span_style"><span class="span_style">第四位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select5qxc' class="span_style" ><span class="span_style">第五位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select6qxc' class="span_style" ><span class="span_style">第六位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select7qxc'  class="span_style"><span  class="span_style">第七位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
  </div >
  </div> 
  <div  class="well well-lg"> <div style='margin-bottom: 5px;'>操作区:</div> 
       投注倍数<input id='quanqxc'></input>   
  <button type='button' class='btn btn-default' onclick='buy(4)'>购买</button>
  </div> 
 </div>
</div>
</div>


<div   id="divcqssc"  style="display:none;width: 1086px;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1cqssc" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" > 
<div  class="well well-lg" > <div style='margin-bottom: 5px;'>选号区:</div> 
 <div   style="height:200px" > 
  <div   id='select1cqssc'  class="span_style" ><span  class="span_style">第一位:</span > 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
   <div   id='select2cqssc' class="span_style" ><span class="span_style">第二位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select3cqssc'  class="span_style"><span class="span_style">第三位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select4cqssc' class="span_style"><span class="span_style">第四位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
 <div   id='select5cqssc' class="span_style" ><span class="span_style">第五位:</span> 
  <span onclick='check(this)' class="span_cicle">0</span> 
  <span onclick='check(this)' class="span_cicle">1</span> 
  <span onclick='check(this)' class="span_cicle">2</span> 
  <span onclick='check(this)' class="span_cicle">3</span> 
  <span onclick='check(this)' class="span_cicle">4</span> 
  <span onclick='check(this)' class="span_cicle">5</span> 
  <span onclick='check(this)' class="span_cicle">6</span> 
  <span onclick='check(this)' class="span_cicle">7</span> 
  <span onclick='check(this)' class="span_cicle">8</span> 
  <span onclick='check(this)' class="span_cicle">9</span> 
  </div >
  </div >
  </div> 
  <div  class="well well-lg"> <div style='margin-bottom: 5px;'>操作区:</div> 
       投注倍数<input id='quancqssc'></input>   
  <button type='button' class='btn btn-default' onclick='buy(5)'>购买</button>
  </div> 
 </div>
</div>
</div>

<div   id="divbjpk10"  style="display:none;width: 1086px;" align="left">
<div class="panel panel panel-info"  style="width: 60%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1bjpk10" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 40%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" > 
<div  class="well well-lg" > <div style='margin-bottom: 5px;'>选号区:</div> 
 <div   style="height:250px" > 
  <div   id='select1bjpk10'  class="span_style" ><span  class="span_style">第一位:</span > 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
   <div   id='select2bjpk10' class="span_style" ><span class="span_style">第二位:</span> 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select3bjpk10'  class="span_style"><span class="span_style">第三位:</span> 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select4bjpk10' class="span_style"><span class="span_style">第四位:</span> 
 <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select5bjpk10' class="span_style" ><span class="span_style">第五位:</span> 
 <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
    <div   id='select6bjpk10'  class="span_style" ><span  class="span_style">第六位:</span > 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
   <div   id='select7bjpk10' class="span_style" ><span class="span_style">第七位:</span> 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select8bjpk10'  class="span_style"><span class="span_style">第八位:</span> 
  <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select9bjpk10' class="span_style"><span class="span_style">第九位:</span> 
 <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
 <div   id='select10bjpk10' class="span_style" ><span class="span_style">第十位:</span> 
 <span onclick='check(this)' class="span_cicle">01</span> 
  <span onclick='check(this)' class="span_cicle">02</span> 
  <span onclick='check(this)' class="span_cicle">03</span> 
  <span onclick='check(this)' class="span_cicle">04</span> 
  <span onclick='check(this)' class="span_cicle">05</span> 
  <span onclick='check(this)' class="span_cicle">06</span> 
  <span onclick='check(this)' class="span_cicle">07</span> 
  <span onclick='check(this)' class="span_cicle">08</span> 
  <span onclick='check(this)' class="span_cicle">09</span> 
  <span onclick='check(this)' class="span_cicle">10</span> 
  </div >
  </div >
  </div> 
  <div  class="well well-lg"> <div style='margin-bottom: 5px;'>操作区:</div> 
       投注倍数<input id='quanbjpk10'></input>   
  <button type='button' class='btn btn-default' onclick='buy(6)'>购买</button>
  </div> 
 </div>
</div>
</div>

</div>


<form  style="display:none;" action="https://newpay.ips.com.cn/psfp-entry/gateway/payment.do" method="post" id="paymoney"> 
<input name="pGateWayReq" value="11"   id="pay"/> 
</form> 
</body>
</html>
