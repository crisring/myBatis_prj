<%@page import="day1120.SelectExamService"%>
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
	<h2>OGNL - if의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>부서번호</label>
		<input type="text" id="deptno" name="deptno" title="숫자만 입력해주세요." /><br>
		<input type="submit" value="부서별사원 조회" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<%
		try {
			String deptno = request.getParameter("deptno");

			List<EmpDomain> empList = null;
			SelectExamService ses = SelectExamService.getInstance();

			empList = ses.searchEmp(deptno);

			pageContext.setAttribute("list", empList);
		%>

		<h3>
			<c:choose>
				<c:when test="${empty param.deptno }">
				모든 부서 사원 검색
				</c:when>
				<c:otherwise>
					<c:out value="${param.deptno }" />번 부서 사원 검색
				</c:otherwise>

			</c:choose>
		</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 80px">번호</th>
					<th style="width: 100px">사원번호</th>
					<th style="width: 150px">사원명</th>
					<th style="width: 120px">연봉</th>
					<th style="width: 80px">매니저번호</th>
					<th style="width: 80px">부서번호</th>
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
						<td><fmt:formatNumber pattern="0,000" value="${ed.sal}" /></td>
						<td><c:out value="${ed.mgr}" /></td>
						<td><c:out value="${ed.deptno}" /></td>
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
