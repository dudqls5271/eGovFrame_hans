<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/style.css'/>" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"> 

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		
		var msg = '${msg}';
    	if (msg != "") {
        	alert(msg);	
    	}
		
		$(".board").click(function() {
			var frmFrom = $("#frm");
			console.log(frmFrom);
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

		$(".user_name_in_empty").click(function() {
			location.href = '/test/login.do';
		});
		
		$(".log").click(function(){
			$('.user_nav_hid').animate({ opacity: "toggle"}, "slow");
		});
		$(".pagination li a").on("click", function(event) {
			
			event.preventDefault();
			var targetPageNum = $(this).attr("href");
			
			var frmFrom = $("#frm_list");
			console.log(frmFrom);
			$("[name=page]").val(targetPageNum);
			frmFrom.attr("action", "/test/list.do").attr("method","get");
			frmFrom.submit();
			
		});
		
		$("#search").on("click", function(event) {
			
			self.location = "list.do"+'${pageMaker.makerQuery(1)}'
			+"&searchType="+$("select option:selected").val()
			+"&keyword="+$('#keywordInput').val();
		});
	});
</script>

</head>
<body>
<form id="frm_list">
	<input type="hidden" name = "page">
</form>
<form id="frm" action='/test/view.do'>
<input type="hidden" name="seqno" id="seqno">

	<div class="grid-container">
      <div class="item1">
      		<c:import url="/test/header.do" charEncoding="UTF-8"></c:import>
      </div>
      
<!-- ==============================================================================> nva 시작 -->
       <div class="item2">
			<c:import url="/test/nav.do" charEncoding="UTF-8"></c:import>
      </div>
      

<!-- ==============================================================================> button 시작 -->
      <c:import url="/test/button.do" charEncoding="UTF-8"></c:import>
      

<!-- ==============================================================================> 리스트 시작 -->
      <div class="item3">
        <div class="grid-container1">
          <div class="seqno">번호</div>
          <div class="title">제목</div>
          <div class="writer">글쓴이</div>
          <div class="date">등록일</div>
          <c:forEach items="${resultList}" var="result" varStatus="status">
				<div data-id="${result.seqno}" class="board">${result.title}</div>
				<div data-id="${result.seqno}" class="board">${result.writer}</div>
				<div data-id="${result.seqno}" class="board">${result.regdate}</div>
           </c:forEach>
        </div>
      </div>
      
<!-- ==============================================================================> 페이징 시작 -->
      <div class="item3_5">
      	<div class="text-center">
               <ul class="pagination">
               
               <c:if test="${pageMaker.prev}">
                  <li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
               </c:if>
               
               <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var= "idx">
                  <li <c:out value="${pageMaker.cri.page == idx?'class = active' : '' }" />>
                     <a class="pagelist" href="${idx}">${idx}</a>
                  </li>
               </c:forEach>
               
               <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
                  <li><a href="${pageMaker.endPage + 1 }">&raquo;</a></li>
               </c:if>
               </ul>
            </div>
      </div>	
      
      <!-- ==============================================================================> 유저 인터페이스 시작 -->
      <div class="item4">     
      	<c:import url="/test/user.do" charEncoding="UTF-8"></c:import>
      </div>
      <!-- ==============================================================================> footer 시작 -->
      <div class="item5"><c:import url="/test/copi.do" charEncoding="UTF-8"></c:import></div>
    </div>
    </form>
</body>
</html>