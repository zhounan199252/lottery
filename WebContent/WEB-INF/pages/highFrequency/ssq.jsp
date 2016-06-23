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
	 look();
    timeCount();  
  
  
  
	 });
 
 //提示信息
 function waring(message) {
	var  waring='<div  style="position:absolute;left:30%;top:40%;" class="alert alert-info alert-dismissible" role="alert">'+
		 '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
		 '<strong>提示:</strong>'+message+'</div>';
	     $("#main").append(waring);
	  
 }
 
 
 

  var expect1="";
 //查看当前最新开奖期数
	function lookExpect() {
		$.ajax({
			url : "http://f.apiplus.cn/ssq-1.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
		    async:false,
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {   
			       expect1=  data[0].expect;	  
				 }
				}
			});		
	}
	

   function timeLimate(){
      var date = new Date();
      var day = date.getDay();
      var hours = date.getHours();
      if(day==2||day==4||day==6){
       if(hours==21){
         return  false; 
        }
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
  function checkLengh() {
       var num1 = $("#select1ssq").children(".checked").length;
       var num2 = $("#select2ssq").children(".checked").length;
        if(num1!="6"||num2!="1"){
			return false;
			}
   
	 return true;
 }
 
  
  

 
  //下注
 function buy() {
	           var  betPeriod="";
	           var betNum="";
	           var betType="";
	           var betQuan="";
	           var betPerson="";
			 
	        	   lookExpect();
	        	    if(timeLimate()==false){
	        	    	waring("21-22点禁止下注");
	        	     return;
	        	    }
	        	   if(checkLengh()==false){
	        		   waring("只能选择6个红球。1个蓝球");
	        	     return;
	        	    }
	        	   betType="双色球";
	        	    if(expect1!=""){
	        	    betPeriod =parseInt(expect1)+1;
	        	   }else {
	        		setTimeout("buy()",100); 
	        	   return;
	        	   }
	        	    $("#select1ssq").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
	        	    $("#select2ssq").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	         
	           
	            betNum=betNum.substring(0, betNum.length-1);
	            //判断投注人是否为空
	            betPerson='${sessionScope.frontCurrentLoginUser.id}';
	            if(betPerson==""){
	            	waring("请先登录，再进行投注");
		        	return;	
	            }
	            //判断投注倍数是否为整数
	          betQuan= $("#quanssq").val().trim();
	           var re = /^[1-9]+[0-9]*]*$/ ;
	           if(!re.test(betQuan)){
	        	     waring("投注倍数为整数");
	        	     return;
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
	  			},
	  			error: function (jqXHR, textStatus, errorThrown) {
	  				alert(textStatus);
	  			}

	  		});
 }
 
 //查看开奖信息
	function look() {
		$.ajax({
			url : "http://f.apiplus.cn/ssq-06.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#divssq").find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1ssq").append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	


		
	
	function timeCount() {
		  expect1="";
		 lookExpect();
		 timeCountSsq();
		
		
	}
	
	function timeCountSsq() { 
		  if(expect1!=""){
      	  var  betPeriod =parseInt(expect1)+1;
      	   $('#div2ssq').text("双色球第"+betPeriod+"正在销售中"); 
	  	    $('#div3ssq').text("截止销售时间：每周二、周四。周六的21-22禁止购买");
		  }else{
			  setTimeout("timeCountSsq()",1000); 
		  }
	      	   	
	}
	

	
	
		
	
</script>
 

 <body>

 <div align="center"   id="main" style="height: 100%; overflow: auto;" >

<div   id="divssq" style="width:1086px;" align="left">

<div class="panel panel panel-info"  style="width: 50%;float:right;height:200px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1ssq" >
 </div>
</div>
<div class="panel panel panel-info"  style="width: 50%;float:right;height:200px" >
  <div class="panel-heading" id="div2ssq"></div>
  <div class="panel-body"   id="div3ssq">
 </div>
</div>


<div class="panel panel panel-info"style="width: 100%;; height: 741px">
<div class="panel-heading">购买</div>
<div class="panel-body">
<div class="well well-lg">
<div style='margin-bottom: 5px;'>选号区:</div>
<div class="well well-lg">
<div>前区:</div>
<div style="height: 30px" id='select1ssq'>
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
<div style="height: 30px" id='select2ssq'>
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
<button type='button' class='btn btn-default' onclick='buy()'>购买</button>
</div>
</div>
</div>

</div>


</div>

</body>
</html>
