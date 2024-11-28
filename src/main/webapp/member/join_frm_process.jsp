<%@page import="kr.co.sist.member.dao.WebMemberService"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="회원 가입 데이터 처리 페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/jsp/post_chk.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon"
	href="http://192.168.10.219/common/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.219/common/css/main_20240911.css">
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
	$(function() {

	});//ready
</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<c:import url="http://localhost/mybatis_prj/common/jsp/header.jsp" />
		</div>
		<jsp:useBean id="wmVO" class="kr.co.sist.member.dao.WebMemberVO"
			scope="page" />
		<jsp:setProperty property="*" name="wmVO" />

		<%
		WebMemberService wms = WebMemberService.getInstance();
		//비연결성의 문제( 한정적인 자원의 사용문제)
		boolean flag = wms.searchIdDup(wmVO.getId());
		if (!flag) {
		%>
		<h2>아이디가 사용중입니다.</h2>
		<strong><c:out value="${ param.id }" /></strong>는 이미 사용 중입니다.<br>
		<a href="javascript:history.back()">뒤로</a>
		<%
		} else {
		if (wms.addWebMember(wmVO, request)) {
		%>
		<h2>${ param.name }님회원가입해주셔서감사합니다.</h2>
		<a href="http://localhost/mybatis_prj/member/join_frm.jsp">로그인
			페이지로</a>
		<%
		} else { //end else
		%>
		회원 가입 중 문제가 발생했습니다.<br> 잠시 후 다시 시도해 주세요. <br> <img
			src="http://localhost/mybatis_prj/member/images/sorry.png"><br>
		<a href="join_frm.jsp">메인화면으로 이동</a>
		<%
		}
		}
		%>
	</div>
</body>
</html>