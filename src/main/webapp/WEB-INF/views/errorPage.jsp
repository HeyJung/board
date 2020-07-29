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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js?ver=2"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
<style>
.container{
	margin-top: 20px;
	margin-bottom: 20px;
}
.error-box{
	margin-left: auto;
	margin-right: auto;
	height: 50px;
	width: 500px;
	background: #CEF6F5;
	text-align: center;
	vertical-align: middle;
	font-family: 'Nanum Gothic Coding', monospace;
	
}
</style>
</head>
<body>

<%@ include file="./header.jsp" %>
	<div class="container">
		<div class="error-box">
			<span>
				<i class="fas fa-exclamation-triangle"></i> ${errorMsg } <i class="fas fa-exclamation-triangle"></i>
			</span>
		</div>
	</div>
</body>
</html>