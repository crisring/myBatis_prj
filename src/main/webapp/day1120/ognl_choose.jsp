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
	<h2>OGNL - choose의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>부서번호</label>
		<input type="radio" name="deptno" value="1" />SI개발부 <input
			type="radio" name="deptno" value="2" />R&D <input type="radio"
			name="deptno" value="3" />영업부 <br> <input type="submit"
			value="부서별사원 조회" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.deptno }">

			<%
			String deptno = request.getParameter("deptno");

			List<EmpDomain> empList = null;
			SelectExamService ses = SelectExamService.getInstance();

			empList = ses.searchDeptEmp(deptno);

			pageContext.setAttribute("list", empList);
			%>

			<h3>
				<c:choose>
					<c:when test="${empty param.deptno }">
				모든 부서 사원 검색
				</c:when>
					<c:otherwise>
						<%
						String[] dname = { "SI개발", "R&D", "영업부" };
						%>
						<%=dname[Integer.parseInt(deptno) - 1]%> 부서 사원 검색
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
		</c:if>
	</div>
</div>
