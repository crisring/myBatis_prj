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
	<h2>plsql_update의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" />
		<h3>사원번호에 해당하는 사원의 직무,연봉,보너스,부서번호를 변경</h3>
		<label>사원번호</label> <input type="text" name="empno" /><br> <label>사원명</label>
		<input type="text" name="ename" /><br> <label>직무</label> <input
			type="text" name="job" /><br> <label>연봉</label> <input
			type="text" name="sal" /><br> <label>보너스</label> <input
			type="text" name="comm" /><br> <label>부서번호</label> <input
			type="text" name="deptno" /><br> <input type="submit"
			value="사원 변경" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.empno}">
			<jsp:useBean id="ce2VO" class="day1122.CpEmp2VO" scope="page" />
			<jsp:setProperty property="*" name="ce2VO" />

			<%
			SelectExamService6 ses6 = SelectExamService6.getInstance();

			ses6.modifyEmp(ce2VO);

			pageContext.setAttribute("ce2VO", ce2VO);
			%>
			<c:choose>
				<c:when test="${ce2VO.cnt ne 0 }">
					<c:out value="${ce2VO.ename }" />사원의 정보가 변경되었습니다. <br>
				</c:when>
				<c:otherwise>
					사원정보가 변경되지 않았습니다.
					<c:out value="${ce2VO.msg }" />
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
</div>
