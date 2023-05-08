<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset=”UTF-8">
<title>회원 목록 페이지</title>
</head>
<body>
	<h3 align="center">회원목록</h3>
	<p align="right"><a href="${contextPath}/member/memberInsertForm.jsp">회원등록</a></p>
	
	<table style="align:center;" border="1" >
		<tr align="center" bgcolor="lightgreen">
			<td width="7%"><b>아이디</b></td>
			<td width="7%"><b>비밀번호</b></td>
			<td width="7%"><b>이름</b></td>
			<td width="7%"><b>이메일</b></td>
			<td width="7%"><b>가입일</b></td>
			<td width="7%"><b>수정</b></td>
			<td width="7%"><b>삭제</b></td>
		</tr>
		<c:choose>
			<c:when test="${ empty memberList}">
				<tr>
					<td colspan=7>등록된 회원이 없습니다.</td>
				</tr>
			</c:when>
			<c:when test="${not empty memberList}">
				<c:forEach var="mem" items="${memberList }">
					<tr align="center">
						<td>${mem.id}</td>
						<td>${mem.pwd}</td>
						<td>${mem.name}</td>
						<td>${mem.email}</td>
						<td>${mem.joinDate}</td>
						<td><a href="${contextPath}/memberModify?id=${mem.id}&pwd=${mem.pwd}&name=${mem.name}&email=${mem.email}">수정</a></td>
						<td><a href="${contextPath}/memberDelete?id=${mem.id}">삭제</a></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
</body>
</html>
