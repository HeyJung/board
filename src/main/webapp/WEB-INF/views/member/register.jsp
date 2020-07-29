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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
.register_row{
	margin-bottom: 10px;
}
.error-box{
	font-size: 12px;
	color: green;
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
		<form id="registerForm" action="/member/register" method="post">
			<h1>회원가입</h1>
			<div class="register_row">
				<h3><label>아이디</label></h3>
				<input id="id" type="text" name="id" maxlength="20">
				<span class="error-box" id="idMsg" style="display: none;">사용할 수 없는 아이디입니다.</span>
			</div>
			<div class="register_row">
				<h3><label>비밀번호</label></h3>
				<input id="pw" type="password" name="pw" maxlength="8">
				<span class="error-box" id="pwMsg" style="display: none;"></span>
			</div>
			<div class="register_row">
				<h3><label>비밀번호 확인</label></h3>
				<input id="pw2" type="password" name="pw2" maxlength="8">
				<span class="error-box" id="pw2Msg" style="display: none;"></span>
			</div>
			<div class="register_row">
				<h3><label>이름</label></h3>
				<input id="name" type="text" name="name" maxlength="10">
				<span class="error-box" id="nameMsg" style="display: none;"></span>
			</div>
			<div class="register_row">
				<h3><label>이메일</label></h3>
				<input id="email" type="text" name="email" maxlength="30">
				<span class="error-box" id="emailMsg" style="display: none;"></span>
			</div>
			<div class="register_row">
				<h3><label>휴대폰(선택)</label></h3>
				<input id="phone" type="text" name="phone" maxlength="13">
				<span class="error-box" id="phoneMsg" style="display: none;"></span>
			</div>
			<div class="register_row">
				<button id="register-button">제출하기</button>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/* 버튼 클릭 이벤트 */
	var form = $("#registerForm");
	
	$("#register-button").on("click", function(e){
		e.preventDefault();
// 		var id = $("#id");
// 		var pw = $("#pw");
// 		var pw2 = $("pw2");
// 		var name = $("name");
// 		var email = $("email");
		var cnt = 0;
		$(".register_row input").each(function(i, obj){
			var obj = $(obj);
			if(obj.attr("name") == "phone"){return ;}
			if(obj.val() == "" || obj.val() == null){
				showErrorMsg(obj.siblings("span"), "필수 입력 사항입니다");
				cnt++;
			}
		});

		if(cnt > 0){return false;}
		

		form.submit();
	});
	
	function showErrorMsg(obj, msg){
		obj.attr("class", "error-box-red");
		obj.html(msg);
		obj.show();
	}
	
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	/* 유효성 검사! */
	
	$("#id").blur(function(){
		checkId();
	});
	$("#pw").blur(function(){
		checkPw();
	});
	$("#pw2").blur(function(){
		checkPw2();
	});
	$("#name").blur(function(){
		checkName();
	});
	$("#email").blur(function(){
		checkEmail();
	});
	$("#phone").blur(function(){
		checkPhone();
	});
	
	/* id중복확인 */
	function checkId(){
		var id = $("#id").val();
		var msgtag = $("#idMsg");
		var idtag = $("#id");
		
		if(id == ""){
			showErrorMsg(msgtag, "필수 정보입니다");
			return false;
		}
		
		var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
		if(!isID.test(id)){
			showErrorMsg(msgtag, "5~20자의 영문 소문자, 특수기호(_),(-)만 사용 가능합니다");
			return false;
		}
		
		$.ajax({
			type: 'get',
			url: "/member/registerAjax?id="+id,
					success: function(data){
						console.log(data);
						var result = data;
						if(result === 'Y'){
							showSuccessMsg(msgtag, "사용 가능한 아이디입니다");
						}
						else{
							showErrorMsg(msgtag,"이미 사용중인 아이디입니다");
						}
					}
		});
		
		return true;
	}
	
	/* 비밀번호  */
	function checkPw(){
		var pw = $("#pw").val();
		var msgtag = $("#pwMsg");
		var pwtag = $("#pw");
		
		if(pw == ""){
			showErrorMsg(msgtag, "필수 정보입니다");
			return false;
		}
		if(isValidPw(pw) != true){
			showErrorMsg(msgtag, "4~8자의 문자를 입력해주세요(모든 문자가 반복되면 안됨)");
			return false;
		}
		else{
			msgtag.hide();
		}
		
	}
	
	/* 비밀번호 유효성 검사 */
	function isValidPw(str){
		var cnt = 0;
		if(str == ""){
			return false;
		}
		if(str.length < 4){
			return false;
		}
		for(var i=0; i<str.length; ++i){
			if(str.charAt(0) == str.substring(i, i+1)) {++cnt;}
		}
		if(cnt == str.length){return false;}
		
		var ispw = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{4,8}$/;
		if(!ispw.test(str)){
			return false;
		}
		return true;
	}
	
	/* 비밀번호 일치 */
	function checkPw2(){
		var pw = $("#pw").val();
		var pw2 = $("#pw2").val();
		var pwtag = $("#pw");
		var pw2tag = $("#pw2");
		var msgtag = $("#pw2Msg");
		
		if(pw2 == ""){
			showErrorMsg(msgtag, "필수 정보입니다");
			return false;
		}
		if(pw2 != pw){
			showErrorMsg(msgtag, "비밀번호가 일치하지 않습니다");
			return false;
		}
		else{
			msgtag.hide();
			return true;
		}
	}
	
	/* 이름 */
	function checkName(){
		var msgtag = $("#nameMsg");
		var name = $("#name").val();
		var nametag = $("#name");
		var nonchar = /[^가-힣a-zA-Z0-9]/;
		
		if(name ==""){
			showErrorMsg(msgtag, "필수 정보입니다");
			return false;
		}
		if(name != ""&& nonchar.test(name)){
			showErrorMsg(msgtag, "한글과 영문 대소문자를 사용하세요(특수기호, 공백 불가)");
			return false;
		}
		msgtag.hide();
		return true;
		
	}
	
	/* 이메일 */
	function checkEmail(){
		var msgtag = $("#emailMsg");
		var email = $("#email").val();
		var emailtag = $("#email");
		
		if(email ==""){
			showErrorMsg(msgtag, "필수 정보입니다");
			return false;
		}
		
		var isEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]+([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!isEmail.test(email)){
			showErrorMsg(msgtag, "이메일 주소를 다시 확인해주세요");
			return false;
		}
		
		msgtag.hide();
		return true;
	}
	
	/* 휴대폰 */
	function checkPhone(){
		var msgtag = $("#phoneMsg");
		var phone = $("#phone").val();
		var phonetag = $("#phone");
		
		var isPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		if(phone!="" && !isPhone.test(phone)){
			showErrorMsg(msgtag, "형식에 맞게 입력해주세요(010-1111-2222)");
			return false;
		}
		msgtag.hide();
		return true;
	}
	
	function showErrorMsg(obj, msg){
		obj.attr("class", "error-box-red");
		obj.html(msg);
		obj.show();
	}
	function showSuccessMsg(obj, msg){
		obj.attr("class", "error-box");
		obj.html(msg);
		obj.show();
	}	
});
</script>
</html>