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
.checked {
	color: white;
	background-color: red;
}

.span_cicle {
	border-radius: 14px;
	border: 1px solid #000;
	margin-bottom: 5px;
}

.span_style {
	
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
 

 
  var expect2="";
 //查看当前最新开奖期数
	function lookExpect() {
		$.ajax({
			url : "http://f.apiplus.cn/dlt-1.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
		    async:false,
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {   
			       expect2=  data[0].expect;	
				 }
				}
			});		
	}
	
	


   function timeLimate(){
      var date = new Date();
      var day = date.getDay();
      var hours = date.getHours();
      if(day==1||day==3||day==6){
        if(hours==20){
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
       var num3 = $("#select1dlt").children(".checked").length;
       var num4 = $("#select2dlt").children(".checked").length;
        if(num3!="5"||num4!="2"){
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
	                waring("20-21点禁止下注");
	        	     return;
	        	     }
	        	     if(checkLengh()==false){
	        	     waring("只能选择前区5个,后区2个号码");
	        	     return;
	        	    }
	        	     betType="大乐透";
	        	    if(expect2!=""){
	        	    betPeriod = parseInt(expect2)+1;
	        	     }else {
	        	    setTimeout("buy()",100); 
	        	     return;
	        	    }
	        	    
	        	     
	        	     $("#select1dlt").children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+num+",";
		   			   });
		        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
		        	    $("#select2dlt").children(".checked").each(function (index, domEle) { 
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
	          betQuan= $("#quandlt").val().trim();
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
	  				"betPerson":betPerson,
	  				"betChildType": "dlt" 
	  				
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
			url : "http://f.apiplus.cn/dlt-06.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#divdlt").find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1dlt").append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	

		
	function timeCount() {
	      expect2=""; 
		 lookExpect();
		 timeCountDlt();
	
		
	}

	
	function timeCountDlt() { 
		  if(expect2!=""){
    	  var  betPeriod =parseInt(expect2)+1;
    	   $('#div2dlt').text("大乐透第"+betPeriod+"正在销售中"); 
	  	    $('#div3dlt').text("截止销售时间：每周一、周三、周六的20-21禁止购买");
		  }else{
			  setTimeout("timeCountDlt()",1000); 
		  }
	      	   	
	}
	
 
		
	
</script>


<body style="background: #FFC">

	<div align="center" id="main" style="height: 100%; background: #FFC">
         	<ul class="nav nav-pills" style="width: 1086px;">
			<li><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li class="active"><a href="dlt.url">大乐透</a></li>
			<li><a href="cqssc.url">重庆时时彩</a></li>
			<li><a href="ylsfc.url">永乐十分彩</a></li>
			<li><a href="bjpk.url">北京pk10</a></li>
		   </ul>

		<div id="divdlt" style="width: 1086px;" align="left">
			<div class="panel panel panel-info" style="width: 50%; float: right; height: 200px; background: #FFC">
				<div class="panel-heading">最近开奖信息</div>
				<div class="panel-body" id="div1dlt"></div>
			</div>
			<div class="panel panel panel-info" style="width: 50%; float: right; height: 200px; background: #FFC">
				<div class="panel-heading" id="div2dlt"></div>
				<div class="panel-body" id="div3dlt"></div>

			</div>

			<div class="panel panel panel-info" style="width: 100%; height: 741px; background: #FFC">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
					<div class="well well-lg" style="background: #FFC">
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div class="well well-lg" style="background: #FFC">
							<div>前区:</div>
							<div style="height: 30px" id='select1dlt'>
								<span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span> <span onclick='check(this)' class="span_cicle">11</span> <span onclick='check(this)' class="span_cicle">12</span> <span onclick='check(this)' class="span_cicle">13</span> <span onclick='check(this)' class="span_cicle">14</span> <span onclick='check(this)' class="span_cicle">15</span> <span onclick='check(this)' class="span_cicle">16</span> <span onclick='check(this)' class="span_cicle">17</span> <span
									onclick='check(this)' class="span_cicle">18</span> <span onclick='check(this)' class="span_cicle">19</span> <span onclick='check(this)' class="span_cicle">20</span> <span onclick='check(this)' class="span_cicle">21</span> <span onclick='check(this)' class="span_cicle">22</span> <span onclick='check(this)' class="span_cicle">23</span> <span onclick='check(this)' class="span_cicle">24</span> <span onclick='check(this)' class="span_cicle">25</span> <span onclick='check(this)' class="span_cicle">26</span> <span onclick='check(this)' class="span_cicle">27</span> <span onclick='check(this)' class="span_cicle">28</span> <span onclick='check(this)' class="span_cicle">29</span> <span onclick='check(this)' class="span_cicle">30</span> <span onclick='check(this)' class="span_cicle">31</span> <span onclick='check(this)' class="span_cicle">32</span> <span onclick='check(this)' class="span_cicle">33</span> <span onclick='check(this)' class="span_cicle">34</span> <span onclick='check(this)'
									class="span_cicle">35</span>
							</div>
						</div>
						<div class="well well-lg" style="background: #FFC">
							<div>后区:</div>
							<div style="height: 30px" id='select2dlt'>
								<span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span> <span onclick='check(this)' class="span_cicle">11</span> <span onclick='check(this)' class="span_cicle">12</span>
							</div>
						</div>
					</div>
					<div class="well well-lg" style="background: #FFC">
						<div style='margin-bottom: 5px;'>操作区:</div>
						投注倍数<input id='quandlt'></input>
						<button type='button' class='btn btn-default' onclick='buy()'>购买</button>
					</div>
				</div>
			</div>
		</div>


	</div>

</body>
</html>
