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
	<h2>$의 사용</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>사업부선택</label>
		<input type="radio" name="tableName" value="cp_emp2"
			${param.tableName == 'cp_emp2' ? 'checked="checked"' : ''} />본사<br>
		<input type="radio" name="tableName" value="emp"
			${param.tableName == 'emp' ? 'checked="checked"' : ''} />지사<br>

		<input type="submit" value="사원조회" class="btn btn-primary btn-sm" /><br>
	</form>

	<div>
		<c:if test="${not empty param.tableName}">
			<%
			try {
				String tableName = request.getParameter("tableName");

				List<EmpDomain> empList = SelectExam4.getInstance().dynamicTable(tableName);

				pageContext.setAttribute("list", empList);
			%>

			<h3>
				<c:out value="${param.tableName eq 'cp_emp2' ? '본사':'지사'}" />
				사원 검색 결과
			</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width: 80px">번호</th>
						<th style="width: 100px">사원번호</th>
						<th style="width: 100px">사원명</th>
						<th style="width: 120px">연봉</th>
						<th style="width: 150px">직무</th>
						<th style="width: 120px">입사일</th>
						<th style="width: 120px">부서번호</th>
						<th>입력일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="8">검색된 사원이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="ed" items="${list}" varStatus="i">
						<tr>
							<td><c:out value="${i.count}" /></td>
							<td><c:out value="${ed.empno}" /></td>
							<td><c:out value="${ed.ename}" /></td>
							<td><fmt:formatNumber pattern="0,000,000" value="${ed.sal}" /></td>
							<td><c:out value="${ed.job}" /></td>
							<td><c:out value="${ed.hiredate}" /></td>
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
		</c:if>
	</div>
</div>
