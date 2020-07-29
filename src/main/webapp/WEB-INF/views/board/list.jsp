<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BOARD</title>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<style>
.container{
	margin-top: 30px;
}
form{
	margin-bottom: 10px;
}

select{
  border: 1px solid #ccc;
  border-radius: 4px;

}
form input[type='text']{
  border: 1px solid #ccc;
  border-radius: 4px;

}
form button{

	background-color: #e7e7e7; 
	color: black;
	 border-radius: 4px;
}
th, td{
	text-align: center;
	font-family:  Arial, Helvetica, sans-serif;
	font-size: 14px;
}

.tr1{
	width: 6%;
}
.tr2{

}
.tr3{
	width: 10%;
}
.tr4{
	width: 20%;
}
.tr5{
	width: 8%;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>
	<div class="container">
		<div class="search-bar">
			<form action="/board/list" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<select name="type">
					<option value="title" ${pageMaker.cri.type eq 'title'? 'selected': ''}>제목</option>
					<option value="content" ${pageMaker.cri.type eq 'content'? 'selected': ''}>내용</option>
					<option value="writer_id" ${pageMaker.cri.type eq 'writer_id'? 'selected': ''}>작성자</option>
				</select>
				<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
				<input type="hidden" name="id">
				
				<button id="search-btn" type="button">검색</button>
			</form>		
			
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="tr1">번호</th>
					<th class="tr2">제목</th>
					<th class="tr3">작성자</th>
					<th class="tr4">작성일</th>
					<th class="tr5">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="board">
					<tr>
						<td class="tr1">${board.id }</td>
						<td class="tr2"><a class="get-url" href="${board.id }">${board.title }</a></td>
						<td class="tr3">${board.writer_id }</td>
						<td class="tr4"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.date }"/></td>
						<td class="tr5">${board.view }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="pull-right">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1 }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : '' }" ><a class="page-link" href="${num}">${num }</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next }">
					<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }"><span aria-hidden="true">&raquo;</span></a></li>
				</c:if>
			</ul>
		</div>
		<button id="insert-btn" class="btn btn-info">글쓰기</button>	
	</div>

</body>
<script type="text/javascript">
$(document).ready(function(){
	var result = '<c:out value="${result}" />';
	var welcome = '<c:out value="${welcome}" />';
	checkResult(result);
	checkLogin(welcome);
	history.replaceState({}, null, null);
	
	var form = $("form");
	
	$("#insert-btn").on("click", function(e){
		e.preventDefault();

		self.location = "/board/insert";
	});
	
	$("#search-btn").on("click", function(e){
		e.preventDefault();
		
		if(!form.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
		}
		if(!form.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		
		form.find("input[name='pageNum']").val("1");
		form.find("input[name='id']").remove();
		form.submit();		
	});
	
	$(".page-link").on("click", function(e){
		e.preventDefault();
		form.find("input[name='pageNum']").val($(this).attr("href"));
		form.find("input[name='id']").remove();
		form.submit();
	});
	
	$(".get-url").on("click", function(e){
		e.preventDefault();
		var id = $(this).attr("href");
		form.find("input[name='id']").val(id);
		form.attr("action", "/board/get").submit();
		form.submit();
	});
	
	
	function checkResult(result){
		if(result === '' || history.state){return;}
		
		alert(result);
	}
	function checkLogin(welcome){
		if(welcome === '' || history.state){return;}
		
		alert(welcome);
	}
});
</script>

</html>