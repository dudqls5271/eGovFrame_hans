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
		
		$("#searchBtn").on("click", function(event) {
			
			self.location = "list.do"+'${pageMaker.makerQuery(1)}'
			+"&searchType="+$("select option:selected").val()
			+"&keyword="+$('#keywordInput').val();
		});
	});
</script>

</head>
<body>
<form id="frm" action='/test/view.do'>
<input type="hidden" name="seqno" id="seqno">
<input type="hidden" name = "page">
	<div class="grid-container">
      <div class="item1"><H1>header</H1></div>
      
<!-- ==============================================================================> nva 시작 -->
       <div class="item2">
        <ul class="nav">
          <li><b class="pk">개시판 +</b></li>
          <li><b>메인</b></li>
          <li><b>게시판2</b></li>
          <li><b>개시판3</b></li>
        </ul>
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
				<div data-id="${result.seqno}" class="board">${result.seqno}</div>
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
      
      <!-- ==============================================================================> 검색 시작 -->
      <div class="item3_7">
      <select>
   		<option value="n" <c:out value="${cri.searchType == null?'selectde ':''}"/>>
				--------
   		</option>
   		
   		<option value="t" <c:out value="${cri.searchType == 't'?'selectde ':''}"/>>
				title
   		</option>
   		
   		<option value="c" <c:out value="${cri.searchType == 'c'?'selectde ':''}"/>>
				Content
   		</option>
   		
   		<option value="w" <c:out value="${cri.searchType == 'w'?'selectde ':''}"/>>
				Writer
   		</option>
   		
   		<option value="tc" <c:out value="${cri.searchType == 'tc'?'selectde ':''}"/>>
				title OR Content
   		</option>
   		
   		<option value="cw" <c:out value="${cri.searchType == 'cw'?'selectde ':''}"/>>
				Countent RO Writer
   		</option>
   		
   		<option value="tcw" <c:out value="${cri.searchType == 'tcw'?'selectde ':''}"/>>
				Title OR Countent RO Writer
   		</option>
   	</select>
   	
   	<input type="text" id="keywordInput"> <input type="button" value="검색" id="searchBtn">
  </div>
      <!-- ==============================================================================> 유저 인터페이스 시작 -->
      <div class="item4">     
      	<c:import url="/test/user.do" charEncoding="UTF-8"></c:import>
      </div>
      <!-- ==============================================================================> footer 시작 -->
      <div class="item5">paging</div>
    </div>
    </form>
</body>
</html>