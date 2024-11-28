<%@page import="org.apache.ibatis.annotations.Select"%>
<%@page import="day1113.SelectExam"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<h2>행하나 컬럼하나조회</h2>
	<form name="frm" action="index.jsp">
		<input type="hidden" name="type" value="${param.type}"> <label>부서번호</label>
		<input type="text" name="deptno" /> <input type="submit" value="검색"
			class="btn btn-success btn-sm" />
	</form>
	<div>
		<c:if test="${not empty param.deptno}">
			<%
			try {
				SelectExam se = SelectExam.getInstance();
				int deptno = Integer.parseInt(request.getParameter("deptno"));
				String dname = se.srsc(deptno);
				pageContext.setAttribute("dname", dname);
			%>
			<strong><c:out value="${param.deptno}" /></strong>
			<c:if test="${empty dname }">부서가 존재하지 않습니다.</c:if>
			<c:if test="${ not empty dname }">
			번 부서명은 <c:out value="${dname }" />입니다.
			</c:if>
			<%
			} catch (PersistenceException pe) {

			pe.printStackTrace();

			}
			%>

		</c:if>


	</div>

</div>