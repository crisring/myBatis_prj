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

<!-- hidden form  -->
<form action="index.jsp" method="get" name="hidFrm" id="hidFrm">
	<input type="hidden" name="type" value="${param.type}" /> <input
		type="hidden" name="empno" id="empno" />
</form>

<script type="text/javascript">
	function searchOneEmp(empno) {
		$('#empno').val(empno);
		$('#hidFrm').submit();
	}
</script>


<div>
	<h2>OGNL - set의 사용</h2>
	<%
	SelectExamService ses = SelectExamService.getInstance();
	pageContext.setAttribute("empnoList", ses.searchAllEmpno());
	%>
	<div>
		<c:forEach var="empno" items="${empnoList}">
			<a href="javascript:searchOneEmp(${empno })"><c:out
					value="${empno }" /></a>
		</c:forEach>
	</div>

	<c:if test="${not empty param.empno }">
		<div>
			<%
			String paramEmpno = request.getParameter("empno");
			pageContext.setAttribute("ed", ses.selectOneEmp(paramEmpno));
			%>
			<c:choose>
				<c:when test="${empty ed }">사원이 존재하지 않습니다.</c:when>

				<c:otherwise>
					<h2>
						<c:out value="${param.empno }" />
						번 사원 정보
					</h2>
					<form action="index.jsp" method="post">
						<input type="hidden" name="type" value="${param.type }"> <input
							type="hidden" name="type2" value="empModify">

						<table>
							<tr>
								<td>사원번호</td>
								<td><c:out value="${param.empno }" /><input type="hidden"
									name="empno" value="${param.empno }" /></td>
							</tr>
							<tr>
								<td>사원명</td>
								<td><input type="text" name="ename" value="${ed.ename }" /></td>
							</tr>
							<tr>
								<td>직무</td>
								<td><input type="text" name="job" value="${ed.job }" /></td>
							</tr>
							<tr>
								<td>매니저번호</td>
								<td><input type="text" name="mgr" value="${ed.mgr }" /></td>
							</tr>
							<tr>
								<td>연봉</td>
								<td><input type="text" name="sal"
									value="<fmt:formatNumber pattern='####' value='${ed.sal }'/>" /></td>
							</tr>
							<tr>
								<td>보너스</td>
								<td><input type="text" name="comm"
									value="<fmt:formatNumber pattern='####' value='${ed.comm }'/>" /></td>
							</tr>
							<tr>
								<td>부서번호</td>
								<td><input type="text" name="deptno" value="${ed.deptno }" /></td>
							</tr>
							<tr>
								<td><input type="submit" name="btnSubmit" value="사원정보 변경"
									class="btn btn-primary btn-sm" /></td>
							</tr>
						</table>
					</form>
				</c:otherwise>
			</c:choose>
		</div>

		<c:if test="${not empty param.type2 }">

			<jsp:useBean id="eVO" class="kr.co.sist.vo.EmpVO" scope="page" />
			<jsp:setProperty property="*" name="eVO" />

			<%
			boolean flag = ses.modifyEmp(eVO);
			%>

			<script type="text/javascript">
			
			const message = "<%=flag ? "사원정보가 변경되었습니다." : "사원정보가 변경되지 않았습니다."%>
				";
				alert(message);
			</script>

		</c:if>

	</c:if>


</div>

