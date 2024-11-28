<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@page import="kr.co.sist.user.board.MBoardDomain"%>
<%@page import="kr.co.sist.user.board.BoardService"%>
<%@page import="kr.co.sist.user.board.BoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
//실제 글의 고유 번호를 받는다.
String tempNum = request.getParameter("num");
int num = 0;
try {
	num = Integer.parseInt(tempNum);
} catch (NumberFormatException nfe) {
	response.sendRedirect("board_list.jsp");
	return;
} //end catch

//입력된 글 번호로 상세조회 수행.
BoardService bs = BoardService.getInstance();

MBoardDomain mbDomain = null;
try {
	mbDomain = bs.searchDetailBoard(num);
} catch (PersistenceException se) {
	se.printStackTrace();
} //catch

pageContext.setAttribute("mbd", mbDomain);
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon"
	href="http://192.168.10.225/jsp_prj/common/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.210/jsp_prj/common/css/main_20240911.css">
<!-- bootstrap CDN 시작-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- include summernote css/js-->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.js"></script>

<style type="text/css">
#replyMenu {
	cursor: pointer;
}

#replyContentDiv {
	display: none
}
</style>
<script type="text/javascript">
if( ${ empty mbd } ){
	alert("글 읽기 도중 문제가 발생했습니다.");
	location.href="board_list.jsp";
}

$(function(){
  $('#content').summernote({
       placeholder: '쓰고 싶은 글을 써 주세요.',
       tabsize: 2,
       height: 240,
       width:490,
       toolbar: [
           ['style', ['style']],
           ['font', ['bold', 'underline', 'clear']],
           ['insert', ['picture']],
           ['view', ['codeview', 'help']]
         ]
     });
	
  
  $("#btnWrite").click(function(){
	  chkNull();
  });//click
  
  $("#btnList").click(function(){
	  
	  var url="../board/board_list.jsp?currentPage=${ param.currentPage }";
	  
	  if(${ not empty param.keyword }){
		  url+="&field=${ param.field}&keyword=${ param.keyword }";
	  }//end if
	  
	  location.href=url;
  });//click
  
  $("#btnUpdate").click(function(){
	  movePage('u')
  });//click
  
  $("#btnDelete").click(function(){
	  movePage('d')
  });//click  
});//ready

function movePage( flag ){
	//<form>태그의 action을 변경 document.폼이름.action="변경할action"
	//<form>태그의 method 변경 document.폼이름.method="변경할요청방식 get|post"
	var action="board_update.jsp";
	var msg="글을 수정하시겠습니까?";
	
	if( flag == 'd'){
		action="board_delete.jsp";
		msg="정말 글을 삭제하시겠습니까?";
	}//end if
	
	if(confirm(msg)){//사용자에게 한번 더 확인을 거친다.
	//폼태그 객체의 action속성을 변경.
	document.readFrm.action=action;
	//변경은 내용이 존재하는지 판단 : summernote <p><br></p>를 가진다.
	
	$("#readFrm").submit(); //form를 전송
	
	}//end if
	
}//movePage


</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<c:import url="http://localhost/jsp_prj/common/jsp/header.jsp" />
		</div>
		<div id="contentDiv">
			<div id="writeFrmDiv">
				<form name="readFrm" id="readFrm" method="post">
					<table>
						<tr>
							<th colspan="2"><h2>글읽기</h2></th>
						</tr>
						<tr>
							<td style="width: 80px">제목</td>
							<td style="width: 500px"><input type="text" name="subject"
								id="subject" value="${ mbd.subject }" style="width: 390px"
								autofocus="autofocus" /></td>
						</tr>
						<tr>
							<td style="width: 80px">내용</td>
							<td><textarea name="content" id="content">${ mbd.content }</textarea>
							</td>
						</tr>
						<tr>
							<td style="width: 80px">작성자</td>
							<td><input type="text" name="writer" id="writer"
								value="${mbd.writer }" /></td>
						</tr>
						<tr>
							<td style="width: 80px">작성일</td>
							<td><fmt:formatDate value="${ mbd.input_date }"
									pattern="yyyy-MM-dd a HH:mm:ss" /></td>
						</tr>
						<tr>
							<td style="width: 80px">ip</td>
							<td><c:out value="${ mbd.ip }" /> <input type="hidden"
								name="num" id="num" value="${ mbd.num }" /> <input
								type="hidden" name="currentPage" value="${ param.currentPage }" /></td>
						</tr>

						<tr>
							<td style="width: 80px">비밀번호</td>
							<td><input type="password" name="pass" id="pass"
								value="${ mbd.pass }" /></td>
						</tr>

						<tr>
							<td colspan="2" style="text-align: center"><input
								type="button" id="btnUpdate" value="글수정"
								class="btn btn-sm btn-success" /> <input type="button"
								id="btnDelete" value="글삭제" class="btn btn-sm btn-warning" /> <input
								type="button" id="btnList" value="리스트"
								class="btn btn-sm btn-info" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>