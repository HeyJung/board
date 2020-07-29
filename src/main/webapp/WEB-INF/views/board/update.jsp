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
body{
	margin-top: 150px;
	
}

label{
	font-weight: bold;
}
textarea{
	resize: none;
}
.uploadResult{
	width: 100%;
	background: #F2F2F2;
}
.uploadResult ul{
	display: flex;
	justify-content: flex-start;
	align-items: center;
}
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	width: 100px;
}
.uploadResult ul li img{
	width: 54px;
	height: 54px;
	border: 1px solid #5858FA;
}
.uploadResult span{
	white-space:normal;
}
.uploadResult button{
	border: none;
	width: 20px;
	height: 20px;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>
	<div class="container">
		<form action="/board/update" method="post">
			<input class="form-control" type="text" name="id" value="${board.id }" >
			<div class="card">
				<div class="card-header"><h3>내용을 입력해 주세요</h3></div>
				<div class="card-body">
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" type="text" name="title" value="${board.title }" >
					</div>
					<hr/>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" type="text" name="wrtier_id" value="${board.writer_id }" readonly="readonly" >
					</div>
					<hr/>
					<div class="form-group">
						<label>첨부 파일</label>
						<div class="uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult">
							<ul></ul>
						</div>
					</div>
					<hr/>
					<div class="form-group">
						<label>내용</label>
						<textarea id="content" class="form-control" name="content" rows="10">${board.content }</textarea>
					</div>
					<div class="button-div">
						<button data-oper="submit" class="btn btn-info">저장</button>
						<button data-oper="delete" class="btn btn-danger">삭제</button>
						<button data-oper="cancel" class="btn btn-secondary">취소</button>					
					</div>

				</div>
			</div>
			<input type="hidden" name="pageNum" value="${cri.pageNum }" >
			<input type="hidden" name="type" value="${cri.type }">
			<input type="hidden" name="keyword" value="${cri.keyword }">
		</form>
	</div>


</body>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "/resources/smarteditor/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	var form = $("form");
	$("button").on("click", function(e){
		e.preventDefault();
		var oper = $(this).data("oper");
		
		if(oper === 'submit'){
			
			var str = "";
			$(".uploadResult ul li").each(function(i, obj){
				var obj = $(obj);
				
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+obj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+obj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+obj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+obj.data("type")+"'>";
			});
			form.append(str);
			submitContents(e);
			return;
		}
		if(oper === 'delete'){
			form.attr("action", "/board/delete").submit();
			return;
		}
		if(oper === 'cancel'){
			var pageNumTag = form.find("input[name='pageNum']").clone();
			var typeTag = form.find("input[name='type']").clone();
			var keywordTag = form.find("input[name='keyword']").clone();
			form.attr("action", "/board/list").attr("method", "get");
			
			form.empty();
			form.append(pageNumTag);
			form.append(typeTag);
			form.append(keywordTag);
			form.submit();
			return;
		}
		
	});
	
	
	function submitContents(e){
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		 try {
			 form.submit();
		 } catch(e) {}
	}
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	var board_id = '<c:out value="${board.id}" />';
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	
	$.getJSON("/board/getAttachList", {board_id : board_id}, function(arr){
		
		var str ="";
		
		$(arr).each(function(i, obj){
			
			if(obj.fileType){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var originalPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
				str += "	<div>";
				str += "		<img src='/display?fileName="+fileCallPath+"'>";
				str += "	</div>";
				str += "	<div>";
				str += "		<span><a href='/download?fileName="+originalPath+"'><small>"+obj.fileName+"</small></a></span>";
				str += "		<button type='button' data-file='"+fileCallPath+"' data-type='image'><i class='fas fa-times-circle'></i></button>";
				str += "	</div>";
				str += "</li>";
			}
			else{
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
				str += "	<div>";
				str += "		<i class='fas fa-paperclip'></i>";
				str += "	</div>";
				str += "	<div>";
				str += "		<span><a href='/download?fileName="+fileCallPath+"'><small>"+obj.fileName+"</small></a></span>";
				str += "		<button type='button' data-file='"+fileCallPath+"' data-type='file'><i class='fas fa-times-circle'></i></button>";
				str += "	</div>";
				str += "</li>";		
			}
		});
		
		$(".uploadResult ul").html(str);
	});
	
// 	$("#file-upload-button").on("click", function(e){
// 		console.log("click");
// 		var cloneUploadDiv = $(".uploadDiv").clone();
// 		$(".uploadDiv").html(cloneUploadDiv.html());
// 	});
	
	$("input[type='file']").change(function(e){

		var formData = new FormData();
		var inputFile = $("input[type='file']");
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'post',
			dataType: 'json',
			success: function(result){
				console.log(result);
	 			showuploadedFile(result);
				
	 			
			}
		});
	});
	
	$(".uploadResult").on("click", "button", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		if(confirm("파일을 삭제하시겠습니까?")){
			targetLi.remove();
		}
		
// 		$.ajax({
// 			url: '/deleteFile',
// 			data: {fileName: targetFile, type: type},
// 			dataType: 'text',
// 			type: 'post',
// 			success: function(result){
// 				targetLi.remove();
// 			}
// 		});
	});
	
	function showuploadedFile(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
		
		var uploadResult = $(".uploadResult ul");
		var str ="";
		
		$(uploadResultArr).each(function(i, obj){
			if(obj.fileType){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+"s_"+obj.uuid+"_"+obj.fileName);
				var originalPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
				str += "	<div>";
				str += "		<img src='/display?fileName="+fileCallPath+"'>";
				str += "	</div>";
				str += "	<div>";
				str += "		<span><a href='/download?fileName="+originalPath+"'><small>"+obj.fileName+"</small></a></span>";
				str += "		<button type='button' data-file='"+fileCallPath+"' data-type='image'><i class='fas fa-times-circle'></i></button>";
				str += "	</div>";
				str += "</li>";
			}
			else{
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				str += "<li data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>";
				str += "	<div>";
				str += "		<i class='fas fa-paperclip'></i>";
				str += "	</div>";
				str += "	<div>";
				str += "		<span><a href='/download?fileName="+fileCallPath+"'><small>"+obj.fileName+"</small></a></span>";
				str += "		<button type='button' data-file='"+fileCallPath+"' data-type='file'><i class='fas fa-times-circle'></i></button>";
				str += "	</div>";
				str += "</li>";		
			}
		});
		uploadResult.append(str);
	}	

	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다");
			return false;
		}
		
		return true;
	}
});
</script>
}
</html>