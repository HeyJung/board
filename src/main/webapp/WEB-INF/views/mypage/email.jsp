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
h3{
	margin-bottom: 2px;
}
h3 label{
	font-size: 15px;
	font-weight: bold;
	margin-bottom: 0px;
}
input{
	height: 51px;
	width: 100%;
	border: 1px solid #BDBDBD;
}
.email_row{
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
		<form id="emailForm" action="/email/send" method="post">
			<h5>이메일 인증을 하셔야 게시글 작성이 가능합니다</h5>
			<div class="email_row">
				<h3><label>이메일</label></h3>
				<input id="email" type="email" name="email" maxlength="30" value="${email }">
				<input id="random" type="hidden" value="${random}" > 
			</div>

			<div class="email_row">
				<button id="email-send">발송하기</button>
			</div>
			<div class="email_row" id="auth-row">
			
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/* 버튼 클릭 이벤트 */
	var form = $("#emailForm");
	
	$("#email-send").on("click", function(e){
		e.preventDefault();
		var authDiv = $("#auth-row");
		$.ajax({
			type: 'get',
			url: '/email/send',
			data: 'email='+$("#email").val()+'&random='+$("#random").val(),
			dataType: 'text',
			success: function(data){
				alert("메일이 발송되었습니다");
				var str = "";
				str += '<div class="email_row">';
				str += '	<h3><label>인증번호</label></h3>';
				str += '	<input id="auth" type="text" name="auth" maxlength="30" placeholder="메일의 인증번호를 입력하세요">';
				str += '</div>';
				str += '<div class="email_row">';
				str += '	<button id="email-auth">인증하기</button>';
				str += '</div>';

				authDiv.html(str);
			},
			error: function(err){
				alert("에러가 발생했습니다");
			}
		});
	});
	
	$(".email_row").on("click", "#email-auth", function(e){
		e.preventDefault();
		
		$.ajax({
			type: 'get',
			url: '/email/auth',
			data: 'authCode='+$("#auth").val()+'&random='+$("#random").val(),
			success: function(data){
				if(data == 'success'){
					alert("인증이 완료되었습니다");
					location.href="/board/list";
				}
				else{
					alert("인증번호를 잘못 입력하셨습니다");
				}
			},
			error: function(err){
				alert("에러가 발생했습니다");
			}
		});
	
	});
	
});
</script>
</html>