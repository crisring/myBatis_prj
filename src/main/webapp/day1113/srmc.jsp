<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="org.apache.ibatis.annotations.Select"%>
<%@page import="day1113.SelectExam"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<h2>행하나 컬럼 여러개조회</h2>
	<form name="frm" action="index.jsp">
		<input type="hidden" name="type" value="${param.type}"> <label>사원번호</label>
		<input type="text" name="empno" /> <input type="submit" value="검색"
			class="btn btn-success btn-sm" />
	</form>
	<div>
		<c:if test="${not empty param.empno}">
			<%
			try {
				SelectExam se = SelectExam.getInstance();
				int empno = Integer.parseInt(request.getParameter("empno"));
				EmpDomain ed = se.srmc(empno);
				pageContext.setAttribute("ed", ed);
			%>
			<strong><c:out value="${param.empno}" /></strong>
			<c:if test="${empty ed }">사원이 존재하지 않습니다.</c:if>
			<c:if test="${ not empty ed }">
			번 사원정보 검색 결과<br>
			사원명 : <c:out value="${ed.ename }" />
				<br>
			직무 : <c:out value="${ed.job }" />
				<br>
			연봉 : <fmt:formatNumber pattern="#,###" value="${ed.sal}" />
				<br>
			사원명 : <fmt:formatDate pattern="yyyy-MM-dd" value="${ed.hiredate }" />
				<br>
			</c:if>
			<%
			} catch (PersistenceException pe) {

			pe.printStackTrace();

			}
			%>

		</c:if>


	</div>

</div>