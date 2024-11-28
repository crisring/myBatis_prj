<%@page import="kr.co.sist.domain.RestDomain"%>
<%@page import="day1114.SelectExam2"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<h2>여러 행에 컬럼 하나 조회</h2>
	<form action="index.jsp" method="get">
		<input type="hidden" name="type" value="${param.type}" /> <label>아이디</label>
		<input type="text" name="id" /><br> <input type="submit"
			value="등록 음식점 검색" class="btn btn-primary btn-sm" /><br>

	</form>
	<div>

		<c:if test="${not empty param.id }">
			<%
			try {
				String id = request.getParameter("id");
				List<RestDomain> restList = null;

				SelectExam2 se2 = SelectExam2.getInstance();

				String title = "등록한 식당 검색";
				restList = se2.mrmc(id);

				pageContext.setAttribute("list", restList);
				pageContext.setAttribute("title", title);
			%>
			<h3>
				<c:out value="${title }" />
			</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<td style="width: 80px;">번호</td>
						<td style="width: 120px;">식당명</td>
						<td style="width: 120px;">주메뉴</td>
						<td style="width: 300px;">식당정보</td>
						<td style="width: 100px;">입력일</td>
					</tr>

				</thead>
				<tbody>

					<c:if test="${empty list }">
						<tr>
							<td colspan="5">검색된 식당이 없습니다.</td>
						</tr>

					</c:if>
					<c:forEach var="rd" items="${list}" varStatus="i">

						<tr>
							<td><c:out value="${i.count }" /></td>
							<td><input type="text" value="${rd.restaurant }" /></td>
							<td><input type="text" value="${rd.menu }" /></td>
							<td><input type="text" value="${rd.info }" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
									value="${rd.input_date }" /></td>
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