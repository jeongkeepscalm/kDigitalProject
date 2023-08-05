<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게시판목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="/pp/resources/css/mypage.css" rel="stylesheet">
<style>
	.container form table{table-layout: fixed}
	.container form table tr td{
		 white-space: nowrap; /*nowrap 줄바꿈을 하지 않음.*/
	     overflow: hidden;
	     text-overflow: ellipsis;
	     padding: 5px 10px;
	}
</style>
<script>
$(function(){
	// 검색 버튼 클릭시 검색에 맞는 목록 호출.
	$('#searchBtn').click(function(){
		myList();
	}) 
});

function myList() {
	var stype= $('#stype').val();
	var sword= $('#sword').val();
	$.ajax({
			url : '/pp/board/myList2',
		type : 'post',
		data : {
			sword : sword
		},
		success : function(e) {
			$("#area").html(e);
		},
		error : function(e){
			alert(`error:search`);
		}
		});
	return false;
};
</script>
</head> 
<body class="text-center">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<main class="form-signin w-100 m-auto">
<div class="container">
        <div id="area"></div>
       	 	<div>
	        <h2>내가 쓴 댓글</h2>
                <form method="post" name="Form" id="searchForm" action="" onsubmit="return myList();"> 
                    <span class="srchSelect">
                        <select id="stype" name="stype" value="${param.stype }">
                            <option value="content">댓글내용</option>
                        </select>
                    </span>
                    <span class="searchWord">
                        <input type="text" id="sword" name="sword" value="${param.sword }" >
                        <input type="button" id="searchBtn" value="검색" title="검색">
                    </span>
            	<table class="table">
            	<colgroup>
                    <col width="100px" />
                    <col width="100px" />
                    <col width="100px" />
                    <col width="200px" />
                    <col width="120px" />
                </colgroup>
                    <tr>
                        <th>게시판이름</th>
                        <th>글 번호</th>
                        <th>제목</th>
                        <th>댓글내용</th>
                        <th>댓글달은 날짜</th>
                    </tr>
					<c:if test="${empty data.list }">
                    <tr>
                        <td class="first" colspan="5">등록한 글이 없습니다.</td>
                    </tr>
                	</c:if>
                <c:forEach var="vo" items="${data.list }" varStatus="status">
                    <tr>
                    	<td>${vo.board_name}</td>
                        <td>${vo.board_no }</td>
                        <td class="titlee" > <a href="/pp/board/view.do?board_no=${vo.board_no}&board_name=여행게시판 ">${vo.title}</a></td>
                        <td>${vo.content}</td>
                        <td class="date"><fmt:formatDate value="${vo.reply_writedate }" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
            	</table>
            	<div>
	                <ul class='paging'>
	                 	<c:if test="${data.prev == true }"> 
	                 		<a href="javascript:getPage2(${data.startPage-1})"><i class="fa-solid fa-arrow-left"></i></a>
	                 	</c:if>
	                 	<c:forEach var="p" begin="${data.startPage }" end="${data.endPage }">
	                    	<a href="javascript:getPage2(${p})">${p }</a>
	                    </c:forEach>
	                    <c:if test="${data.next == true }">
	                 		<a href="javascript:getPage2(${data.endPage+1})" ><i class="fa-solid fa-arrow-right"></i></a>
	                	</c:if>
	               	</ul> 
	            </div>
         	</form>
        </div>
    </div>
</main>
</body>
</html>