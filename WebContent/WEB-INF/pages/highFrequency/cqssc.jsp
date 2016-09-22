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
	  var check=$("[name=betChildTypeR]:checked");
		var  betNum="";
		if(betChildType=="x5"){
			 for(var i=1;i<=5;i++){
				  if( $("#select"+i+"cqssc").children(".checked").length!=1){
						return false; 
				  }
	  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+i+","+num+",";
		   			   });
	  	           }
				 
				  if(betNum.length!=20){
		     			return false;
		     			} 
			  			  
		}else if(betChildType=="dd"){
			
			 for(var i=1;i<=5;i++){
  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+i+","+num+",";
	   			   });
  	           }

		}else if(betChildType=="x4"){
		 betChildType = $("[name=betChildTypex4]:checked").val(); 
		 if( betChildType=="x4q4"){
			 for(var i=1;i<=4;i++){
				  if( $("#select"+i+"cqssc").children(".checked").length!=1){
						return false; 
				  }
	  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+i+","+num+",";
		   			   });
	  	           }
				 
				  if(betNum.length!=16){
		     			return false;
		     			} 
		 }else if( betChildType=="x4h4"){
			 for(var i=2;i<=5;i++){
				  if( $("#select"+i+"cqssc").children(".checked").length!=1){
						return false; 
				  }
	  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+i+","+num+",";
		   			   });
	  	           }
				 
				  if(betNum.length!=16){
		     			return false;
		     			} 
			 
		 }else if( betChildType=="x4r4"){
			 for(var i=1;i<=5;i++){
				  if( $("#select"+i+"cqssc").children(".checked").length>1){
						return false; 
				  }
	  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
		                    var num= $(domEle).text(); 
		                      betNum =betNum+i+","+num+",";
		   			   });
	  	           }
				 
				  if(betNum.length!=16){
		     			return false;
		     			} 
			 
		 }
		 		
		}else if(betChildType=="x3"){
			 betChildType = $("[name=betChildTypex3]:checked").val(); 
			 
			 if( betChildType=="x3q3"){
				 for(var i=1;i<=3;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=12){
			     			return false;
			     			} 
			 }else if( betChildType=="x3z3"){
				 for(var i=2;i<=4;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=12){
			     			return false;
			     			} 
				 
			 }else if( betChildType=="x3h3"){
				 for(var i=3;i<=5;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=12){
			     			return false;
			     			} 
				 
			 }else if( betChildType=="x3r3"){
				 for(var i=1;i<=5;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length>1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=12){
			     			return false;
			     			} 
				 
			 }
		
		}else if(betChildType=="z3"){
			
			 betChildType = $("[name=betChildTypez3]:checked").val(); 
			 $("#select5cqssc").children(".checked").each(function (index, domEle) { 
                 var num= $(domEle).text(); 
                   betNum =betNum+num+",";
			   });  	  
			 if(betChildType=="q3z3"||betChildType=="z3z3"||betChildType=="h3z3"||betChildType=="r3z3"){
				  if(betNum.length!=4){
						return false;
						}  
			 }else{
				  if(betNum.length!=6){
						return false;
						}  
			 }
			 
			 if(betChildType=="r3z3"||betChildType=="r3z6"){
				 if(check.length!=3){
					 return false; 
				 } 
				 var  checkval="";
				  for(var i=0;i<check.length;i++){
					  checkval=checkval+check[i].value+","
				  }
				 betNum= checkval+betNum;
			 }
		
		}else if(betChildType=="x2"){
			 betChildType = $("[name=betChildTypex2]:checked").val(); 
			 if( betChildType=="x2q2"){
				 for(var i=1;i<=2;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
			 }else if( betChildType=="x2h2"){
				 
				 for(var i=4;i<=5;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
				 
			 }else if( betChildType=="x2r2"){
				 for(var i=1;i<=5;i++){
					  if( $("#select"+i+"cqssc").children(".checked").length>1){
							return false; 
					  }
		  	    	  $("#select"+i+"cqssc").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
				 
			 }
		
		}else if(betChildType=="z2"){
			 betChildType = $("[name=betChildTypez2]:checked").val(); 
			 $("#select5cqssc").children(".checked").each(function (index, domEle) { 
                 var num= $(domEle).text(); 
                   betNum =betNum+num+",";
			   });
			  if(betNum.length!=4){
					return false;
					} 
			  if(betChildType=="r2z2"){
					 if(check.length!=2){
						 return false; 
					 } 
					 var  checkval="";
					  for(var i=0;i<check.length;i++){
						  checkval=checkval+check[i].value+","
					  }
					 betNum= checkval+betNum;
				 }
		
		}else if(betChildType=="bdd"){
			 betChildType = $("[name=betChildTypebdd]:checked").val(); 
			 
			 $("#select5cqssc").children(".checked").each(function (index, domEle) { 
                 var num= $(domEle).text(); 
                   betNum =betNum+num+",";
			   });
			 
			 if(betChildType=="q3bdd"||betChildType=="z3bdd"||betChildType=="h3bdd"||betChildType=="r3bdd"){
				  if(betNum.length!=2){
						return false;
						}  
			 }else{
				  if(betNum.length!=4){
						return false;
						}  
			 }
			 
			 if(betChildType=="r3bdd"){
				 if(check.length!=3){
					 return false; 
				 } 
				 var  checkval="";
				  for(var i=0;i<check.length;i++){
					  checkval=checkval+check[i].value+","
				  }
				 betNum= checkval+betNum;
			 }
			 
		}else if(betChildType=="dxd"){
			 betChildType = $("[name=betChildTypedxd]:checked").val(); 
			 if( betChildType=="q2dxd"){
				 for(var i=1;i<=2;i++){
					 if( $("#select"+i+"dxd").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"dxd").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
			 }else if( betChildType=="h2dxd"){
				 for(var i=4;i<=5;i++){
					 if( $("#select"+i+"dxd").children(".checked").length!=1){
							return false; 
					  }
		  	    	  $("#select"+i+"dxd").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
				 
			 }else if( betChildType=="r2dxd"){
				 for(var i=1;i<=5;i++){
					 if( $("#select"+i+"dxd").children(".checked").length>1){
							return false; 
					  }
		  	    	  $("#select"+i+"dxd").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+i+","+num+",";
			   			   });
		  	           }
					 
					  if(betNum.length!=8){
			     			return false;
			     			} 
				 
			 }else if( betChildType=="wwdxd"){
		  	    	  $("#select1dxd").children(".checked").each(function (index, domEle) { 
			                    var num= $(domEle).text(); 
			                      betNum =betNum+1+","+num+",";
			   			   });		 
			 }else if( betChildType=="qwdxd"){
	  	    	  $("#select2dxd").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+2+","+num+",";
	   			   });		 
	         }else if( betChildType=="bwdxd"){
	  	    	  $("#select3dxd").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+3+","+num+",";
	   			   });		 
	         } else if( betChildType=="swdxd"){
	  	    	  $("#select4dxd").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+4+","+num+",";
	   			   });		 
	         } else if( betChildType=="gwdxd"){
	  	    	  $("#select5dxd").children(".checked").each(function (index, domEle) { 
	                    var num= $(domEle).text(); 
	                      betNum =betNum+5+","+num+",";
	   			   });		 
	         }  
		
		}
		
	 return betNum;
 }
 
  
  

 
  //下注
 function buy() {
	         
	           var betNum="";
	           var  betPeriod="";
	           var betType="";
	           var betChildType="";
	           var betQuan="";
	           var betPerson="";
	        
	        	      if(timeLimate()==false){
	        		   waring("已过投注时间");
	        	     return;
	        	    }
	        	    
	        	      betNum=checkLengh();
	        	    if(betNum==false){
	        	    	waring("号码选择错误，请重新选择");
	        	     return;
	        	    }
	        	    betNum=betNum.substring(0, betNum.length-1);
	        	     betPeriod =parseInt(getNowPeroid())+1;     	    
	        	     betType="重庆时时彩"; 
	        	     betChildType = $("[name=betChildType]:checked").val(); 
	        	     if(betChildType=="x4"){
	        	    	 betChildType = $("[name=betChildTypex4]:checked").val(); 
	        	     }else if(betChildType=="x3"){
	        	    	 betChildType = $("[name=betChildTypex3]:checked").val(); 
	        	     }else if(betChildType=="z3"){
	        	    	 betChildType = $("[name=betChildTypez3]:checked").val();  
	        	     }else if(betChildType=="x2"){
	        	    	 betChildType = $("[name=betChildTypex2]:checked").val();  
	        	     }else if(betChildType=="z2"){
	        	    	 betChildType = $("[name=betChildTypez2]:checked").val();  
	        	     }else if(betChildType=="bdd"){
	        	    	 betChildType = $("[name=betChildTypebdd]:checked").val();  
	        	     }else if(betChildType=="dxd"){
	        			 betChildType = $("[name=betChildTypedxd]:checked").val(); 
	        				}
	        			
	        			 
	       		   	            
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
		$("#checkbox").hide(); 
		$("#select5dxd").hide();
		$("#select4dxd").hide();
		$("#select3dxd").hide(); 
		$("#select2dxd").hide();
		$("#select1dxd").hide();
	   if(type==5){
			$("#select5cqsscspan").show();
			$("#select5cqssc").show();
			$("#select4cqssc").show();
			$("#select3cqssc").show();
			$("#select2cqssc").show();
			$("#select1cqssc").show(); 
			$("#select1cqssc").nextAll("br").show(); 
		}else if(type=='q4'){
			$("#select5cqssc").hide();
			$("#select4cqssc").show();
			$("#select3cqssc").show();
			$("#select2cqssc").show();
			$("#select1cqssc").show(); 
			$("#select1cqssc").nextAll("br").show(); 
		} else if(type=='h4'){
			$("#select5cqsscspan").show();
			$("#select5cqssc").show();
			$("#select4cqssc").show();
			$("#select3cqssc").show();
			$("#select2cqssc").show();
			$("#select1cqssc").hide(); 
			$("#select2cqssc").prevAll("br").hide(); 
			$("#select2cqssc").nextAll("br").show(); 
		} else if(type=='q3'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").show();
			$("#select2cqssc").show();
			$("#select1cqssc").show(); 
			$("#select1cqssc").nextAll("br").show(); 
		} else if(type=='z3'){
			$("#select5cqssc").hide();
			$("#select4cqssc").show();
			$("#select3cqssc").show();
			$("#select2cqssc").show();
			$("#select1cqssc").hide(); 
			$("#select2cqssc").prevAll("br").hide(); 
			$("#select2cqssc").nextAll("br").show(); 
		} else if(type=='h3'){
			$("#select5cqsscspan").show();
			$("#select5cqssc").show();
			$("#select4cqssc").show();
			$("#select3cqssc").show();
			$("#select2cqssc").hide();
			$("#select1cqssc").hide();
			$("#select3cqssc").prevAll("br").hide(); 
			$("#select3cqssc").nextAll("br").show(); 
		} else if(type=='q2'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide();
			$("#select2cqssc").show();
			$("#select1cqssc").show(); 
			$("#select1cqssc").nextAll("br").show(); 
		} else if(type=='h2'){
			$("#select5cqsscspan").show();
			$("#select5cqssc").show();
			$("#select4cqssc").show();
			$("#select3cqssc").hide();
			$("#select2cqssc").hide();
			$("#select1cqssc").hide(); 
			$("#select4cqssc").prevAll("br").hide(); 
			$("#select4cqssc").nextAll("br").show(); 
		} else if(type=='q2dxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").hide();
			$("#select4dxd").hide();
			$("#select3dxd").hide(); 
			$("#select2dxd").show();
			$("#select1dxd").show(); 	
			$("#select1dxd").prevAll("br").hide(); 
			$("#select1dxd").nextAll("br").show(); 
		}else if(type=='h2dxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").show();
			$("#select4dxd").show();
			$("#select3dxd").hide(); 
			$("#select2dxd").hide();
			$("#select1dxd").hide();
			$("#select4dxd").prevAll("br").hide(); 
			$("#select4dxd").nextAll("br").show(); 
			
		} else if(type=='r2dxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").show();
			$("#select4dxd").show();
			$("#select3dxd").show(); 
			$("#select2dxd").show();
			$("#select1dxd").show(); 	
			$("#select1dxd").prevAll("br").hide(); 
			$("#select1dxd").nextAll("br").show(); 
			
		}  else if(type=='wwdxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").hide();
			$("#select4dxd").hide();
			$("#select3dxd").hide();
			$("#select2dxd").hide();
			$("#select1dxd").show(); 	
			$("#select1dxd").prevAll("br").hide(); 
			$("#select1dxd").nextAll("br").show(); 
			
		}else if(type=='qwdxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").hide();
			$("#select4dxd").hide();
			$("#select3dxd").hide(); 
			$("#select2dxd").show();
			$("#select1dxd").hide(); 	
			$("#select2dxd").prevAll("br").hide(); 
			$("#select2dxd").nextAll("br").show(); 
			
		}else if(type=='bwdxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").hide();
			$("#select4dxd").hide();
			$("#select3dxd").show(); 
			$("#select2dxd").hide();
			$("#select1dxd").hide();	
			$("#select3dxd").prevAll("br").hide(); 
			$("#select3dxd").nextAll("br").show(); 
			
		}else if(type=='swdxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").hide();
			$("#select4dxd").show();
			$("#select3dxd").hide();
			$("#select2dxd").hide();
			$("#select1dxd").hide(); 	
			$("#select4dxd").prevAll("br").hide(); 
			$("#select4dxd").nextAll("br").show(); 
			
		}else if(type=='gwdxd'){
			$("#select5cqssc").hide();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5dxd").show();
			$("#select4dxd").hide();
			$("#select3dxd").hide();
			$("#select2dxd").hide();
			$("#select1dxd").hide(); 	
			$("#select5dxd").prevAll("br").hide(); 
			$("#select5dxd").nextAll("br").show(); 
			
		}else if(type==0){
			$("#select5cqsscspan").hide();
			$("#select5cqssc").show();
			$("#select4cqssc").hide();
			$("#select3cqssc").hide(); 
			$("#select2cqssc").hide(); 
			$("#select1cqssc").hide(); 
			$("#select5cqssc").prevAll("br").hide(); 
			$("#select5cqssc").nextAll("br").show(); 
		} 
		}
	
	function checkbox(){
		$("#checkbox").show(); 
	}
	
	function detail(type){	
		$("#"+type).show();
		$("#"+type).siblings("div").hide();
		$("#text").show();
		$("#select5cqssc").hide();
		$("#select4cqssc").hide();
		$("#select3cqssc").hide(); 
		$("#select2cqssc").hide(); 
		$("#select1cqssc").hide(); 
		$("#checkbox").hide(); 
	}
