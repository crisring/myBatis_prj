<%@page import="kr.co.sist.domain.BoardInfoDomain"%>
<%@page import="kr.co.sist.service.WebMemberService"%>
<%@page import="kr.co.sist.domain.WebMemberDomain"%>
<%@page import="day1118.SelectExam3"%>
<%@page import="kr.co.sist.domain.BoardDomain"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<h2>글 조회</h2>

	<div>

		<%
		try {
			String role = "s";

			List<BoardInfoDomain> boardList = null;

			SelectExam3 se3 = SelectExam3.getInstance();

			WebMemberService wms = WebMemberService.getInstance();

			boardList = wms.searchBoardMember(role);

			pageContext.setAttribute("list", boardList);
		%>
		<table class="table table-hover">
			<thead>
				<tr>
					<td style="width: 80px;">번호</td>
					<td style="width: 350px;">제목</td>
					<td style="width: 150px;">아이디/작성자</td>
					<td style="width: 150px;">생년월일</td>
					<td style="width: 60px;">성별</td>
					<td style="width: 150px;">작성일</td>
				</tr>

			</thead>
			<tbody>

				<c:if test="${empty list }">
					<tr>
						<td colspan="5">검색된 게시물이 존재하지 않습니다.</td>
					</tr>

				</c:if>
				<c:forEach var="bid" items="${list}" varStatus="i">

					<tr>
						<td><c:out value="${i.count }" /></td>
						<td><c:out value="${bid.subject }" /></td>
						<td><c:out value="${bid.id }" />/${bid.name }</td>
						<td><c:out value="${bid.birth }" /></td>
						<td><c:out value="${bid.gender }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${bid.input_date }" /></td>
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