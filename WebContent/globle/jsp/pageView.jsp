<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="container">
	<div class="row" style="line-height: 36px">
			<div class="control-group span9">
				<label class="control-label" style="font-size: 16px"> 页次：${requestScope.pageModel.currentPage}/${requestScope.pageModel.pageCount}页 &nbsp; 每页显示：${requestScope.pageModel.pageSize }条 &nbsp; 总记录数：${requestScope.pageModel.recordCount }条 </label>
			</div>
			<div class="control-group span12">
				<ul class="pagination">
					<li><a href="javascript: gotoPage(1)" title="首页">&larr;</a></li>

					<s:iterator begin="%{#pageModel.beginPageIndex}" end="%{#pageModel.endPageIndex}" var="num">
						<s:if test="currentPage == #num">
							<%-- 当前页 --%>
							<li class="active"><a href="javascript:void(0)">${num}</a></li>
						</s:if>
						<s:else>
							<%-- 非当前页 --%>
							<li><a href="javascript: gotoPage(${num})">${num}</a></li>
						</s:else>
					</s:iterator>
					<li><a href="javascript: gotoPage(${requestScope.pageModel.pageCount})" title="尾页">&rarr;</a></li>
				</ul>
			</div>
			<div class="control-group span3 ">

				<label style="font-size: 16px" class="control-label">转到
					<select id="pn" onchange="gotoPage(this.value)" style="width:60px" class="">
						<s:iterator begin="1" end="%{#pageModel.pageCount}" var="num">
							<option value="${num}">${num}</option>
						</s:iterator>
					</select>
				</label>
				<script type="text/javascript">
					// 回显页码
					$("#pn").val("${requestScope.pageModel.currentPage}");
				</script>

			</div>
	</div>


</div>

<script type="text/javascript">
	function gotoPage(pageNum) {
		// window.location.href = "forumAction_show.action?id=${id}&pageNum=" + pageNum;
		$("#form_search").append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
		$("#form_search").submit(); // 提交表单
		/* 		$(document.forms[0]).append("<input type='hidden' name='pageNum' value='" + pageNum + "'/>");
		 document.forms[0].submit(); // 提交表单 */

	}

	
</script>