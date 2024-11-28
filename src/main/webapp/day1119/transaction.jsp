<%@page import="day1119.SelectExam4"%>
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
	<h2>Transaction의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label
			for="name">이름</label> <input type="text" name="name" /><br> <label
			for="addr">주소</label> <input type="text" name="addr" /><br> <input
			type="submit" value="입력" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.name}">

			<jsp:useBean id="tVO" class="kr.co.sist.vo.TransactionVO"
				scope="page" />
			<jsp:setProperty property="*" name="tVO" />

			<%
			boolean flag = false;
			try {
				String tableName = request.getParameter("tableName");

				flag = SelectExam4.getInstance().transaction(tVO);

			} catch (PersistenceException pe) {
				pe.printStackTrace();
			}

			pageContext.setAttribute("flag", flag);
			%>

			<strong><c:out value="${param.name}" /></strong>
			<c:choose>
				<c:when test="${flag }">
				 정보가 추가되었습니다.
				</c:when>
				<c:otherwise>
				정보가 정상적으로 추가되지 않았습니다.
				</c:otherwise>
			</c:choose>

		</c:if>
	</div>
</div>
