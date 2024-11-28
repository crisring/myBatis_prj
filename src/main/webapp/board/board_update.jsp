<%@page import="kr.co.sist.user.board.BoardService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/jsp/post_chk.jsp"%>

<jsp:useBean id="mbVO" class="kr.co.sist.user.board.MBoardVO"
	scope="page" />
<jsp:setProperty name="mbVO" property="*" />
<%-- setProperty했을 때 글번호, 글제목(필요없음), 내용 3가지를 받는다. --%>
<%
BoardService bs = BoardService.getInstance();

boolean flag = bs.modifyBoard(mbVO);

pageContext.setAttribute("flag", flag); //true, false
%>
<!DOCTYPE html>
<html>
<head>
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

<style type="text/css">
</style>
<script type="text/javascript">
	var msg = "글을 변경하지 못하였습니다. \n 작성자와 비밀번호를 확인해주세요.";

	var flag = $
	{
		flag
	};

	if (flag) {
		msg = "글이 수정되었습니다.";
	}//end if

	alert(msg);

	if (flag) {
		location.href = "board_list.jsp?currentPage=${ param.currentPage }";
	} else {
		history.back();
	}

	$(function() {

	});//ready
</script>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>