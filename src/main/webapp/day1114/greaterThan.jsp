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
	<h2>&lt;조회</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>연봉</label>
		<input type="text" id="sal" name="sal" required pattern="\d+"
			title="숫자만 입력해주세요." /><br> <input type="submit"
			value="보다 큰 연봉 조회" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.sal}">
			<%
			try {
				int sal = Integer.parseInt(request.getParameter("sal"));
				List<EmpDomain> empList = SelectExam2.getInstance().greaterThan(sal);

				String title = sal + "보다 연봉이 큰 사원을 검색";
				pageContext.setAttribute("list", empList);
				pageContext.setAttribute("title", title);
			%>

			<h3>
				<c:out value="${title}" />
			</h3>
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
							<td><c:out value="${ed.sal}" /></td>
							<td><c:out value="${ed.job}" /></td>
							<td><c:out value="${ed.hiredateStr}" /></td>
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
		</c:if>
	</div>
</div>
