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
			var frmFrom = $("#frm");
			console.log(frmFrom);
			$("[name=page]").val(targetPageNum);
			frmFrom.attr("action", "/test/view.do").attr("method","get");
			frmFrom.submit();
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
		
		$(".log").click(function(){
			$('.user_nav_hid').animate({ opacity: "toggle"}, "slow");
		});
		$(".pagination li a").on("click", function(event) {
			
			event.preventDefault();
			var targetPageNum = $(this).attr("href");
			
			var frmFrom = $("#frm");
			console.log(frmFrom);
			$("[name=page]").val(targetPageNum);
			frmFrom.attr("action", "/test/list.do").attr("method","get");
			frmFrom.submit();
			
		});
	});
</script>

</head>
<body>
<form id="frm" action='/test/view.do'>
<input type="hidden" name="seqno" id="seqno">
<input type="hidden" name = "page">
	<div class="grid-container">
      <div class="item1">Header</div>
      <c:import url="/test/nav.do" charEncoding="UTF-8"></c:import>
      <c:import url="/test/button.do" charEncoding="UTF-8"></c:import>
      <div class="item3">
        <div class="grid-container1">
          <div class="seqno">번호</div>
          <div class="title">제목</div>
          <div class="writer">글쓴이</div>
          <div class="date">등록일</div>
          <c:forEach items="${resultList}" var="result" varStatus="status">
				<div data-id="${result.seqno}" class="board">${status.count}</div>
				<div data-id="${result.seqno}" class="board">${result.title}</div>
				<div data-id="${result.seqno}" class="board">${result.writer}</div>
				<div data-id="${result.seqno}" class="board">${result.regdate}</div>
           </c:forEach>
        </div>
      </div>
      <div class="item3_5">
      	<c:import url="/test/listPage.do" charEncoding="UTF-8"></c:import>
      </div>
      <div class="item4">     
      	<c:import url="/test/user.do" charEncoding="UTF-8"></c:import>
      </div>
      <div class="item5">paging</div>
    </div>
    </form>
</body>
</html>