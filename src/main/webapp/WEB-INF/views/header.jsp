<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BOARD</title>
<script src="https://kit.fontawesome.com/0b8f6759db.js" crossorigin="anonymous"></script>
<style>

#header{
	height: 100px;
	width: 100%;
	background: #58ACFA;
/* 	opacity : 0.6; */

}
#header .home{
/* 	margin-top: 10px; */
	height:55px;
	display: flex;
	position: relative;

}
.home .content{
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}
/* .home .content img{ */
/* 	margin-top: 10px; */
/* 	height: 40px; */
/* 	width: 40px; */
/* 	border-radius: 70%; */
/* 	border: 3px solid; */
/* } */
.home .content i{
	margin-top: 10px;
}
.home .content p{

}
#header .menu{

	margin-top:5px;
	height: 30px;
	position: relative;
	align-items: center;
}
.menu .search-bar{
/* 	height: 50px; */
/* 	width: 200px; */
/* 	background: white; */
	margin-left: auto;
	margin-right: auto;
	
	display: flex;
	
}
.search-bar select{
	height: 30px;
}
.search-bar input{
	width: 200px;
	height: 30px;
}
.menu nav{
	position: absolute;
	right: 10px;
	bottom: 3px;
}
nav ul{
	padding: 0px;
	margin: 0px;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: space-between;
}
nav ul li{
	margin-right: 5px;
	
}

li{
	list-style:none;
	padding: 0px;
	margin: 0px;
}
li a{
	color: black;
}
</style>
</head>
<body>
	<div id="header">
		<div class="home">
			<div class="content">
<!-- 				<a><img src="/resources/imgs/home.jpg" alt="home-img"></a> -->
				<a href="/board/list"><span style="color: #0404B4;"><i class="fab fa-fort-awesome fa-4x"></i></span></a>
				<p><strong>home</strong></p>
			</div>
		</div>
		<div class="menu">
			<nav>
				<ul>
					<c:if test="${user == null}">
						<li><a href="/member/login"><small>로그인</small></a></li>
						<li><a href="/member/register"><small>회원가입</small></a></li>
					</c:if>
					<c:if test="${user != null}">
						<li><a href="/member/mypage/home"><small>마이페이지</small></a></li>
						<li><a href="/member/logout"><small>로그아웃</small></a></li>
					</c:if>					
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>