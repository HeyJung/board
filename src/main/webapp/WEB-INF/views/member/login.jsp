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
<script src="/resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js?ver=2"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>

<style>
.container{
	margin-top: 20px;
	margin-bottom: 20px;
}
form{
	margin-right: auto;
	margin-left: auto;
	width: 460px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
h1{
	text-align: center;
	font-family: Georgia, "맑은 고딕", serif;
}

input{
	height: 51px;
	width: 100%;
	border: 1px solid #BDBDBD;
}
.login_row{
	margin-bottom: 10px;
}

.error-box-red{
	font-size: 12px;
	color: red;
}
form button{
	height: 51px;
	width: 100%;
	border: none;
	background-color: #0080FF;
	color: white;
	font-weight: bold;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>
	<div class="container">
		<form id="loginForm" action="/member/login" method="post">
			<h1>로그인</h1>
			<div class="login_row">
				<input id="id" type="text" name="id" maxlength="20" placeholder="아이디">
			</div>
			<div class="login_row">
				<input id="pw" type="password" name="pw" maxlength="8" placeholder="비밀번호">
				<span class="error-box" id="loginMsg" style="display: none;"></span>
			</div>
			<div class="login_row">
				<button id="login-button">로그인</button>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/* 버튼 클릭 이벤트 */
	var form = $("#loginForm");
	
	$("#login-button").on("click", function(e){
		e.preventDefault();
		var id = $("#id");
		var pw = $("#pw");
		if(id.val() == "" || id.val() == null) {
			alert("아이디를 입력해주세요");
			return false;
		}
		if(pw.val() == ""|| pw.val() == null){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		form.submit();
	});
	
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	/* 로그인 실패 */
	var falseMsg = '<c:out value="${falseMsg}" />';
	var inputid = '<c:out value="${inputid}" />'
	var loginMsg = $("#loginMsg");
	console.log(falseMsg);
	if(falseMsg !== null || falseMsg !== ""){
		console.log(falseMsg);
		if(falseMsg === '0'){
			showErrorMsg(loginMsg, "존재하지 않는 아이디입니다");
		}
		if(falseMsg === '1'){
			showErrorMsg(loginMsg, "아이디와 비밀번호가 일치하지 않습니다");
		}	
		
	}
	
	function showErrorMsg(obj, msg){
		obj.attr("class", "error-box-red");
		obj.html(msg);
		obj.show();
	}
});
</script>
</html>