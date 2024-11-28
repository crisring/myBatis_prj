<%@page import="kr.co.sist.user.board.BoardService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/jsp/post_chk.jsp"%>
<jsp:useBean id="mbVO" class="kr.co.sist.user.board.MBoardVO"
	scope="page" />
<%-- 글제목, 글내용, 글번호 가 bVO객체에 입력--%>
<jsp:setProperty name="mbVO" property="*" />
<%
BoardService bs = BoardService.getInstance();

boolean flag = bs.removeBoard(mbVO);

pageContext.setAttribute("flag", flag); //true, false
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon"
	href="http://192.168.10.225/jsp_prj/common/images/favicon.ico" />
<script type="text/javascript">
	var msg = "글을 삭제하지 못하였습니다.";
	var flag = $
	{
		flag
	};

	if (flag) {
		msg = "${param.num}번 글을 삭제하였습니다.";
	}// end if 

	alert(msg);

	if (flag) {
		location.href = "board_list.jsp?currentPage=${param.currentPage}";
	} else {
		history.back();
	}//end else

	$(function() {

	});//ready
</script>
</head>
<body>
</body>
</html>