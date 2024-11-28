<%@page import="kr.co.sist.service.WebMemberService"%>
<%@page import="kr.co.sist.domain.WebMemberDomain"%>
<%@page import="day1118.SelectExam3"%>
<%@page import="kr.co.sist.domain.BoardDomain"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>
	<h2>회원 조회</h2>
	<form action="index.jsp">
		<input type="hidden" name="type" value="${param.type }" /> <input
			type="radio" name="role" value="g"
			${empty param.role or param.role eq 'g'?" checked'":"" } />일반 관리자 <input
			type="radio" name="role" value="s"
			${param.role eq 's'?" checked'":"" } />슈퍼 관리자 <input type="submit"
			value="검색" class="btn btn-sm btn-primary" />
	</form>

	<div>

		<%
		try {
			String role = request.getParameter("role");

			List<WebMemberDomain> memberList = null;

			SelectExam3 se3 = SelectExam3.getInstance();

			WebMemberService wms = WebMemberService.getInstance();

			memberList = wms.searchWebMember(role);

			pageContext.setAttribute("list", memberList);
		%>
		<table class="table table-hover">
			<thead>
				<tr>
					<td style="width: 80px;">번호</td>
					<td style="width: 120px;">아이디</td>
					<td style="width: 100px;">이름</td>
					<td style="width: 150px;">전화번호</td>
					<td style="width: 250px;">이메일</td>
					<td style="width: 200px;">주소</td>
					<td style="width: 100px;">상세주소</td>
					<td style="width: 100px;">관심언어</td>
				</tr>

			</thead>
			<tbody>

				<c:if test="${empty list }">
					<tr>
						<td colspan="5">검색된 회원정보가 존재하지 않습니다.</td>
					</tr>

				</c:if>
				<c:forEach var="wmd" items="${list}" varStatus="i">

					<tr>
						<td><c:out value="${i.count }" /></td>
						<td><input type="text" name="idArr" value="${wmd.id }" /></td>
						<td><input type="text" name="nameArr" value="${wmd.name }" /></td>
						<td><input type="text" name="telArr" value="${wmd.tel }" /></td>
						<td><input type="text" name="emailArr" value="${wmd.email }" /></td>
						<td><input type="text" name="addrArr" value="${wmd.addr }" /></td>
						<td><input type="text" name="addr2Arr" value="${wmd.addr2 }" /></td>
						<td><input type="text" name="LangArr" value="${wmd.lang }" /></td>
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