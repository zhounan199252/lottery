<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<style type="text/css">
 .checked{
 font-size: 20px;
 color:red;
 }

</style>

 <script>

 function  getNowYearDay() {
	 var dateArr = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	 var date = new Date();
	 var day = date.getDate();
	 var month = date.getMonth(); //getMonth()是从0开始
	 var year = date.getFullYear();
	 var result = 0;
	 for (var i = 0; i < month; i++) {
	     result += dateArr[i];
	 }
	 result += day;
	 //判断是否闰年
	 if (month > 1 && (year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
	     result += 1;
	 }
	// alert("今天是" + year + "年的第" + result + "天");

	  
 }

 
 
 function getNowFormatDate() {
     var date = new Date();
     var month = date.getMonth() + 1;
     var strDate = date.getDate();
     if (month >= 1 && month <= 9) {
        month = "0" + month;
     }
     if (strDate >= 0 && strDate <= 9) {
         strDate = "0" + strDate;
     }

     var currentdate = date.getFullYear()+ month+strDate
           + parseInt((date.getHours()-9)*6+date.getMinutes()/10);
     return currentdate;

 }  

 
 function showBuy(name) {
	 $("#"+name).find("ul").remove();
	 $("#"+name).find("div").remove();
	 var div= "  <div> <div  id='select"+name+"'>选择号码 ";
	 
	 if(name=="gd11x5"){	 
			for (var i = 1; i < 12; i++) {
				div=div+"<span onclick='check(this)'>"+i+"</span>&emsp;&emsp;";
			}	
			div=div+"</div></br> <div >输入注数<input id='quan"+name+"'></input></div></br>  <div  onclick='buy(1)'>购买</div> </div> ";
	 }else if(name=="ssq"){
		       div=div+"红球:"; 
			for (var i = 1; i < 33; i++) {
				div=div+"<span onclick='check(this)'>"+i+"</span>&emsp;&emsp;";	
			}				
			div=div+"</br>蓝球:"; 
			for (var i = 1; i < 16; i++) {
				div=div+"<span onclick='check(this)'>"+i+"</span>&emsp;&emsp;";	
			}
		
			div=div+"</div></br> <div >输入注数<input id='quan"+name+"'></input></div></br>  <div  onclick='buy(2)'>购买</div> </div>" ;
			
	 }else if(name=="dlt"){
		    div=div+"红球:"; 
			for (var i = 1; i < 35; i++) {
				div=div+"<span onclick='check(this)'>"+i+"</span>&emsp;&emsp;";	
			}
			div=div+"</br>蓝球:"; 
			for (var i = 1; i < 12; i++) {
				div=div+"<span onclick='check(this)'>"+i+"</span>&emsp;&emsp;";	
			}
		
			div=div+"</div></br> <div >输入注数<input id='quan"+name+"'></input></div></br>  <div  onclick='buy(3)'>购买</div> </div> ";
	 }
		
			$("#"+name).append(div);
 }
 
 function check(node) {
	 if(!$(node).hasClass("checked")){
		 var num = $(node).parent("div").children(".checked").length;
		 if(num>100){
			 alert("已选择5个号码");
		 }else{
			 $(node).addClass("checked");
		 } 
	 }else{
	  $(node).removeClass("checked");
	 } 
	 
 }
 
 
 function buy(name) {
	           var  betPeriod="";
	           var betNum="";
	           var betType="";
	           var  id="";
	           if(name=="1"){
	        	   betType="广东11选5";
	        	   id="gd11x5";
	        	   betPeriod =parseInt(getNowFormatDate())+1;
	           }else if(name=="2"){
	        	   betType="双色球";
	        	   id="ssq";
	        	   betPeriod =parseInt(getNowFormatDate())+1;
	           }else if(name=="3"){
	        	   betType="大乐透";
	        	   id="dlt";
	        	   betPeriod =parseInt(getNowFormatDate())+1;
	           }
	           
	           $("#select"+id).children(".checked").each(function (index, domEle) { 
                 var num= $(domEle).text(); 
                   betNum =betNum+num+" ";
			   });
	           var betQuan= $("#quan"+id).val().trim(); 	  
	          var url= "http://localhost:8080/lottery/betmessage!addBetMessage.action"; 
	          $.ajax({
	  			url :url,
	  			type : "post",
	  			data:{
	  				"betPeriod":betPeriod,
	  				 "betNum":betNum,
	  				"betQuan":betQuan,
	  				"betType":betType
	  				
	  			},
	  			success : function(result) {
	                alert(result);
	  			},
	  			error: function (jqXHR, textStatus, errorThrown) {
	  				alert(textStatus);
	  			}

	  		});
 }
 
 //查看开奖信息
	function look(name) {
	 getNowYearDay();
		$.ajax({
			url : "http://f.apiplus.cn/"+name+".json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#"+name).find("div").remove();
					$("#"+name).find("ul").remove();
					var ul= "<ul>最新开奖结果 ";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime +",开奖时间毫秒值"+data[i].opentimestamp+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#"+name).append(ul);
				} 
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}

		});
	}
 

 </script>
 

 <body>
<ul class="rslides">
<li  id="gd11x5"> 广东十一选五  &emsp;&emsp;&emsp; <span  onclick="look('gd11x5')">查看最近开奖信息</span> &emsp;&emsp;&emsp;<span  onclick="showBuy('gd11x5')">下注</span> </li>  
<li  id="ssq"> 双色球        &emsp;&emsp;&emsp; <span  onclick="look('ssq')">查看最近开奖信息</span> &emsp;&emsp;&emsp;<span  onclick="showBuy('ssq')">下注</span> </li>
<li  id="dlt"> 大乐透  &emsp;&emsp;&emsp; <span  onclick="look('dlt')">查看最近开奖信息</span> &emsp;&emsp;&emsp;<span  onclick="showBuy('dlt')">下注</span> </li>
</ul>

</body>
</html>
