<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/globle/jsp/base.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投注信息列表</title>
</head>
<body>

	<div class="container" style="padding: 20px 0 0 30px; width: 100%">
		<div class="row" style="width: 100%;">
			<s:form action="betmessage!listBackBetMessage.action" method="post" id="form_search" cssClass="form-horizontal">
				<div class="row" style="width: 100%">
					<div class="control-group span8">
						<label class="control-label">投注人：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="betPersonName"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">投注类型：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="betType"></s:textfield>
						</div>
					</div>
					<div class="control-group span8">
						<label class="control-label">投注期数：</label>
						<div class="controls">
							<s:textfield cssClass="control-text" name="betPeriod"></s:textfield>
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
							<th>投注人</th>
							<th>投注类型</th>
							<th>投注期数</th>
							<th>投注倍数</th>
							<th>投注号码</th>
							<th>投注日期</th>
						</tr>

						<s:iterator value="#pageModel.recordList">
							<tr>
								<td><input type="checkbox" name="ids" value="${id}"></td>
								<td>${betPersonName}</td>
								<td>${betType}</td>
								<td>${betPeriod}</td>
								<td>${betQuan}</td>
								<td>${betNum}</td>
								<td>${betDate}</td>
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