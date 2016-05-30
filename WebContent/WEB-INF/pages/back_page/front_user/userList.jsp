<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>

<script type="text/javascript">
	function doInitPassword(url) {
		var checkboxs = $("[name=ids]:checked");

		if (checkboxs.length <= 0) {
			BUI.Message.Alert("请选择一个用户进行密码初始化！");
			return false;
		}

		if (checkboxs.length > 1) {
			BUI.Message.Alert("每次只能选择一个用户进行密码初始化！");
			return false;
		}

		BUI.Message.Confirm('确认要初始化该用户的密码为 88888888 么？', function() {

			var id = $(checkboxs).prop("value");

			var _url = url + "?id=" + id;
			location.href = _url;
		}, 'question');
	}

	function doRecharge(url) {
		var checkboxs = $("[name=ids]:checked");

		if (checkboxs.length <= 0) {
			BUI.Message.Alert("请选择一个用户进行充值！");
			return false;
		}

		if (checkboxs.length > 1) {
			BUI.Message.Alert("每次只能选择一个用户进行充值！");
			return false;
		}

		var id = $(checkboxs).prop("value");

		var _url = url + "?id=" + id;
		location.href = _url;
	}
</script>

</head>
<body>

	<div class="container" style="padding: 20px 0 0 30px; width: 100%">
		<div class="row" style="width: 100%;">
			<s:form action="frontUser!listFrontUser.action" method="post" id="form_search" cssClass="form-horizontal">
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">姓名：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="nickname"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">用户名：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="username"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">身份证号码：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="idCardNum"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">电话号码：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="phoneNum"></s:textfield>
						</div>
					</div>

				</div>
				<div class="row" style="width: 100%">

					<div class="control-group span12">
						<label class="control-label">注册时间：</label>
						<div class="controls">
							<s:textfield cssClass="control-text Wdate" name="registerTimeBegin" readonly="true" id="txt_registerTimeBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(txt_registerTimeEnd)}'})"></s:textfield> - 
							<s:textfield cssClass="control-text Wdate" name="registerTimeEnd" readonly="true" id="txt_registerTimeEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(txt_registerTimeBegin)}'})"></s:textfield>
						</div>
					</div>

					<div class="control-group span12">
						<label class="control-label">最后登录时间：</label>
						<div class="controls">
							<s:textfield cssClass="control-text Wdate" name="lastLoginTimeBegin" readonly="true" id="txt_lastLoginTimeBegin" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(txt_lastLoginTimeEnd)}'})"></s:textfield> - 
							<s:textfield cssClass="control-text Wdate" name="lastLoginTimeEnd" readonly="true" id="txt_lastLoginTimeEnd" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(txt_lastLoginTimeBegin)}'})"></s:textfield>
						</div>
					</div>

					<div class="control-group span12">
						<label class="control-label">余额：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="balanceBegin" data-rules="{number:true}"></s:textfield> - <s:textfield data-rules="{number:true}" cssClass="control-text" name="balanceEnd"></s:textfield>
						</div>
					</div>

				</div>
				<div class="row" style="width: 100%">

					<div class="control-group span6">
						

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
						<button class="button" onclick="doAdd('${pageContext.request.contextPath}/frontUser!addFrontUserPage.action');">添加</button>
					</label> <label class="control-label">
						<button class="button" onclick="doUpdate('${pageContext.request.contextPath}/frontUser!editFrontUserPage.action')">编辑</button>
					</label> <label class="control-label">
						<button class="button" onclick="doRemove('${pageContext.request.contextPath}/frontUser!deleteFrontUser.action');">删除</button>
					</label> <label class="control-label">
						<button class="button" onclick="doInitPassword('${pageContext.request.contextPath}/frontUser!initFrontUserPassword.action');">初始化密码</button>
					</label> <label class="control-label">
						<button class="button" onclick="doRecharge('${pageContext.request.contextPath}/frontUser!toRechargePage.action');">充值</button>
					</label>
					<label class="control-label">
							<button class="button" onclick="doSearch();">搜索</button>
						</label> 
						<label class="control-label">
							<button class="button" onclick="doClear();">清空</button>
						</label>
				</div>
			</div>
			<div class="row" style="width: 100%">
				<div class="control-group span24" style="width: 98%">
					<table class="table table-striped table-bordered">
						<tr>
							<th style="width: 30px"><input type="checkbox" id="chk_ids" onclick="$('[name=ids]').prop('checked', this.checked)" title="全选"></th>
							<th>姓名</th>
							<th>用户名</th>
							<th>账户余额</th>
							<th>身份证号码</th>
							<th>电话号码</th>
							<th>注册时间</th>
							<th>最后登录时间</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>${nickname}</td>
								<td>${username}</td>
								<td>${balance}</td>
								<td>${idCardNum}</td>
								<td>${phoneNum}</td>
								<td>${registerTime}</td>
								<td>${lastLoginTime}</td>
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





<script type="text/javascript">
  BUI.use('bui/form',function (Form) {
    new Form.Form({
      srcNode : '#form_search'
    }).render();
  });
</script>

















</body>
</html>