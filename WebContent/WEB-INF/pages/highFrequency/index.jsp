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
<script src="${pageContext.request.contextPath}/bootstrap-3.3.5/js/bootstrap.css"></script>
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
</style>

 <script>
 

 var expect2="";
  var expect="";
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
				  } 
				 }
				}
			});		
	}
	
	
//获取当前21选5期数	
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

     
     var peroid = parseInt((date.getHours()-9)*6+date.getMinutes()/10);
     if(peroid >= 1 && peroid <= 9){
    	 peroid = "0" + peroid;
     }
     var currentdate = date.getFullYear()+ month+strDate
           + peroid;
     return currentdate;

 }  

   function timeLimate(name){
      var date = new Date();
     var day = date.getDay();
     var hours = date.getHours();
     if(day==2||day==4||day==6){
       if(hours==21&&name=="ssq"){
         return  false; 
        }
       if(hours==20&&name=="dlt"){
         return  false; 
        }
        } 
        
       if((hours<9||hours>22)&&name=="gd11x5"){
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
        if(num!="5"){
			return false;
			}
       }else if(name=="ssq"){
       var num1 = $("#select"+name).children().eq(1).children(".checked").length;
       var num2 = $("#select"+name).children().eq(2).children(".checked").length;
        if(num1!="6"||num2!="1"){
			return false;
			}
       }else if(name=="dlt"){
       var num3 = $("#select"+name).children().eq(1).children(".checked").length;
       var num4 = $("#select"+name).children().eq(2).children(".checked").length;
        if(num3!="5"||num4!="2"){
			return false;
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
	        	    alert("已过投注时间");
	        	     return;
	        	    }
	        	    if(checkLengh(id)==false){
	        	     alert("只能选择5个号码");
	        	     return;
	        	    }
	        	    betType="广东11选5";
	        	   betPeriod =parseInt(getNowFormatDate())+1;
	        	   $("#select"+id).children(".checked").each(function (index, domEle) { 
	                   var num= $(domEle).text(); 
	                     betNum =betNum+num+",";
	  			   });
	           }else if(name=="2"){
	        	   id="ssq";
	        	   lookExpect(id);
	        	    if(timeLimate(id)==false){
	        	    alert("21-22点禁止下注");
	        	     return;
	        	    }
	        	   if(checkLengh(id)==false){
	        	     alert("只能选择6个红球。1个蓝球");
	        	     return;
	        	    }
	        	   betType="双色球";
	        	    if(expect!=""){
	        	    betPeriod =parseInt(expect)+1;
	        	   }else {
	        	    alert("获取期数错误");
	        	   return;
	        	   }
	        	    $("#select"+id).children().eq(1).children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
	        	    $("#select"+id).children().eq(2).children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+num+",";
	   			   });
	           }else if(name=="3"){
	        	      id="dlt";
	        	      lookExpect(id);
	                 if(timeLimate(id)==false){
	        	     alert("20-21点禁止下注");
	        	     return;
	        	     }
	        	     if(checkLengh(id)==false){
	        	     alert("只能选择5个红球。2个蓝球");
	        	     return;
	        	    }
	        	    if(expect2!=""){
	        	    betPeriod = parseInt(expect2)+1;
	        	     }else {
	        	     alert("获取期数错误");
	        	     return;
	        	    }
	        	     betType="大乐透";
	        	     
	        	     $("#select"+id).children().eq(1).children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+num+",";
		   			   });
		        	    betNum =betNum=betNum.substring(0, betNum.length-1)+"+";
		        	    $("#select"+id).children().eq(2).children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+num+",";
		   			   });
	           }
	           
	            betNum=betNum.substring(0, betNum.length-1);
	            //判断投注倍数是否为空
	            betPerson='${sessionScope.frontCurrentLoginUser.id}';
	            if(betPerson==""){
	            	alert("请先登录，再进行投注");
		        	return;	
	            }
	            //判断投注倍数是否为整数
	          betQuan= $("#quan"+id).val().trim();
	           var re = /^[1-9]+[0-9]*]*$/ ;
	           if(!re.test(betQuan)){
	                 alert("投注倍数为整数");
	        	     return;betQuan==1;
	             }	  
	          var url= "${pageContext.request.contextPath}/betmessage!addBetMessage.action"; 
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
	                alert(result);
	                expect2="";
                    expect="";
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
		if(name=="gd11x5"){
			$("#divgd11x5").show();
			$("#divssq").hide();
			$("#divdlt").hide();
	       }else if(name=="ssq"){
	    		$("#divssq").show();
				$("#divgd11x5").hide();
				$("#divdlt").hide();
	       }else if(name=="dlt"){
	    		$("#divdlt").show();
				$("#divssq").hide();
				$("#divgd11x5").hide();
	       }	
		
		
		
		
	}
 

