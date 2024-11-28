<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.sist.vo.UrlVO"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon"
	href="http://192.168.10.219/jsp_prj/common/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.219/jsp_prj/common/css/main_20240911.css">
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
<!-- bootstrap CDN 끝-->

<style type="text/css">
</style>
<!-- jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {

	}); // document.ready
</script>
</head>
<body>
	<div id="wrap">
		<%
		List<UrlVO> list = new ArrayList<UrlVO>();
		list.add(new UrlVO("행하나 컬럼하나 조회", "day1113/srsc"));
		list.add(new UrlVO("행하나 컬럼 여러개 조회", "day1113/srmc"));
		list.add(new UrlVO("행여러개 컬럼하나 조회", "day1114/mrsc"));
		list.add(new UrlVO("행여러개 컬럼여러개 조회", "day1114/mrmc"));
		list.add(new UrlVO("작은 값조회", "day1114/lessThan"));
		list.add(new UrlVO("큰 값조회", "day1114/greaterThan"));
		list.add(new UrlVO("like 조회", "day1114/like"));
		list.add(new UrlVO("subquery조회", "day1118/subquery"));
		list.add(new UrlVO("union조회", "day1118/union"));
		list.add(new UrlVO("join조회", "day1118/join"));
		list.add(new UrlVO("join&amp;subquery조회", "day1118/join_subquery"));
		list.add(new UrlVO("테이블명이 동적일때", "day1119/dynamicTable"));
		list.add(new UrlVO("transaction", "day1119/transaction"));
		list.add(new UrlVO("OGNL if조회", "day1120/ognl_if"));
		list.add(new UrlVO("OGNL if조회2", "day1120/ognl_if2"));
		list.add(new UrlVO("OGNL choose조회", "day1120/ognl_choose"));
		list.add(new UrlVO("OGNL foreach조회", "day1120/ognl_foreach"));
		list.add(new UrlVO("OGNL set조회", "day1120/ognl_set"));
		list.add(new UrlVO("dynamic query조회", "board/board_list.jsp"));
		list.add(new UrlVO("PLSQL insert", "day1122/plsql_insert"));
		list.add(new UrlVO("PLSQL update", "day1122/plsql_update"));
		list.add(new UrlVO("PLSQL delete", "day1122/plsql_delete"));
		list.add(new UrlVO("PLSQL select", "day1122/plsql_select"));
		list.add(new UrlVO("PLSQL select2", "day1122/plsql_select2"));

		pageContext.setAttribute("url_list", list);
		%>
		<div>
			<table>
				<tr>
					<c:forEach var="uVO" items="${url_list }">
						<td><a href="index.jsp?type=${uVO.jspName }"><c:out
									value="${uVO.selectType}" escapeXml="false" /></a></td>
						<td><c:choose>
								<c:when test="${uVO.selectType eq 'dynamic query조회' }">
									<a href="${uVO.jspName }"><c:out value="${ uVO.selectType}" /></a>
								</c:when>
								<c:otherwise>
									<a href="index.jsp"></a>
								</c:otherwise>
							</c:choose></td>

					</c:forEach>
				</tr>
			</table>

			<ul>
				<li><a href="member/join_frm.jsp">회원가입</a></li>
			</ul>



		</div>
		<div>
			<c:if test="${not empty param.type}">
				<c:import url="${param.type}.jsp" />
			</c:if>
		</div>



	</div>
</body>
</html>