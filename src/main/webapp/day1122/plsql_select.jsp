<%@page import="day1122.SelectProcedureVO"%>
<%@page import="day1122.SelectExamService6"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="kr.co.sist.domain.RestDomain"%>
<%@page import="day1114.SelectExam2"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<h2>plsql_delete를 사용한 한 행 검색</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" />
		<h3>사원번호에 해당하는 사원을 검색</h3>
		<label>사원번호</label><input type="text" name="empno" /><br> <input
			type="submit" value="사원 검색" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.empno}">
			<jsp:useBean id="spVO" class="day1122.SelectProcedureVO" scope="page" />
			<jsp:setProperty property="*" name="spVO" />

			<%
			SelectExamService6 ses6 = SelectExamService6.getInstance();

			ses6.searchOneEmp(spVO);

			pageContext.setAttribute("spVO", spVO);
			%>
			<c:choose>
				<c:when test="${not empty spVO.resultMsg }">
					<c:out value="${spVO.resultMsg }" />
				</c:when>
				<c:otherwise>
					사원정보가 검색되지 않았습니다.
					<c:out value="${spVO.errMsg }" />
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
</div>
