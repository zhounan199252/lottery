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
       peroid = parseInt((hour-9)*6+minute/10);
       if(peroid >= 0 && peroid <= 9){
    	 peroid = "0" + peroid;
       }  
     var currentperoid = date.getFullYear()+ month+strDate+ peroid;
     return currentperoid;

 }  

   function timeLimate(){
      var date = new Date();
      var hours = date.getHours();
      if((hours<9||hours>22)){
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
  function checkLengh() {  
		var betChildType = $("[name=betChildType]:checked").val(); 
	     var num1 = $("#select1gd11x5").children(".checked").length;
		var  type=  betChildType.substring(0, 1); 
		var  num4=  betChildType.substring(1, 2); 
		if(type=="r"){
			  if(num1!=num4){
					return false;
					}  	
		}else{
					
			 for(var i=1;i<=num4;i++){
	 	    	 var num=$("#select"+i+"gd11x5").children(".checked").length;
	 	    	   if(num!="1"){
	     			return false;
	     			} 
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
	           var betChildType="";
	         
	        	   if(timeLimate()==false){
	        		   waring("已过投注时间");
	        	     return;
	        	    }
	        	  
	        	    if(checkLengh()==false){
	        	    	waring("号码选择错误，请重新选择");
	        	     return;
	        	    }
	        	    betType="广东11选5";
	        	   betPeriod =parseInt(getNowPeroid())+1;
	        	   
	        	   betChildType = $("[name=betChildType]:checked").val();
	        	   $("#select1gd11x5").children(".checked").each(function (index, domEle) { 
	                   var num= $(domEle).text(); 
	                     betNum =betNum+num+",";
	  			   });
	        	   
	        	   if(betChildType=="q2"){
	        		   $("#select2gd11x5").children(".checked").each(function (index, domEle) { 
		                   var num= $(domEle).text(); 
		                     betNum =betNum+num+",";
		  			   }); 
	        	   }else if(betChildType=="q3"){
	        		   $("#select2gd11x5").children(".checked").each(function (index, domEle) { 
		                   var num= $(domEle).text(); 
		                     betNum =betNum+num+",";
		  			   }); 
	        		   $("#select3gd11x5").children(".checked").each(function (index, domEle) { 
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
	          betQuan= $("#quangd11x5").val().trim();
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
			url : "http://f.apiplus.cn/gd11x5-06.json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#divgd11x5").find("ul").remove();
					var ul= "<ul>";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#div1gd11x5").append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
	
	
	
	function timeCount() {	
		timeCountGd11x5();	
		 look();
	}
	
	
	var inter ="";
	function timeCountGd11x5() {	
		  var date = new Date();
		  var date1 = new Date();
	     var minute= date.getMinutes();
	        date=getOpenTime(date,minute,10);
	 	    var time=date.getTime()-date1.getTime();
	 	    setTimeout("clearTimeCount()",time); 	
	      if(timeLimate()==false){
	    	    $('#div2gd11x5').text("本日已开奖完毕"); 
		  	    $('#div3gd11x5').text("11选5每天投注时间为9-22时"); 
		  	    $('#div4gd11x5').text("");   
	      }else{
	  	    var peroid=  parseInt(getNowPeroid())+1;
	  	    $('#div2gd11x5').text("第"+peroid+"正在销售中"); 
	  	    $('#div3gd11x5').text("截止销售时间："+date.Format("yyyy-MM-dd hh:mm:ss"));
	  		inter=setInterval(function(){ShowCountDown(date);}, 1000);   
	      }
	      	   	
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
	

	
	
	function clearTimeCount(){	
		clearInterval(inter);
		timeCount();	
		}
	
	
	function ShowCountDown(endDate) { 	
	var leftTime=endDate.getTime()- new Date().getTime(); 
	var leftsecond = parseInt(leftTime/1000); 
	//var day1=parseInt(leftsecond/(24*60*60*6)); 
	var day1=Math.floor(leftsecond/(60*60*24)); 
	var hour=Math.floor((leftsecond-day1*24*60*60)/3600); 
	var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60); 
	var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60); 
     $('#div4gd11x5').text("距开奖时间还有："+day1+"天"+hour+"小时"+minute+"分"+second+"秒");   	

	} 
		
	
	function show(type){	
		if(type==2){
			$("#select2gd11x5").show();
			$("#select3gd11x5").hide(); 
		}else if(type==3){
			$("#select2gd11x5").show();
			$("#select3gd11x5").show();		
		}else{
			$("#select2gd11x5").hide(); 
			$("#select3gd11x5").hide(); 
		}
		}
	
	
</script>


<body style="background: #FFC">
	<div align="center" id="main" style="height: 100%; overflow: auto;">
        	<ul class="nav nav-pills" style="width: 1086px;">
			<li class="active"><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li><a href="dlt.url">大乐透</a></li>
			<li><a href="cqssc.url">重庆时时彩</a></li>
			<li><a href="bjpk.url">北京pk10</a></li>
		</ul>
		<div id="divgd11x5" style="width: 1086px" align="left">

			<div class="panel panel panel-info" style="width: 50%; height: 200px; float: right; background: #FFC">
				<div class="panel-heading">最近开奖信息</div>
				<div class="panel-body" id="div1gd11x5"></div>
			</div>

			<div class="panel panel panel-info" style="width: 50%; float: right; height: 200px; background: #FFC">
				<div class="panel-heading" id="div2gd11x5"></div>
				<div class="panel-body" id="div3gd11x5"></div>
				<div class="panel-body" id="div4gd11x5"></div>
			</div>

			<div class="panel panel panel-info" style="width: 100%; height: 780px; background: #FFC">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
				
				<div class="well well-lg" style="background: #FFC" >
					<div style='margin-bottom: 5px;'>投注类型:</div>
					<label onclick="show(0)" ><input name="betChildType" type="radio" checked="checked"  value="r2" />任选二 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r3" />任选三 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r4" />任选四 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r5" />任选五</label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r6" />任选六 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r7" />任选七 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="r8" />任选八 </label>
				    <label onclick="show(0)" ><input name="betChildType" type="radio" value="q1" />前一</label>
				    <label onclick="show(2)" ><input name="betChildType" type="radio" value="q2" />前二 </label>
				    <label onclick="show(3)" ><input name="betChildType" type="radio" value="q3" />前三</label>	
					</div>
					<div class="well well-lg" style="background: #FFC" >
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div style="height: 100px">
						<div id='select1gd11x5' class="span_style">
					    <span class="span_style">第一位:</span>  <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span> <span onclick='check(this)' class="span_cicle">11</span>
						</div>
						<div id='select2gd11x5' class="span_style" style="display:none">
					    <span class="span_style">第二位:</span>  <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span> <span onclick='check(this)' class="span_cicle">11</span>
						</div>
						<div id='select3gd11x5' class="span_style" style="display:none">
					    <span class="span_style">第三位:</span>  <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span> <span onclick='check(this)' class="span_cicle">11</span>
						</div>
						</div>
	                   </div>
					<div class="well well-lg" style="background: #FFC">
						<div style='margin-bottom: 5px;'>操作区:</div>
						投注倍数<input id='quangd11x5'></input>
						<button type='button' class='btn btn-default' onclick='buy()'>购买</button>
					</div>
				</div>
			</div>

		</div>


	</div>


           
</body>
</html>
