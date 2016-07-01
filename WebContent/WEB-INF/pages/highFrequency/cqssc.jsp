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
  label {
margin-right: 10px;	
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
 

  
	
//获取当前21选5期数	
 function getNowPeroid() {
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
        if(hour>=10){
         peroid = parseInt(24+(hour-10)*6+minute/10);
        }else if(hour>=22){
         peroid = parseInt(96+(hour-22)*12+minute/5);
        }else if(hour<2){
         peroid = parseInt((hour-0)*12+minute/5);
        }else if(hour>=2&&hour<10){
         peroid = parseInt(23);
        }
        if(peroid >= 0 && peroid <= 9){
    	 peroid = "00" + peroid;
       }else if(peroid >= 10 && peroid <= 99){
    	 peroid = "0" + peroid;
       }  
      
     var currentperoid = date.getFullYear()+ month+strDate+ peroid;
     return currentperoid;

 }  

   function timeLimate(){
      var date = new Date();
      var day = date.getDay();
      var hours = date.getHours(); 
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
	  var betChildType = $("[name=betChildType]:checked").val(); 
	  var  type=  betChildType.substring(0, 1); 
		var  num4=  betChildType.substring(1, 2);
    	      for(var i=1;i<=num4;i++){
 	    	 var num6=$("#select"+i+"cqssc").children(".checked").length;
 	    	   if(num6!="1"){
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
	        
	        	      if(timeLimate()==false){
	        		   waring("已过投注时间");
	        	     return;
	        	    }
	        	    if(checkLengh()==false){
	        	    	waring("每位选择一个号码");
	        	     return;
	        	    }
	        	    betType="重庆时时彩";
	        	   betPeriod =parseInt(getNowPeroid())+1;
	        	   var betChildType = $("[name=betChildType]:checked").val(); 
	        	   var  type=  betChildType.substring(0, 1); 
	       		    var  num4=  betChildType.substring(1, 2);
	        	     for(var i=num4;i>=1;i--){
	        	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
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
	          betQuan= $("#quancqssc").val().trim();
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
	  				"betChildType":betChildType
	  				
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
			url : "http://f.apiplus.cn/cqssc-06.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#divcqssc").find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1cqssc").append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	
	
	
	function timeCount() {
		 timeCountCqssc();		
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
	
	
	var inter1 ="";
	function timeCountCqssc() {	
		  var date = new Date();
		  var date1 = new Date();
	     var minute= date.getMinutes();
	     var  hour=date.getHours();
	     if(hour>=10){
	    	 date=getOpenTime(date,minute,10);
	        }else if(hour>=22){
	        date=getOpenTime(date,minute,5);
	        }else if(hour<2){
	        date=getOpenTime(date,minute,5);
	        }else if(hour>=2&&hour<10){
	         date.setHours(10,0,0,0);
	        }
	 	    var time=date.getTime()-date1.getTime();
	 	    setTimeout("clearTimeCount()",time); 	
	      if(timeLimate()==false){
	    	    $('#div2cqssc').text("本日已开奖完毕"); 
		  	    $('#div3cqssc').text("11选5每天投注时间为9-22时"); 
		  	    $('#div4cqssc').text("");   
	      }else{
	  	    var peroid=  parseInt(getNowPeroid())+1;
	  	    $('#div2cqssc').text("第"+peroid+"正在销售中"); 
	  	    $('#div3cqssc').text("截止销售时间："+date.Format("yyyy-MM-dd hh:mm:ss"));
	  		inter1=setInterval(function(){ShowCountDown(date);}, 1000);   
	      }
	      	   	
	}
	
	
	
	
	function clearTimeCount(){	
		clearInterval(inter1);
		timeCount();
		 look();
		}
	
	
	function ShowCountDown(endDate) { 	
	var leftTime=endDate.getTime()- new Date().getTime(); 
	var leftsecond = parseInt(leftTime/1000); 
	//var day1=parseInt(leftsecond/(24*60*60*6)); 
	var day1=Math.floor(leftsecond/(60*60*24)); 
	var hour=Math.floor((leftsecond-day1*24*60*60)/3600); 
	var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60); 
	var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60); 
	  $('#div4cqssc').text("距开奖时间还有："+day1+"天"+hour+"小时"+minute+"分"+second+"秒");  
	} 
	
	
	function show(type){	
		if(type==2){
			$("#select2cqssc").show();
			$("#select3cqssc").hide(); 
			$("#select4cqssc").hide(); 
			$("#select5cqssc").hide(); 
		}else if(type==3){
			$("#select2cqssc").show();
			$("#select3cqssc").show();
			$("#select4cqssc").hide(); 
			$("#select5cqssc").hide(); 
		}else if(type==5){
			$("#select2cqssc").show();
			$("#select3cqssc").show();
			$("#select4cqssc").show();
			$("#select5cqssc").show(); 
		}else{
			$("#select2cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select4cqssc").hide(); 
			$("#select5cqssc").hide(); 
		}
		}
	
	
</script>


<body style="background: #FFC">

	<div align="center" id="main" style="height: 100%; overflow: auto;">
         	<ul class="nav nav-pills" style="width: 1086px;">
			<li><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li><a href="dlt.url">大乐透</a></li>
			<li class="active"><a href="cqssc.url">重庆时时彩</a></li>
			<li><a href="bjpk.url">北京pk10</a></li>
		</ul>
		<div id="divcqssc" style="width: 1086px;" align="left">
			<div class="panel panel panel-info" style="width: 50%; float: right; height: 200px; background: #FFC">
				<div class="panel-heading">最近开奖信息</div>
				<div class="panel-body" id="div1cqssc"></div>
			</div>
			<div class="panel panel panel-info" style="width: 50%; float: right; height: 200px; background: #FFC">
				<div class="panel-heading" id="div2cqssc"></div>
				<div class="panel-body" id="div3cqssc"></div>
				<div class="panel-body" id="div4cqssc"></div>
			</div>

			<div class="panel panel panel-info" style="width: 100%; height: 700px; background: #FFC">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
				
					<div class="well well-lg" style="background: #FFC" >
					<div style='margin-bottom: 5px;'>投注类型:</div>
				    <label onclick="show(1)" ><input name="betChildType" type="radio" checked="checked"  value="x1" />一星 </label>
				    <label onclick="show(2)" ><input name="betChildType" type="radio" value="x2" />二星 </label>
				    <label onclick="show(3)" ><input name="betChildType" type="radio" value="x3" />三星</label>
				    <label onclick="show(5)" ><input name="betChildType" type="radio" value="x5" />五星 </label>
					</div>
					
					<div class="well well-lg" style="background: #FFC">
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div style="height: 130px">
							<div id='select1cqssc' class="span_style">
								<span class="span_style">个位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select2cqssc' class="span_style" style="display:none">
								<span class="span_style">十位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select3cqssc' class="span_style" style="display:none">
								<span class="span_style">百位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select4cqssc' class="span_style" style="display:none">
								<span class="span_style">千位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select5cqssc' class="span_style" style="display:none">
								<span class="span_style">万位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
						</div>
					</div>
					<div class="well well-lg" style="background: #FFC">
						<div style='margin-bottom: 5px;'>操作区:</div>
						投注倍数<input id='quancqssc'></input>
						<button type='button' class='btn btn-default' onclick='buy()'>购买</button>
					</div>
				</div>
			</div>
		</div>



	</div>

</body>
</html>
