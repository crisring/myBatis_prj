<%@page import="kr.co.sist.domain.CpEmpDomain"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="day1122.SelectExamService6"%>
<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="kr.co.sist.domain.RestDomain"%>
<%@page import="day1114.SelectExam2"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<h2>Cursor를 사용한 부서별 사원조회</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${ param.type }" /> <label>부서번호</label>
		<input type="text" name="deptno" /> <input type="submit" value="사원조회"
			class="btn btn-primary btn-sm" />
	</form>
	<div>
		<c:if test="${ not empty param.deptno }">
			<%
			try {
				String deptno = request.getParameter("deptno");
				List<CpEmpDomain> empList = null;
				SelectExamService6 se6 = SelectExamService6.getInstance();

				String title = deptno + "번 부서 사원 검색";
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("deptno", Integer.parseInt(deptno));

				empList = se6.searchEmpDept(map);

				pageContext.setAttribute("list", empList);
				pageContext.setAttribute("title", title);
			%>
			<h3>
				<c:out value="${ title }" />
			</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<td style="width: 80px">번호</td>
						<td style="width: 100px">사원번호</td>
						<td style="width: 150px">사원명</td>
						<td style="width: 120px">연봉</td>
						<td style="width: 120px">입사일</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${ empty list }">
						<tr>
							<td colspan="5">검색된 사원이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="ed" items="${ list }" varStatus="i">
						<tr>
							<td><c:out value="${ i.count }" /></td>
							<td><c:out value="${ ed.empno }" /></td>
							<td><c:out value="${ ed.ename }" /></td>
							<td><fmt:formatNumber pattern="#,###" value="${ ed.sal }" />
							</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${ ed.hiredate }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%
			} catch (PersistenceException pe) {
			pe.printStackTrace();
			%>
		검색 실패 문제 발생
		<%
			} //end catch
			%>
		</c:if>
	</div>

</div>