</script>


<body style="background: #FFC">

	<div align="center" id="main" style="height: 100%; overflow: auto;">
         	<ul class="nav nav-pills" style="width: 1086px;">
			<li><a href="gdx.url">广东11选5</a></li>
			<li><a href="ssq.url">双色球</a></li>
			<li><a href="dlt.url">大乐透</a></li>
			<li class="active"><a href="cqssc.url">重庆时时彩</a></li>
			<li><a href="ylsfc.url">永乐十分彩</a></li>
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

			<div class="panel panel panel-info" style="width: 100%; height: 800px; background: #FFC">
				<div class="panel-heading">购买</div>
				<div class="panel-body">
				
					<div class="well well-lg" style="background: #FFC" >
					<div  id="text" style='margin-bottom: 5px;'>投注类型:</div>
					<label onclick="detail('text');show(5);" ><input name="betChildType" type="radio" checked="checked"  value="x5" />五星玩法 </label>
					<label onclick="detail('x4')" ><input name="betChildType" type="radio" value="x4" />四星玩法 </label>
					<label onclick="detail('x3')" ><input name="betChildType" type="radio" value="x3" />三星玩法</label>
				    <label onclick="detail('z3')" ><input name="betChildType" type="radio" value="z3" />三星组选 </label>   
				    <label onclick="detail('x2')" ><input name="betChildType" type="radio" value="x2" />二星直选 </label>
				    <label onclick="detail('z2')" ><input name="betChildType" type="radio" value="z2" />二星组选</label>    
				    <label onclick="detail('text');show(5);" ><input name="betChildType" type="radio"  value="dd" />定位胆 </label>
				    <label onclick="detail('bdd')" ><input name="betChildType" type="radio"   value="bdd" />不定胆 </label>
				    <label onclick="detail('dxd')" ><input name="betChildType" type="radio" value="dxd" />大小单双 </label>
				    
				    <br>
				    <div id="x4" style="display:none"><label onclick="show('q4')" ><input name="betChildTypex4" type="radio"  value="x4q4" />前四 </label>
					<label onclick="show('h4')" ><input name="betChildTypex4" type="radio" value="x4h4" />后四 </label>
					<label onclick="show(5)" ><input name="betChildTypex4" type="radio" value="x4r4" />任选四</label></div>
					
					<div id="x3" style="display:none"><label onclick="show('q3')" ><input name="betChildTypex3" type="radio"  value="x3q3" />前三</label>
					<label onclick="show('z3')" ><input name="betChildTypex3" type="radio" value="x3z3" />中三 </label>
					<label onclick="show('h3')" ><input name="betChildTypex3" type="radio" value="x3h3" />后三 </label>
					<label onclick="show(5)" ><input name="betChildTypex3" type="radio" value="x3r3" />任选三</label></div>
				
					
					<div id="z3" style="display:none"><label onclick="show(0)" ><input name="betChildTypez3" type="radio"  value="q3z3" />前三组三</label>
					<label onclick="show(0)" ><input name="betChildTypez3" type="radio" value="q3z6" />前三组六 </label>
					<label onclick="show(0)" ><input name="betChildTypez3" type="radio" value="z3z3" />中三组三</label>
					<label onclick="show(0)" ><input name="betChildTypez3" type="radio" value="z3z6" />中三组六</label>
					<label onclick="show(0)" ><input name="betChildTypez3" type="radio" value="h3z3" />后三组三</label>
					<label onclick="show(0)" ><input name="betChildTypez3" type="radio" value="h3z6" />后三组六</label>
					<label onclick="show(0);checkbox()" ><input name="betChildTypez3" type="radio" value="r3z3" />任选三组三</label>
					<label onclick="show(0);checkbox()" ><input name="betChildTypez3" type="radio" value="r3z6" />任选三组六</label></div>
		
					
					<div id="x2" style="display:none"><label onclick="show('q2')" ><input name="betChildTypex2" type="radio" value="x2q2" />前二</label>
					<label onclick="show('h2')" ><input name="betChildTypex2" type="radio" value="x2h2" />后二 </label>
					<label onclick="show(5)" ><input name="betChildTypex2" type="radio" value="x2r2" />任选二</label></div>
					
					
					
					<div id="z2" style="display:none"><label onclick="show(0)" ><input name="betChildTypez2" type="radio" value="q2z2" />前二</label>
					<label onclick="show(0)" ><input name="betChildTypez2" type="radio" value="h2z2" />后二</label>
					<label onclick="show(0);checkbox()" ><input name="betChildTypez2" type="radio" value="r2z2" />任选二</label></div>
			
					
					
					<div  id="bdd" style="display:none"><label onclick="show(0)" ><input name="betChildTypebdd" type="radio"  value="q3bdd" />前三不定胆</label>
					<label onclick="show(0)" ><input name="betChildTypebdd" type="radio" value="z3bdd" />中三不定胆</label>
					<label onclick="show(0)" ><input name="betChildTypebdd" type="radio" value="h3bdd" />后三不定胆</label>
					<label onclick="show(0);checkbox()" ><input name="betChildTypebdd" type="radio" value="r3bdd" />任三不定胆</label>
					<label onclick="show(0)" ><input name="betChildTypebdd" type="radio" value="q3em" />前三二码</label>
					<label onclick="show(0)" ><input name="betChildTypebdd" type="radio" value="h3em" />后三二码</label>
			         </div>
					
					
					<div  id="dxd"  style="display:none"><label onclick="show('q2dxd')" ><input name="betChildTypedxd" type="radio" value="q2dxd" />前二大小单</label>
					<label onclick="show('h2dxd')" ><input name="betChildTypedxd" type="radio" value="h2dxd" />后二大小单</label>
					<label onclick="show('r2dxd')" ><input name="betChildTypedxd" type="radio" value="r2dxd" />任二大小单</label>
					<label onclick="show('wwdxd')" ><input name="betChildTypedxd" type="radio" value="wwdxd" />万位大小单</label>
					<label onclick="show('qwdxd')" ><input name="betChildTypedxd" type="radio" value="qwdxd" />千位大小单</label>
					<label onclick="show('bwdxd')" ><input name="betChildTypedxd" type="radio" value="bwdxd" />百位大小单</label>
				    <label onclick="show('swdxd')" ><input name="betChildTypedxd" type="radio" value="swdxd" />十位大小单</label>
					<label onclick="show('gwdxd')" ><input name="betChildTypedxd" type="radio" value="gwdxd" />个位大小单</label>
								
					</div>
					
					
					</div>
					<div class="well well-lg" style="background: #FFC">
					
						<div  id="checkbox"  style="display:none"><label ><input name="betChildTypeR" type="checkbox" value="1" />万</label>
					     <label  ><input name="betChildTypeR" type="checkbox" value="2" />千</label>
					     <label  ><input name="betChildTypeR" type="checkbox" value="3" />百</label>
					     <label  ><input name="betChildTypeR" type="checkbox" value="4" />十</label>
					     <label  ><input name="betChildTypeR" type="checkbox" value="5" />个</label>
					    </div>
						<br>
						<div style='margin-bottom: 5px;'>选号区:</div>
						<div style="height: 130px">
						
							<div id='select1cqssc' class="span_style" >
								<span class="span_style">万位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select2cqssc' class="span_style" >
								<span class="span_style">千位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select3cqssc' class="span_style" >
								<span class="span_style">百位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select4cqssc' class="span_style" >
								<span class="span_style">十位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							<br>
							<div id='select5cqssc' class="span_style" >
								<span id='select5cqsscspan'   class="span_style">个位:</span> <span onclick='check(this)' class="span_cicle">0</span> <span onclick='check(this)' class="span_cicle">1</span> <span onclick='check(this)' class="span_cicle">2</span> <span onclick='check(this)' class="span_cicle">3</span> <span onclick='check(this)' class="span_cicle">4</span> <span onclick='check(this)' class="span_cicle">5</span> <span onclick='check(this)' class="span_cicle">6</span> <span onclick='check(this)' class="span_cicle">7</span> <span onclick='check(this)' class="span_cicle">8</span> <span onclick='check(this)' class="span_cicle">9</span>
							</div>
							   <br>
								<div id='select1dxd'  style="display:none" class="span_style" >
								<span  class="span_style">万位:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select2dxd'  style="display:none" class="span_style" >
								<span  class="span_style">千位:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select3dxd'  style="display:none" class="span_style" >
								<span  class="span_style">百位:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select4dxd'  style="display:none" class="span_style" >
								<span  class="span_style">十位:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
							   </div>
							   <br>
							   <div id='select5dxd'  style="display:none" class="span_style" >
								<span  class="span_style">个位:</span> <span onclick='check(this)' class="span_cicle">大</span> <span onclick='check(this)' class="span_cicle">小</span> <span onclick='check(this)' class="span_cicle">单</span> <span onclick='check(this)' class="span_cicle">双</span> 
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
