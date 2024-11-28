<%@page import="kr.co.sist.domain.BoardDomain"%>
<%@page import="day1114.SelectExam2"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<h2>like 조회</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>제목</label>
		<input type="text" name="subject" /><br> <input type="submit"
			value="포함된 제목 검색" class="btn btn-primary btn-sm" /><br>

	</form>
	<div>

		<c:if test="${not empty param.subject}">
			<%
			try {
				String subject = request.getParameter("subject");
				List<BoardDomain> boardList = null;

				SelectExam2 se2 = SelectExam2.getInstance();

				String title = subject + " 을 포함한 제목 검색";

				boardList = se2.like(subject);

				pageContext.setAttribute("list", boardList);
				pageContext.setAttribute("title", title);
			%>
			<h3>
				<c:out value="${title }" />
			</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<td style="width: 80px;">번호</td>
						<td style="width: 350px;">제목</td>
						<td style="width: 180px;">작성자/ip</td>
						<td style="width: 120px;">입력일</td>
					</tr>

				</thead>
				<tbody>

					<c:if test="${empty list }">
						<tr>
							<td colspan="5">제목으로 검색된 게시물이 없습니다.</td>
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
		</c:if>

	</div>


</div>