<%@page import="day1118.SelectExam3"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="kr.co.sist.domain.RestDomain"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<h2>union 조회</h2>

	<div>
		<%
		try {
			List<EmpDomain> empList = SelectExam3.getInstance().union();

			pageContext.setAttribute("list", empList);
		%>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>연봉</th>
					<th>직무</th>
					<th>입력일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="6">검색된 사원이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="ed" items="${list}" varStatus="i">
					<tr>
						<td><c:out value="${i.count}" /></td>
						<td><c:out value="${ed.empno}" /></td>
						<td><c:out value="${ed.ename}" /></td>
						<td><fmt:formatNumber pattern="###,###" value="${ed.sal}" /></td>
						<td><c:out value="${ed.job}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd EEEE"
								value="${ed.hiredate }" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%
		} catch (PersistenceException pe) {
		%><div>검색 중 문제가 발생했습니다.</div>
		<%
		}
		%>
	</div>
</div>
