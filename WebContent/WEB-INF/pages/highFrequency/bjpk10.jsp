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
      if($(node).text()!="大"&&$(node).text()!="小"&&$(node).text()!="单"&&$(node).text()!="双"){
    	$("span[class!='span_cicle checked']:contains("+$(node).text()+")").hide();  
      }
 
	 }else{
	  $(node).removeClass("checked");
	   $("span[class!='span_cicle checked']:contains("+$(node).text()+")").show();
	 } 
	 
 }
 
 //判断选号是否正确
 function checkLengh() { 
	  var betChildType = $("[name=betChildType]:checked").val();  
		var  betNum="";
		if(betChildType=="pk10q2"){
			  for(var i=1;i<=2;i++){  
				  if($("#select"+i+"bjpk10").children(".checked").length!=1){
						return false; 
				  }
		    	  $("#select"+i+"bjpk10").children(".checked").each(function (index, domEle) { 
	                  var num= $(domEle).text(); 
	                    betNum =betNum+i+","+num+",";
	 			   });
		       }
			
			   if(betNum.length!=10){
 	     			return false;
 	     			} 
			
		}else if(betChildType=="pk10q3"){
			  for(var i=1;i<=3;i++){
				  if($("#select"+i+"bjpk10").children(".checked").length!=1){
						return false; 
				  }
		    	  $("#select"+i+"bjpk10").children(".checked").each(function (index, domEle) { 
	                  var num= $(domEle).text(); 
	                    betNum =betNum+i+","+num+",";
	 			   });
		       }
			  if(betNum.length!=15){
	     			return false;
	     			} 
			
		}else if(betChildType=="pk10dd"){
			    for(var i=1;i<=10;i++){
		    	  $("#select"+i+"bjpk10").children(".checked").each(function (index, domEle) { 
	                  var num= $(domEle).text(); 
	                    betNum =betNum+i+","+num+",";
	 			   });
		       }
		}else if(betChildType=="pk10dxd"){
			 betChildType = $("[name=betChildTypedxd]:checked").val(); 
			 var  i="";
			 if(betChildType.length==6){
				 i= betChildType.substring(2, 3); 
			 }else{
				 i= betChildType.substring(2, 4);
			 }
				  $("#select"+i+"dxd").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+i+","+num+",";
	   			   });	
				 
			 }
	   
	 return  betNum;
}

 
 
  //下注
 function buy() {
	           var  betPeriod="";
	           var betNum="";
	           var betType="";
	           var  betChildType="";
	           var betPerson="";
	           var betQuan="";   
	        	       if(timeLimate()==false){
		        		   waring("已过投注时间");
		        	       return;
		        	      }
	        	       lookExpect();
	        	       if(expect3!=""){
		        	       betPeriod =expect3;
		        	      }else {
		        	      setTimeout("buy()",100); 
		        	       return;
		        	      }
	        	    
	        	      betNum=checkLengh();
	        	      if(betNum==false){
		        	    	waring("号码选择错误，请重新选择");
		        	     return;
		        	    }
	        	      betNum=betNum.substring(0, betNum.length-1);
	        	      betType="北京pk10";  
	                  betChildType = $("[name=betChildType]:checked").val(); 
	                  if(betChildType=="pk10dxd"){
	                	  betChildType = $("[name=betChildTypedxd]:checked").val();   
	                  }
		        	    	
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
	  				"betPerson":betPerson, 
	  				"betChildType": betChildType  
	  				
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
	 

	 
	  var expect3="";
	 //查看当前在投注期数
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
					    var date1 = new Date();
					    var date2 = eval('new Date(' + data[0].opentime.replace(/\d+(?=-[^-]+$)/,
						         function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
						 date2.setSeconds(0,0);	
					    var differ=  Math.ceil((date1.getTime()-date2.getTime())/300000);  
	                      if(differ<108){
	                        expect3= parseInt(data[0].expect)+differ;	
					      }else  if(date1.getMinutes()>=7){
	                        expect3= parseInt(data[0].expect)+Math.ceil((date1.getMinutes()-1)/5);
					      }else{
	                        expect3= parseInt(data[0].expect)+1;	
					      }
					 }
					}
				});		
		}
		

	function getOpenTime(date,minute,interval){
	     var hour = date.getHours();
		if(hour==9&&minute<2){
			 date.setMinutes(7,0,0);	
		}else if(minute<2){
			 date.setMinutes(2,0,0);		
		}else if(hour==23&&minute>=57){
			date.setMinutes(59,59,59);
		}else if(minute>=57){
		    date.setHours(hour+1,2,0,0);	
		}else{
		var newMinutes= (parseInt((minute-2)/interval)+1)*interval+2;
		    date.setMinutes(newMinutes,0,0);	
		}
		return date;
	}
	
	
	var inter2 ="";
	function timeCountBjpk10() {
	    	  if(expect3!=""){
	    		    var date = new Date();
	    		    var date1 = new Date();
	    	        var minute= date.getMinutes();
	    	      
	    		   date=getOpenTime(date,minute,5);
	   	 	      var time=date.getTime()-date1.getTime();
	    		  setTimeout("clearTimeCount()",time); 	
	    		  
	    	      if(timeLimate()==false){
	    	    	    $('#div2bjpk10').text("本日已开奖完毕"); 
	    		  	    $('#div3bjpk10').text("北京pk10每天投注时间为9-24时"); 
	    		  	    $('#div4bjpk10').text("");   
	    	      }else{
	    	    	  var  betPeriod =expect3;
		  	  	      $('#div2bjpk10').text("第"+betPeriod+"正在销售中"); 
		  	  	      $('#div3bjpk10').text("截止销售时间："+date.Format("yyyy-MM-dd hh:mm:ss")); 
			  		inter2=setInterval(function(){ShowCountDown(date);}, 1000);  
		  	  	    	  	  	     
	    	        }
	    		  }else{
	    			  setTimeout("timeCountBjpk10()",1000); 
	    		  } 
	    	  	      	   	
	}
	
	
	function clearTimeCount(){	
		clearInterval(inter2);
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
	  $('#div4bjpk10').text("距开奖时间还有："+day1+"天"+hour+"小时"+minute+"分"+second+"秒");  

	} 
		
	function show(type){
		$("#select10dxd").hide();
		$("#select9dxd").hide();
		$("#select8dxd").hide(); 
		$("#select7dxd").hide();
		$("#select6dxd").hide();
		$("#select5dxd").hide();
		$("#select4dxd").hide();
		$("#select3dxd").hide(); 
		$("#select2dxd").hide();
		$("#select1dxd").hide();
	   if(type=='q2'){
			$("#select1bjpk10").show();
			$("#select2bjpk10").show();
			$("#select3bjpk10").hide(); 
			$("#select4bjpk10").hide();
			$("#select5bjpk10").hide();
			$("#select6bjpk10").hide();
			$("#select7bjpk10").hide(); 
			$("#select8bjpk10").hide();
			$("#select9bjpk10").hide();
			$("#select10bjpk10").hide();
			$("#select2bjpk10").prevAll("br").show(); 
		} else if(type=='q3'){
			$("#select1bjpk10").show();
			$("#select2bjpk10").show();
			$("#select3bjpk10").show(); 
			$("#select4bjpk10").hide();
			$("#select5bjpk10").hide();
			$("#select6bjpk10").hide();
			$("#select7bjpk10").hide(); 
			$("#select8bjpk10").hide();
			$("#select9bjpk10").hide();
			$("#select10bjpk10").hide();
			$("#select3bjpk10").prevAll("br").show(); 
		} else if(type=='all'){
			$("#select1bjpk10").show();
			$("#select2bjpk10").show();
			$("#select3bjpk10").show(); 
			$("#select4bjpk10").show();
			$("#select5bjpk10").show();
			$("#select6bjpk10").show();
			$("#select7bjpk10").show(); 
			$("#select8bjpk10").show();
			$("#select9bjpk10").show();
			$("#select10bjpk10").show();
			$("#select10bjpk10").prevAll("br").show(); 
		}else{
			    $("#select1bjpk10").hide();
				$("#select2bjpk10").hide();
				$("#select3bjpk10").hide(); 
				$("#select4bjpk10").hide();
				$("#select5bjpk10").hide();
				$("#select6bjpk10").hide();
				$("#select7bjpk10").hide(); 
				$("#select8bjpk10").hide();
				$("#select9bjpk10").hide();
				$("#select10bjpk10").hide();	
				
			
             	$("#select"+type+"dxd").show(); 
				$("#select"+type+"dxd").prevAll("br").hide(); 
				$("#select"+type+"dxd").nextAll("br").show(); 
		}
			
		}
	
	
	
	function detail(type){	
		$("#"+type).show();
		$("#"+type).siblings("div").hide();
		$("#text").show();
	    $("#select1bjpk10").hide();
		$("#select2bjpk10").hide();
		$("#select3bjpk10").hide(); 
		$("#select4bjpk10").hide();
		$("#select5bjpk10").hide();
		$("#select6bjpk10").hide();
		$("#select7bjpk10").hide(); 
		$("#select8bjpk10").hide();
		$("#select9bjpk10").hide();
		$("#select10bjpk10").hide();

	}
