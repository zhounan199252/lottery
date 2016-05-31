<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

 <script>
 
 //查看开奖信息
	function look(name) {
		$.ajax({
			url : "http://f.apiplus.cn/"+name+".json",
			type : "post",
			dataType: 'jsonp',
		    jsonp: 'callback',
			success : function(result) {
				var data= result.data;
				if (data.length > 0) {
					$("#gd11x5").find("ul").remove();
					var ul= "<ul>最新开奖结果 ";
					for (var i = 0; i < data.length; i++) {
						ul=ul+"<li>开奖期数:"+data[i].expect+",开奖号码"+data[i].opencode+",开奖时间"+data[i].opentime +",开奖时间毫秒值"+data[i].opentimestamp+"</li>";
					}
					  ul=ul+ "</ul>";
						$("#gd11x5").append(ul);
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
<li  id="gd11x5"> 广东十一选五  &emsp;&emsp;&emsp; <span  onclick="look('gd11x5')">查看最近开奖信息</span> &emsp;&emsp;&emsp;<span>下注</span> </li>  
<li>    </li>  
<li>    </li>  
<li>    </li>  
<li>    </li>  
</ul>

</body>
</html>
