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
	<h2>OGNL - foreach의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>부서번호</label>
		<input type="text" name="deptno"><br> <label>직무</label> <input
			type="checkbox" name="job" value="SALESMAN" />SALESMAN <input
			type="checkbox" name="job" value="MANAGER" />MANAGER <input
			type="checkbox" name="job" value="PRESIDENT" />PRESIDENT <input
			type="checkbox" name="job" value="ANALYST" />ANALYST <input
			type="checkbox" name="job" value="CLERK" />"CLERK" <input
			type="submit" value="부서별 직무에 해당하는 사원 조회"
			class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.deptno }">

			<%
			String deptno = request.getParameter("deptno");
			String[] jobArr = request.getParameterValues("job");

			List<EmpDomain> empList = null;
			SelectExamService ses = SelectExamService.getInstance();

			empList = ses.searchMap(deptno, jobArr);

			pageContext.setAttribute("list", empList);
			%>

			<h3>
				<c:out value="${param.deptno }" />
				번부서의
				<c:forEach var="job" items="${param.job }">
					<c:out value="${job }" />

				</c:forEach>
			</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width: 80px">번호</th>
						<th style="width: 100px">사원번호</th>
						<th style="width: 150px">사원명</th>
						<th style="width: 120px">직무</th>
						<th style="width: 80px">매니저번호</th>
						<th style="width: 80px">연봉</th>
						<th style="width: 120px">입사일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7">검색된 사원이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="ed" items="${list}" varStatus="i">
						<tr>
							<td><c:out value="${i.count}" /></td>
							<td><c:out value="${ed.empno}" /></td>
							<td><c:out value="${ed.ename}" /></td>
							<td><c:out value="${ed.job}" /></td>
							<td><c:out value="${ed.mgr}" /></td>
							<td><fmt:formatNumber pattern="0,000" value="${ed.sal}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${ed.hiredate }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</div>