</script>


<body style="background: #FFC;">

	<div align="center" id="main" style="height: 100%; overflow: auto;">
       	<ul class="nav nav-pills" style="width: 1086px;">
			<li><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li><a href="dlt.url">大乐透</a></li>
			<li><a href="cqssc.url">重庆时时彩</a></li>
			<li><a href="ylsfc.url">永乐十分彩</a></li>
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

			<div class="panel panel panel-info" style="width: 100%; height: 850px; background: #FFC;">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
				
				<div class="well well-lg" style="background: #FFC" >
					<div  id="text" style='margin-bottom: 5px;'>投注类型:</div>
					<label  ><input onclick="detail('text');show('all');"  name="betChildType" type="radio" checked="checked"  value="pk10dd" />定位胆选 </label> 
					<label  ><input onclick="detail('text');show('q2');"   name="betChildType" type="radio"   value="pk10q2" />猜冠亚军 </label> 
					<label  ><input onclick="detail('text');show('q3');"  name="betChildType" type="radio"   value="pk10q3" />猜前三名 </label> 
					<label  ><input onclick="detail('dxd')"  name="betChildType" type="radio"   value="pk10dxd" />两面 </label> 
					
					
					<br>
				    <div id="dxd" style="display:none"><label onclick="show(1)" ><input name="betChildTypedxd" type="radio"  value="pk1dxd" />冠军</label>
					<label onclick="show(2)" ><input name="betChildTypedxd" type="radio" value="pk2dxd" />亚军 </label>
					<label onclick="show(3)" ><input name="betChildTypedxd" type="radio" value="pk3dxd" />季军</label>
					<label onclick="show(4)" ><input name="betChildTypedxd" type="radio" value="pk4dxd" />四名</label>
					<label onclick="show(5)" ><input name="betChildTypedxd" type="radio" value="pk5dxd" />五名</label>
					<label onclick="show(6)" ><input name="betChildTypedxd" type="radio" value="pk6dxd" />六名</label>
					<label onclick="show(7)" ><input name="betChildTypedxd" type="radio" value="pk7dxd" />七名</label>
					<label onclick="show(8)" ><input name="betChildTypedxd" type="radio" value="pk8dxd" />八名</label>
					<label onclick="show(9)" ><input name="betChildTypedxd" type="radio" value="pk9dxd" />九名</label>
					<label onclick="show(10)" ><input name="betChildTypedxd" type="radio" value="pk10dxd" />十名</label>
					</div>
					
			   </div>	
			       
					<div class="well well-lg" style="background: #FFC;">
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div style="height: 250px">
							<div id='select1bjpk10' class="span_style">
								<span class="span_style">冠&nbsp;&nbsp;&nbsp;&nbsp;军:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select2bjpk10' class="span_style">
								<span class="span_style">亚&nbsp;&nbsp;&nbsp;&nbsp;军:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select3bjpk10' class="span_style">
								<span class="span_style">季&nbsp;&nbsp;&nbsp;&nbsp;军:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select4bjpk10' class="span_style">
								<span class="span_style">第四名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select5bjpk10' class="span_style">
								<span class="span_style">第五名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select6bjpk10' class="span_style">
								<span class="span_style">第六名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select7bjpk10' class="span_style">
								<span class="span_style">第七名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select8bjpk10' class="span_style">
								<span class="span_style">第八名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select9bjpk10' class="span_style">
								<span class="span_style">第九名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							<br>
							<div id='select10bjpk10' class="span_style">
								<span class="span_style">第十名:</span> <span onclick='check(this)' class="span_cicle">01</span> <span onclick='check(this)' class="span_cicle">02</span> <span onclick='check(this)' class="span_cicle">03</span> <span onclick='check(this)' class="span_cicle">04</span> <span onclick='check(this)' class="span_cicle">05</span> <span onclick='check(this)' class="span_cicle">06</span> <span onclick='check(this)' class="span_cicle">07</span> <span onclick='check(this)' class="span_cicle">08</span> <span onclick='check(this)' class="span_cicle">09</span> <span onclick='check(this)' class="span_cicle">10</span>
							</div>
							
							<br>
								<div id='select1dxd'  style="display:none" class="span_style" >
								<span  class="span_style">冠军:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select2dxd'  style="display:none" class="span_style" >
								<span  class="span_style">亚军:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select3dxd'  style="display:none" class="span_style" >
								<span  class="span_style">季军:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select4dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第四名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select5dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第五名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
								<div id='select6dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第六名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select7dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第七名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select8dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第八名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select9dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第九名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select10dxd'  style="display:none" class="span_style" >
								<span  class="span_style">第十名:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
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
