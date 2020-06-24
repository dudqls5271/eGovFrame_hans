<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script>
	$(document).ready(function() {
		$("tr").click(function() {
			$("#seqno").val($(this).data("id"));
			$("#frm").submit();
		});

		$("#writing").click(function() {
			location.href = '/test/writing.do';
		});
		
		$("#login").click(function() {
			location.href = '/test/login.do';
		});
		
		$("#logout").click(function() {
			location.href = '/test/logout.do';
		});
	});
</script>
</head>
<body>
	<h1>리스트</h1>
	
	<c:if test="${empty sessionScope.sessionId}">
	<input type="button" value="로그인" id="login">
	</c:if>
	
	<c:if test="${not empty sessionScope.sessionId}">
	<h4>${sessionScope.sessionId}님 반갑습니다.</h4>
	<input type="button" value="로그아웃" id="logout">
	<input type="button" value="정보 수정" id="modify">
	</c:if>
	
	<form id="frm" action='/test/view.do'>
		<input type="hidden" name="seqno" id="seqno">
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
			</tr>
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr data-id="${result.seqno}">
					<td>${status.count}</td>
					<td>${result.title}</td>
					<td>${result.regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<input type="button" value="글쓰기" id="writing">
</body>
</html>