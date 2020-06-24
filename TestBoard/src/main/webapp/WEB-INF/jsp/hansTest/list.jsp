<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/style.css'/>" rel="stylesheet" type="text/css" >
	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		$(".board").click(function() {
			$("#seqno").val($(this).data("id"));
			$("#frm").submit();
		});
		
		$("#join").click(function() {
			location.href = '/test/join.do';
		});

		$("#writing").click(function() {
			location.href = '/test/writing.do';
		});
		
		$("#logout").click(function() {
			location.href = '/test/logout.do';
		});
	});
</script>

</head>
<body>
	<h1 class="title">리스트</h1>
	
	<c:if test="${empty sessionScope.sessionId}">
	
	<form action="/test/login_re.do" method=post>
		<div class="login_forme">
			<p class="ID">ID : </p>
			<input type="text" name="user_id" id="user_id">
			<br>
			<p class="PW">PW :</p>
			<input type="password" name="pw" id="pw">
			<br>
			<input type="submit" value="로그인" class="login">
			<input type="button" value="회원 가입" id="join">
		</div>
	</form>
	
	<form id="frm" action='/test/view.do'>
		<input type="hidden" name="seqno" id="seqno">
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
			</tr>
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr data-id="${result.seqno}" class="board">
					<td class="board">${status.count}</td>
					<td class="board">${result.title}</td>
					<td class="board">${result.regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	</c:if>
	
	<c:if test="${not empty sessionScope.sessionId}">
	<h4 class="userName">${sessionScope.sessionId}님 반갑습니다.</h4>
	<input type="button" value="로그아웃" id="logout">
	<input type="button" value="정보 수정" id="modify">
	
	
	
	<form id="frm" action='/test/view.do'>
		<input type="hidden" name="seqno" id="seqno">
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
			</tr>
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<tr data-id="${result.seqno}" class="board">
					<td class="board">${status.count}</td>
					<td class="board">${result.title}</td>
					<td class="board">${result.regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<input type="button" value="글쓰기" id="writing">
	</c:if>
</body>
</html>