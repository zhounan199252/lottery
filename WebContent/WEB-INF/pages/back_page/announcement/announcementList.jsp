<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告列表</title>

<script type="text/javascript">

	function doPublish(url) {
		var checkboxs = $("[name=ids]:checked");
		
		if(checkboxs.length <= 0) {
			BUI.Message.Alert("请至少选择一条信息进行发布！");
			return false;
		}
		
		var id = "";
		for (var i = 0; i < checkboxs.length; i++) {
			id += $(checkboxs[i]).prop("value") + ",";
		}

		var _url = url + "?id=" + id.substring(0, id.length - 1);
		location.href = _url;
	}
	
	function doUnPublish(url) {
		var checkboxs = $("[name=ids]:checked");
		
		if(checkboxs.length <= 0) {
			BUI.Message.Alert("请至少选择一条信息进行取消发布！");
			return false;
		}
		
		var id = "";
		for (var i = 0; i < checkboxs.length; i++) {
			id += $(checkboxs[i]).prop("value") + ",";
		}

		var _url = url + "?id=" + id.substring(0, id.length - 1);
		location.href = _url;
	}


</script>

</head>
<body>

	<div class="container" style="padding: 20px 0 0 30px; width: 100%">
		<div class="row" style="width: 100%;">
			<s:form action="announcement!listAnnouncement.action" method="post" id="form_search" cssClass="form-horizontal">
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">公告类型：</label>
						<div class="controls">
							<s:select list="#{'announcement':'消息公告', 'favor':'优惠活动'}" listKey="key" listValue="value" headerKey="" headerValue="-请选择-" name="type"></s:select>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">标题：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="title"></s:textfield>
						</div>
					</div>
					<div class="control-group span12">
						<label class="control-label">发布时间：</label>
						<div class="controls">
							<s:textfield cssClass="control-text Wdate" name="publishTimeBegin" readonly="true" id="txt_publishTimeBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(txt_publishTimeEnd)}'})"></s:textfield>
							-
							<s:textfield cssClass="control-text Wdate" name="publishTimeEnd" readonly="true" id="txt_publishTimeEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(txt_publishTimeBegin)}'})"></s:textfield>
						</div>
					</div>
					
					<div class="control-group span8">
						<label class="control-label">状态：</label>
						<div class="controls">
							<s:select list="#{'no':'未发布', 'yes':'已发布'}" listKey="key" listValue="value" headerKey="" headerValue="-请选择-" name="status"></s:select>
						</div>
					</div>
				</div>
			</s:form>
		</div>
	</div>

	<div class="container" style="width: 100%; padding-left: 8px">
		<div class="row" style="width: 100%;">
			<div class="row" style="padding: 10px 0 0 10px;">
				<div class="control-group span24">
					<label class="control-label">
						<button class="button" onclick="doAdd('${pageContext.request.contextPath}/announcement!addAnnouncementPage.action');">添加</button>
					</label> <label class="control-label">
						<button class="button" onclick="doUpdate('${pageContext.request.contextPath}/announcement!editAnnouncementPage.action')">编辑</button>
					</label> <label class="control-label">
						<button class="button" onclick="doRemove('${pageContext.request.contextPath}/announcement!deleteAnnouncement.action');">删除</button>
					</label><label class="control-label">
						<button class="button" onclick="doPublish('${pageContext.request.contextPath}/announcement!publishAnnouncement.action');">发布</button>
					</label> 
					<label class="control-label">
						<button class="button" onclick="doUnPublish('${pageContext.request.contextPath}/announcement!unPublishAnnouncement.action');">取消发布</button>
					</label> <label class="control-label">
						<button class="button" onclick="doSearch();">搜索</button>
					</label> <label class="control-label">
						<button class="button" onclick="doClear();">清空</button>
					</label>
				</div>
			</div>
			<div class="row" style="width: 100%">
				<div class="control-group span24" style="width: 98%">
					<table class="table table-striped table-bordered">
						<tr>
							<th style="width: 30px"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)" title="全选"></th>
							<th>类型</th>
							<th>标题</th>
							<th>编辑时间</th>
							<th>状态</th>
							<th>发布时间</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>
									<s:if test="type == 'favor'">
										优惠活动
									</s:if>
									<s:else>
										消息公告
									</s:else>
								</td>
								<td>${title}</td>
								<td>${editTime}</td>
								<td>
									<s:if test="status == 'no'">
										未发布
									</s:if>
									<s:else>
										已发布
									</s:else>
								</td>
								<td>${publishTime}</td>
							</tr>
						</s:iterator>

					</table>


				</div>
			</div>
			<div class="row" style="padding-left: 10px">
				<div class="control-group span24 ">
					<jsp:include page="/globle/jsp/pageView.jsp"></jsp:include>
				</div>
			</div>
		</div>

	</div>

</body>
</html>