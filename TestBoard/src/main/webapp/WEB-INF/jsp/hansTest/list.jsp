<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/style.css'/>" rel="stylesheet" type="text/css">

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

		$(".login_forme").click(function() {
			location.href = '/test/login.do';
		});
	});
</script>

</head>
<body>
	<header>
		<c:import url="/test/header.do" charEncoding="UTF-8"></c:import>
	</header>
	<c:if test="${empty sessionScope.sessionId}">
		<c:import url="/test/logout_list.do" charEncoding="UTF-8"></c:import>
	</c:if>
	
	
	<c:if test="${not empty sessionScope.sessionId}">
	
	<main>
		<section class="writing_bitton">
			<input type="button" value="글쓰기" id="writing"> 
			<input type="button" value="공지" class="notice">
		</section>
		<section class="writing_div">			
			<div class="table_list">
				<form id="frm" action='/test/view.do'>
					<input type="hidden" name="seqno" id="seqno">
					<table>
						<tr>
							<th class="num">번호</th>
							<th class="title">제목</th>
							<th class="writer">글쓴이</th>
							<th class="date">등록일</th>
						</tr>
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr data-id="${result.seqno}" class="board">
								<td>${status.count}</td>
								<td>${result.title}</td>
								<td>${result.writer }</td>
								<td>${result.regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</div>
			<div class="user_name">
				<h4 class="user_name_in">
					<strong>${sessionNick}(${sessionId})</strong> 님반갑습니다.
				</h4>
				<div class="login_forme">
					<a href="#" class="log">로그 |</a> 
					<a href="#" class="like">즐겨찾기 |</a> 
					<a href="#" class="bell">알림 |</a> 
					<a href="#" id="logout">로그아웃</a>
				</div>
			</div>
		</section>
	</main>
	</c:if>
</body>
</html>