</script>
 

 <body>
 
 <div align="center" >
<ul  class="nav nav-pills" style="width: 58%" >
<li  id="gd11x5" class="active"  style="font-size: 16px;" onclick="tabchange('gd11x5');look('gd11x5');" ><a href="#"><span class="glyphicon glyphicon-th-large" ></span> 广东十一选五</a>  </li>  
<li  id="ssq"   style="font-size: 16px;"  onclick="tabchange('ssq');look('ssq');" ><a href="#"><span class="glyphicon glyphicon-th-large" ></span> 双色球   </a>  </li>
<li  id="dlt"   style="font-size: 16px;" onclick="tabchange('dlt');look('dlt');" > <a href="#"><span class="glyphicon glyphicon-th-large" ></span>大乐透   </a>   </li>
</ul>



 <div   id="divgd11x5"  style="display:none;width: 58%;"  align="left">
 

 <div class="panel panel panel-info"  style="width: 50%;height:541px;float:right" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1gd11x5" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body"  >
  
  <fieldset  id='selectgd11x5'> <legend style='font-size: 16px;' >选号区:</legend>
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
  </fieldset>
   <fieldset> <legend style='font-size: 16px;'>操作区</legend>
       投注倍数<input id='quangd11x5'></input>   
  <button type='button' class='btn btn-default' onclick='buy(1)'>购买</button>
  </fieldset> 
  
  </div>
</div>

</div>


<div   id="divssq" style="display:none;width: 58%;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1ssq" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" >
  
<fieldset  id='selectssq'> <legend style='font-size: 16px;' >选号区:</legend>
  <fieldset ><legend style='font-size: 12px;'>前区:</legend>
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
  </fieldset >
  <fieldset ><legend style='font-size: 12px;'>后区:</legend>
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
  </fieldset>
  </fieldset> 
  <fieldset> <legend style='font-size: 16px;'>操作区</legend> 
  投注倍数<input id='quanssq'></input>   
  <button type='button' class='btn btn-default' onclick='buy(2)'>购买</button>
  </fieldset>
  
  </div>
</div>

</div>


<div   id="divdlt"  style="display:none;width: 58%;" align="left">
<div class="panel panel panel-info"  style="width: 50%;float:right;height:541px" >
  <div class="panel-heading">最近开奖信息</div>
  <div class="panel-body"  id="div1dlt" >
 </div>
</div>

 <div class="panel panel panel-info"  style="width: 50%;;height:541px" >
  <div class="panel-heading">购买</div>
  <div class="panel-body" >
  
<fieldset  id='selectdlt'> <legend style='font-size: 16px;' >选号区:</legend>
  <fieldset ><legend style='font-size: 12px;'>前区:</legend>
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
  </fieldset >
  <fieldset ><legend style='font-size: 12px;'>后区:</legend>
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
  </fieldset>
  </fieldset> 
  <fieldset> <legend style='font-size: 16px;'>操作区</legend> 
       投注倍数<input id='quandlt'></input>   
  <button type='button' class='btn btn-default' onclick='buy(3)'>购买</button>
  </fieldset>
  
 </div>
</div>

</div>

</div>
</body>
</html>
