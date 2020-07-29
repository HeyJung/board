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
<script src="https://kit.fontawesome.com/0b8f6759db.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<style>
.container{
	margin-top: 20px;
	margin-bottom: 20px;
}

h1{
	text-align: center;
	font-family: 'Jua', sans-serif;
}


.info_row{
	margin-bottom: 10px;
}

.container li{
	list-style: none;
	height: 40px;
	width: 100%;
	font-family: 'Jua', sans-serif;
	display: flex;
	position : relative;
}
li .icon{
	position: absolute;
	left: 35%;
}
li .info{
	position: absolute;
	left: 40%;
}
.info_row button{
	height: 20px;
	border: none;
	background-color: #0080FF;
	color: white;
	border-radius: 2px;
	position: absolute;
	left: 66%;
	font-size: 13px;
}

.button_row{
	margin-bottom: 10px;
	position : relative;
}
.button_row button{
	width: 200px;
	border: none;
	background-color: #D8D8D8;
	color: black;
	border-radius: 2px;
	font-family: 'Jua', sans-serif;
	position: absolute;
	left: 40%;

}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>
	<div class="container">
		
		<h1>마이페이지</h1>
		<div class="info_row">
			<ul>
				<li>
					<div class="icon"><i class="fas fa-lemon"></i></div>
					<div class="info">아이디 : ${userinfo.id }</div>
				</li>
				<li>
					<div class="icon"><i class="far fa-lemon"></i></div>
					<div class="info">이 름 : ${userinfo.name }</div>
				</li>
				<li>
					<div class="icon"><i class="fas fa-lemon"></i></div>
					<div class="info">이메일 : ${userinfo.email }</div>
					<button type="button" id="auth-button" data-auth="${userinfo.auth }">인증하기</button>
				</li>
				<li>
					<div class="icon"><i class="far fa-lemon"></i></div>
					<div class="info">전화번호 : ${userinfo.phone }</div>
				</li>
				
			</ul>
		</div>
		<div class="button_row">
			<button type="button" id="update-button"><i class="fas fa-user-edit"></i>회원 정보 수정</button>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/* 버튼 클릭 이벤트 */
	var form = $("#updateForm");
	
	$("#update-button").on("click", function(e){
		e.preventDefault();
		location.href="/member/mypage/update";
		var oper = $(this).data("oper");
	});
	
	$("#auth-button").on("click", function(e){
		e.preventDefault();
		var auth = $(this).data("auth");
		console.log(auth);
		if(!auth){
			location.href="/email/home";
			return;
		}
		
		alert("이미 인증되었습니다");
	});
	
});
</script>

</html>