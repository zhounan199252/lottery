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
 
 
 //日期 字转符串转
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
 

  var expect1="";
  var expect2="";
  var expect3="";
 //查看当前最新开奖期数
	function lookExpect() {
		$.ajax({
			url : "http://f.apiplus.cn/bjpk10-1.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
		    async:false,
			success : function(result) {
				var data= result.data;
				if (data.length > 0) { 
					expect3=  data[0].expect;	
			      
				/*     var date1 = new Date();
				    var date2 = eval('new Date(' + data[0].opentime.replace(/\d+(?=-[^-]+$)/,
					         function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
                      if(date1.getTime()-date2.getTime()<300000){
                        expect3=  data[0].expect;	
				      }else if(date1.getTime()-date2.getTime()>9*60*60*1000+180000){
                        expect3=  data[0].expect;	
				      }else if(date1.getTime()-date2.getTime()>9*60*60*1000+600000){
                        expect3=  parseInt(data[0].expect)+1;	
				      }else{
				       expect3= parseInt(data[0].expect)+1;
				      }  */
		
				 }
				}
			});		
	}
	
	  

   function timeLimate(){
      var date = new Date();
      var hours = date.getHours();
       if((hours<9)){
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
    
    	      for(var i=1;i<=10;i++){
 	    	 var num7=$("#select"+i+"bjpk10").children(".checked").length;
 	    	   if(num7!="1"){
     			return false;
     			} 
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
	        		   waring("已过投注时间");
	        	       return;
	        	      }
	        	       if(checkLengh()==false){
	        	    	waring("请每位选择一个");
	        	        return;
	        	      }
	        	      betType="北京pk10";
	        	      if(expect3!=""){
	        	       betPeriod = parseInt(expect3)+3;
	        	      }else {
	        	      setTimeout("buy()",100); 
	        	       return;
	        	      }
	       
	            	     for(var i=1;i<=10;i++){
	        	    	  $("#select"+i+"bjpk10").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+num+",";
			   			   });
	        	     }
	        	   
	       
	           
	            betNum=betNum.substring(0, betNum.length-1);
	            //判断投注人是否为空
	            betPerson='${sessionScope.frontCurrentLoginUser.id}';
	            if(betPerson==""){
	            	waring("请先登录，再进行投注");
		        	return;	
	            }
	            //判断投注倍数是否为整数
	          betQuan= $("#quanbjpk10").val().trim();
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
			url : "http://f.apiplus.cn/bjpk10-06.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#divbjpk10").find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1bjpk10").append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	
		
	
	function timeCount() {
	     expect3="";
		 lookExpect();
		 timeCountBjpk10();
		
	}
	

	function getOpenTime(date,minute,interval){
		
		var newMinutes= (parseInt(minute/interval)+1)*interval;
			if(newMinutes==60){
				date.setMinutes(59,59,999); 
			}else{
				 date.setMinutes(newMinutes,0,0); 
			}
		
		return date;
	}
	
	

	function timeCountBjpk10() {
	    	  if(expect3!=""){
	    		    var date = new Date();
	    		    var date1 = new Date();
	    	        var minute= date.getMinutes();
	    	      
	    		   date=getOpenTime(date,minute,10);
	   	 	      var time=date.getTime()-date1.getTime();
	    		  setTimeout("clearTimeCount()",time); 	
	    		  
	    	      if(timeLimate()==false){
	    	    	    $('#div2bjpk10').text("本日已开奖完毕"); 
	    		  	    $('#div3bjpk10').text("北京pk10每天投注时间为9-24时"); 
	    		  	    $('#div4bjpk10').text("");   
	    	      }else{
	    	    	  var  betPeriod =parseInt(expect3)+3;
		  	  	      $('#div2bjpk10').text("第"+betPeriod+"正在销售中"); 
		  	  	      $('#div3bjpk10').text("销售在当前已开奖期数基础上延迟三期"); 
		  	  	    	  	  	     
	    	        }
	    		  }else{
	    			  setTimeout("timeCountBjpk10()",1000); 
	    		  } 
	    	  	      	   	
	}
	
	
	function clearTimeCount(){	
		 timeCount();
		 look();
		}
	
	
	/* function ShowCountDown(endDate) { 	
	var leftTime=endDate.getTime()- new Date().getTime(); 
	var leftsecond = parseInt(leftTime/1000); 
	//var day1=parseInt(leftsecond/(24*60*60*6)); 
	var day1=Math.floor(leftsecond/(60*60*24)); 
	var hour=Math.floor((leftsecond-day1*24*60*60)/3600); 
	var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60); 
	var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60); 
	  $('#div4bjpk10').text("距开奖时间还有："+day1+"天"+hour+"小时"+minute+"分"+second+"秒");  

	}  */
		
	
</script>


<body style="background: #FFC;">

	<div align="center" id="main" style="height: 100%; overflow: auto;">
       	<ul class="nav nav-pills" style="width: 1086px;">
			<li><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li><a href="dlt.url">大乐透</a></li>
			<li><a href="cqssc.url">重庆时时彩</a></li>
			<li class="active"><a href="bjpk.url">北京pk10</a></li>
		</ul>

		<div id="divbjpk10" style="width: 1086px;" align="left">
			<div class="panel panel panel-info" style="width: 60%; float: right; height: 200px; background: #FFC;">
				<div class="panel-heading">最近开奖信息</div>
				<div class="panel-body" id="div1bjpk10"></div>
			</div>
			<div class="panel panel panel-info" style="width: 40%; float: right; height: 200px; background: #FFC;">
				<div class="panel-heading" id="div2bjpk10"></div>
				<div class="panel-body" id="div3bjpk10"></div>
				<div class="panel-body" id="div4bjpk10"></div>

			</div>

			<div class="panel panel panel-info" style="width: 100%; height: 641px; background: #FFC;">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
					<div class="well well-lg" style="background: #FFC;">
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div style="height: 150px">
							<div id='select1bjpk10' class="span_style">
								<span class="span_style">第一位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select2bjpk10' class="span_style">
								<span class="span_style">第二位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select3bjpk10' class="span_style">
								<span class="span_style">第三位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select4bjpk10' class="span_style">
								<span class="span_style">第四位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select5bjpk10' class="span_style">
								<span class="span_style">第五位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select6bjpk10' class="span_style">
								<span class="span_style">第六位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select7bjpk10' class="span_style">
								<span class="span_style">第七位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select8bjpk10' class="span_style">
								<span class="span_style">第八位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select9bjpk10' class="span_style">
								<span class="span_style">第九位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<div id='select10bjpk10' class="span_style">
								<span class="span_style">第十位:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
						</div>
					</div>
					<div class="well well-lg" style="background: #FFC;">
						<div style='margin-bottom: 5px;'>操作区:</div>
						投注倍数<input id='quanbjpk10'></input>
						<button type='button' class='btn btn-default' onclick='buy()'>购买</button>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
