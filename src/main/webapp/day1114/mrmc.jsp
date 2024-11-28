<%@page import="day1114.SelectExam2"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<h2>여러 행에 컬럼 하나 조회</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>부서번호</label>
		<input type="text" name="deptno" /><br> <input type="checkbox"
			name="flag" />모든사원검색<br> <input type="submit" value="검색"
			class="btn btn-primary btn-sm" /><br>

	</form>
	<div>

		<c:if test="${not empty param.deptno or not empty param.flag }">
			<%
			try {
				String flag = request.getParameter("flag");
				List<String> enameList = null;

				SelectExam2 se2 = SelectExam2.getInstance();

				String title = "모든 사원 검색";
				// null 인 경우 부서번호 검색
				if (flag == null) {
					String deptno = request.getParameter("deptno");
					title = deptno + "번 부서 사원 검색";

					enameList = se2.mrsc(Integer.parseInt(deptno));

				} else {

					enameList = se2.mrsc2();
				}

				pageContext.setAttribute("list", enameList);
				pageContext.setAttribute("title", title);
			%>
			<h3>
				<c:out value="${title }" />
			</h3>
			<table>
				<c:forEach var="ename" items="${list}" varStatus="i">

					<tr>
						<td><c:out value="${i.count }" /></td>
						<td><input type="text" value="${ename }" /></td>
					</tr>
				</c:forEach>
			</table>

			<%
			} catch (PersistenceException pe) {
			pe.printStackTrace();
			%>
				검색 중 문제가 발생했습니다.
			<%
			}
			%>
		</c:if>

	</div>


</div>