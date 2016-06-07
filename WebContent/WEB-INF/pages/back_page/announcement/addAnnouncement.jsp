<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加公告</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/globle/js/fckeditor/fckeditor.js"></script>

<script type="text/javascript">
	function addSave() {
		
		var type = $("#sel_type").val();
		if(type.length <= 0) {
			BUI.Message.Alert("请选择类型！");
			return false;
		}
		
		var title = $("#txt_title").val();
		if(title.length <= 0) {
			BUI.Message.Alert("请填写标题！");
			return false;
		}
		
		var content = FCKeditorAPI.GetInstance("txt_content").GetXHTML();
		if(content.length <= 0) {
			BUI.Message.Alert("请填写内容！");
			return false;
		}
		
		$("#form_add").submit();
	}

</script>
</head>
<body>
	<div style="width: 90%;padding: 12px 0 0 12px">
	<h2>消息公告--添加公告</h2>
	
		<s:form action="backAnnouncement!addAnnouncement.action" id="form_add">
		<table class="table table-striped">
			<tr>
				<th style="width: 16%">类型</th>
				<td style="width: 80%">
					<s:select list="#{'announcement':'消息公告', 'favor':'优惠活动'}" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" name="type" id="sel_type"></s:select>
				</td>
				<td></td>
			</tr>
			<tr>
				<th style="width: 16%">标题</th>
				<td style="width: 80%"><s:textfield name="title" id="txt_title" cssClass="control-text" maxLength="20"></s:textfield></td>
				<td></td>
			</tr>
			<tr>
				<th>内容</th>
				<td>
					<s:textarea name="content" id="txt_content"></s:textarea>
				</td>
				<td></td>
			</tr>
			
			<tr>
				<th>
				</th>
				<td></td>
				<td></td>
			</tr>
		</table>
	</s:form>
	
	<button class="button button-primary" onclick="addSave();">保存</button>
	<button class="button" onclick="goBack();">取消</button>
	</div>

	<script type="text/javascript">
	$(function() {
		//初始化fckeditor
		var fck = new FCKeditor("txt_content");
		fck.BasePath = "${pageContext.request.contextPath}/globle/js/fckeditor/";  //editor的根路径
		fck.ToolbarSet = "MyEditor";  //指定使用哪个editor
		fck.Height = 400;   //设置editor的高度
		fck.Config["ImageUploadURL"] = "${pageContext.request.contextPath}/fileUpload!uploadFCKImage.action";  //设置图片的上传路径
		
		fck.Config['Enabled'] = true;
		fck.Config['UserFilesPath'] = '${pageContext.request.contextPath}/file_uploads/';
		
		fck.ReplaceTextarea();
	});
	
	
	</script>
</body>
</html>