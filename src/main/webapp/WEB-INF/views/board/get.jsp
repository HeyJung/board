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

<style>
.container{
	margin-top: 30px;
}
.card{
	margin-bottom: 30px;
}
.top{

}
.title{
	font-size: 30px;
}
.top p{
	margin: 0px;
}
.info{
	position: relative;
}
.writer{
	font-size: 15px;
	font-weight: bold;
}
.date{
	font-size: 12px;
	color: #6E6E6E;
}
.view{
	font-size: 12px;
	color: #6E6E6E;
	position: absolute;
	left: 100px;
	top: 23px;
}
.cmt-cnt{
	font-size: 14px;
	font-weight: bold;	
	position: absolute;
	right: 3px;
	bottom: 3px;
}

.body{
	min-height: 300px;
}
.button-div{
	margin-top: 20px;
	margin-bottom: 30px;
}
.chat{
	
}
.chat li{
	padding: 10px;
	border-bottom: 1px solid #BDBDBD;
	position:relative;
}
.cmt-header{
	display: flex;
}
.cmt{
	
}
.re-cmt{
	background: #FAFAFA;
	display: flex;
	
}
.re-cmt-visual{
	width: 70px;
}
.cmt-update{
	position:absolute;
	left: 750px;
}
.cmt-delete{
	position:absolute;
	left: 790px;
}
.cmt-date{
	color:#6E6E6E;
	font-size: 13px;
	margin-bottom: 10px;
}
.chat-write{
	width: 850px;
	margin-left: auto;
	border: 1px solid #BDBDBD;
	padding: 20px;
}
.chat-write div{
	display: flex;
}
.chat-write button{
	margin-top: 3px;
	position: relative;
	left: 760px;
}

