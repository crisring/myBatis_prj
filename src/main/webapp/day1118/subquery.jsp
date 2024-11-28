<%@page import="day1118.SelectExam3"%>
<%@page import="kr.co.sist.domain.BoardDomain"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<h2>like 조회</h2>

	<div>

		<%
		try {
			List<BoardDomain> boardList = null;

			SelectExam3 se3 = SelectExam3.getInstance();

			boardList = se3.subquery();

			pageContext.setAttribute("list", boardList);
		%>
		<table class="table table-hover">
			<thead>
				<tr>
					<td style="width: 80px;">번호</td>
					<td style="width: 350px;">제목</td>
					<td style="width: 180px;">작성자/ip</td>
					<td style="width: 120px;">작성일</td>
				</tr>

			</thead>
			<tbody>

				<c:if test="${empty list }">
					<tr>
						<td colspan="5">제목으로 검색된 게시글이 없습니다.</td>
					</tr>

				</c:if>
				<c:forEach var="bd" items="${list}" varStatus="i">

					<tr>
						<td><c:out value="${i.count }" /></td>
						<td><input type="text" value="${bd.subject }" /></td>
						<td><input type="text" value="${bd.writer }(${bd.ip })" /></td>
						<td><input type="text" value="${bd.input_date }" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<%
		} catch (PersistenceException pe) {
		pe.printStackTrace();
		%>
		검색 중 문제가 발생했습니다.
		<%
		}
		%>

	</div>


</div>