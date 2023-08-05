<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
var oEditors; // 에디터 객체 담을 곳
$(document).ready(function(e){
	oEditors = setEditor("<%=request.getContextPath()%>", "contents"); // 에디터 셋팅
});

function goSave() {
	if ($("#title").val() == "") {
		alert('제목을 입력해 주세요.');
		$("#title").focus();
		return false;
	}
	var sHTML = oEditors.getById["contents"].getIR();
	if (sHTML == "") {
		alert('내용을 입력해 주세요.');
		$("#contents").focus();
		return false;
	} else {
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	}
	$("#frm").submit();
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>답변게시판	</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form method="post" name="frm" id="frm" action="/pp/reply/replyProcess.do">
	    <input type="hidden" name="gno" value="${data.gno}">
        <input type="hidden" name="ono" value="${data.ono }">
        <input type="hidden" name="nested" value="${data.nested }">
		<input type="hidden" name="cmd" value="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="title" value="" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" name="content" rows="25"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
				<a href="javascript:goSave();" class="btn">저장</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