textarea{
	resize: none;
}
.uploadResult{
	display: flex;
	align-items: center;
}
.uploadResult p{
	margin-right: 20px;
}
.uploadResult ul{
	display: flex;
	margin: 0px;
	padding: 0px;
}
.uploadResult li{
	margin-right: 15px;
}
.uploadResult li:hover{
	color:orange;
	cursor:pointer;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<div class="top">
					<p class="title">
						${board.title }
					</p>
					<div class="info">
						<p class="writer">${board.writer_id }</p>
						<p class="date"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${board.date }"/></p>
						<p class="view">조회 ${board.view }</p>
						<p class="cmt-cnt">댓글 개수</p>
					</div>
					<div class="uploadResult">
						<p><small>첨부파일</small></p>
						<ul>

						</ul>
					</div>
				</div>
				<hr/>
				<div class="body">
					${board.content }
				</div>
				<hr/>
				<div class="button-div">
					<button data-oper="list" class="btn btn-info btn-sm">목록</button>
					<button data-oper="update" class="btn btn-secondary btn-sm">수정</button>					
				</div>
				<div class="bottom">
					<ul class="chat">
						<input id="loginId" type="hidden" name="writer_id" value="${user }" />
						<li>
							<div class="cmt-header">
								<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>
								<p><strong>user01</strong></p>
								<a class="cmt-update" href="#"><small>수정</small></a>
								<a class="cmt-delete" href="#"><small>삭제</small></a>
							</div>
							<p class="cmt">댓글이에요!</p>
							<p class="cmt-date">2020.7.4 22:19</p>
							<button type="button" class="btn btn-outline-secondary btn-sm">답글</button>
						</li>
						<li class="re-cmt">
							<div class="re-cmt-visual">
								<i class="fas fa-reply fa-rotate-180"></i>
							</div>
							<div>
								<div class="cmt-header">
									<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>
									<p><strong>user01</strong></p>
									<a class="cmt-update" href="#"><small>수정</small></a>
									<a class="cmt-delete" href="#"><small>삭제</small></a>
								</div>
								<p class="cmt">대댓글이에요!</p>
								<p class="cmt-date">2020.7.4 22:19</p>
								<button type="button" class="btn btn-outline-secondary btn-sm">답글</button>							
							</div>
						</li>						
					</ul>
					<div class="chat-paging">
						
					</div>
					<div class="chat-write">
						<div>
							<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>
							<c:if test="${user == null }"><p><strong>로그인을 해주세요</strong></p></c:if>
							<c:if test="${user != null }"><p><strong>${user }</strong></p></c:if>						
						</div>
						<textarea class="form-control" name="cmt" rows="3" placeholder="댓글을 작성해주세요"></textarea>
						<button id="cmtinsert-btn" type="button" class="btn btn-outline-primary btn-sm">등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<form action="update" method="get">
	<input type="hidden" name="id" value="${board.id }">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
	
</form>

</body>
<script type="text/javascript" src="/resources/js/cmt.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("button").on("click", function(e){
		e.preventDefault();
		var oper = $(this).data("oper");
		var form = $("form");
		if(oper === 'list'){
			form.find("input[name='id']").remove();
			form.attr("action", "/board/list");
			form.submit();
			return;
		}
		if(oper === 'update'){
			form.submit();
			return;
		}
	});
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	var board_id = '<c:out value="${board.id}"/>';
	var cmtUl = $(".chat");
	var pageNum = 1;
	var chatPaging = $(".chat-paging");
	var loginId = $("#loginId").val();
	showList(1);
	
	/* 댓글 작성 버튼 */
	$("#cmtinsert-btn").on("click", function(e){
		if(!checkLogin()){return false;}
		var cmt = {
				board_id: board_id, depth : 0, bundle_order:0, writer_id: loginId, 
				cmt : $(".chat-write textarea").val()
		}
	 	cmtService.add(cmt, function(result){
	 		alert(result);
	 		$(".chat-write textarea").val("");
	 		
	 		showList(-1);
	 	});
	});
	
	/* 수정/삭제 버튼 */
	cmtUl.on("click", "a", function(e){
		e.preventDefault();
		
		//로그인 확인 & 작성자 확인
		if(!checkLogin()){return false;}
		var writer_id = $(this).siblings("p").text();
	
		var cmtLi = $(this).closest("li");
		var id = $(this).closest("li").data("id");
		var oper = $(this).data("oper");
		
		//수정화면
		if(oper === 'change'){
			if(!checkWriter(writer_id)){return false;}
			changeUpdate(id, cmtLi);
		}
		//삭제
		else if(oper === 'delete'){
			if(!checkWriter(writer_id)){return false;}
			cmtService.remove(id, function(result){
				alert(result);
				showList(pageNum);
			});
		}
		//수정
		else if(oper === 'update'){
			writer_id = $(this).siblings("div").children("p").text();
			if(!checkWriter(writer_id)){return false;}
			var cmt = {id:id, cmt:$(".chat-rewrite textarea").val(), updated_date: new Date()}
			cmtService.update(cmt, function(result){
				alert(result);
				showList(pageNum);
			});
		}
		//답글 요청
		else if(oper === 're-cmtinsert-btn'){
			var prevLi = $(this).closest("li").prev();
			var bundle_id = prevLi.data("bundle");
			var cmt = {
					board_id: board_id, depth : 1, bundle_id:bundle_id, bundle_order: new Date().getTime(), 
					writer_id: loginId, cmt : $(".chat-write textarea").val()
			}

		 	cmtService.add(cmt, function(result){
		 		alert(result);
		 		
		 		showList(pageNum);
		 	});
		}
	});
	
	/* 답글버튼 */
	cmtUl.on("click", "button", function(e){
		if(!checkLogin()){return false;}
		var parents = $(this).closest("li");
		var str = "";
		
		str += '<li class="re-cmt">';
		str += '	<div class="re-cmt-visual">';
		str += '		<i class="fas fa-reply fa-rotate-180"></i>';
		str += '	</div>';		
		str += '	<div class="chat-write">';
		str += '		<div>';
		str += '			<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>';
		str += '			<p><strong>'+loginId+'</strong></p>';
		str += '		</div>';
		str += '		<textarea class="form-control" name="cmt" rows="3" placeholder="댓글을 작성해주세요"></textarea>';
		str += '		<a data-oper="re-cmtinsert-btn" type="button" class="btn btn-outline-primary btn-sm">등록</a>';
		str += '	</div>';
		str += '</li>';
		parents.after(str);
		
	});
	
	
	/* 댓글 페이징 */
	chatPaging.on("click", "li a", function(e){
		e.preventDefault();
		
		var targetPage = $(this).attr("href");
		pageNum = targetPage;
		showList(pageNum);
	});
	
	function showList(page){

		cmtService.getList({board_id:board_id, page: page||1}, function(data){
			var str = "";
			var list = data.list;
			var cmtCount = data.cmtCount;
			
			if(cmtCount == null || cmtCount === ""){cmtCount = 0;}
			$(".cmt-cnt").text("댓글  "+cmtCount+"개");
			if(list == null || list.length == 0){cmtUl.html("등록된 댓글이 없습니다."); return;}
			
			if(page == -1){
				pageNum = Math.ceil(cmtCount/10.0); //마지막페이지
			}
			
			for(var i=0, len=list.length || 0; i<len; i++){

				if(list[i].depth === 1){
				str += '<li class="re-cmt" data-id="'+list[i].id+'" data-bundle="'+list[i].bundle_id+'">';
				str += '	<div class="re-cmt-visual">';
				str += '		<i class="fas fa-reply fa-rotate-180"></i>';
				str += '	</div>';
				str += '	<div>';					
				}
				else{
				str += '<li data-id="'+list[i].id+'" data-bundle="'+list[i].bundle_id+'">';	
				}
				str += '	<div class="cmt-header">';
				str += '		<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>';
				str += '		<p><strong>'+list[i].writer_id+'</strong></p>';
				
				if(list[i]._deleted === true){
				str += '	</div>';
				str += '	<p class="cmt" style="color:#F78181;">삭제된 댓글입니다</p>';
				str += '	<p class="cmt-date"></p>';
				}
				else{
				str += '		<a class="cmt-update" href="#" data-oper="change"><small>수정</small></a>';
				str += '		<a class="cmt-delete" href="#" data-oper="delete"><small>삭제</small></a>';
				str += '	</div>';
				str += '	<p class="cmt">'+list[i].cmt+'</p>';	
					if(list[i].updated_date == null){
					str += '	<p class="cmt-date">'+cmtService.displayTime(list[i].created_date)+'</p>';	
					}
					else{
					str += '	<p class="cmt-date">'+cmtService.displayTime(list[i].updated_date)+' (수정됨)</p>';						
					}
				str += '	<button type="button" class="btn btn-outline-secondary btn-sm">답글</button>';
				}
				
				if(list[i].depth === 1){
				str += '	</div>';	
				str += '</li>';	
				}
				else{
				str += '</li>';	
				}
			}

			cmtUl.html(str);
			showCmtPage(cmtCount);
		});
	}
	
	/* 댓글 수정 화면 전환 */
	function changeUpdate(id, li){
		var str = "";
		
		cmtService.get(id, function(result){
			str += '<div class="chat-rewrite">';
			str += '	<div>';
			str += '		<span style="color: Mediumslateblue;"><i class="fab fa-grav fa-lg"></i></span>';
			str += '		<p><strong>'+result.writer_id+'</strong></p>';
			str += '	</div>';
			str += '	<textarea class="form-control" name="cmt" rows="3" placeholder="댓글을 작성해주세요">'+result.cmt+'</textarea>';
			str += '	<a data-oper="update" type="button" class="btn btn-outline-primary btn-sm">등록</a>';
			str += '</div>';
			
			li.html(str);
		});
	}
	
	function showCmtPage(cmtCount){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= cmtCount){
			endNum = Math.ceil(cmtCount/10.0);
		}
		else if(endNum * 10 < cmtCount){
			next = true;
		}
		
		var str = "<ul class='pagination justify-content-center'>";
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'><span aria-hidden='true'>&laquo;</span></a></li>";
		}
		for(var i=startNum; i<=endNum; i++){
			var active = (pageNum == i)? "active" : "";
			str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'><span aria-hidden='true'>&raquo;</span></a></li>";
		}		
		str += "</ul></div>";
		
		chatPaging.html(str);
	}
	
	/* 로그인 확인 */
	function checkLogin(){
		if(loginId == null || loginId == ""){
			alert("로그인 후 이용 가능합니다");
			return false;
		}
		return true;
	}
	/* 작성자 확인 */
	function checkWriter(writer_id){
		if(loginId != writer_id){
			alert("작성자만 수정 가능합니다");
			return false
		}
		return true;
	}
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	var board_id = '<c:out value="${board.id}"/>';
	
	$.getJSON("/board/getAttachList", {board_id : board_id}, function(arr){
		console.log(arr);
		
		var str="";
		
		$(arr).each(function(i, attach){
			var fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
			
			str += "<li data-uuid='"+attach.uuid+"' data-path='"+attach.uploadPath+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
			str += "<small><i class='fas fa-paperclip'></i> "+attach.fileName+"</small></li>"
					
			$(".uploadResult ul").html(str);
		});
	});
	
	$(".uploadResult").on("click", "li", function(e){
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		console.log(path);
		self.location = "/download?fileName="+path;

	});
});
</script>
</html>