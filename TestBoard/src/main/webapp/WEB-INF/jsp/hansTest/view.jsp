<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
    <link href="<c:url value='/css/view.css'/>" rel="stylesheet" type="text/css">
<script>
	$(document).ready(function() {
		$(".modfiy").click(function() {
			var frmFrom = $("#frm");
			console.log(frmFrom);
			frmFrom.attr("action", "/test/modify.do").attr("method","get");
			frmFrom.submit();
		});
		
		$(".delete").click(function() {
// 			var inputString = prompt('비밀번호를 입렵해주세요', '비밀번호 입력'); 
// 			alert(inputString);
			 $( "#dialog" ).dialog();
		})
	});
</script>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <h1 class="header">header</h1>
    <ul class="nav">
      <li><b class="pk">개시판 +</b></li>
      <li><b>메인</b></li>
      <li><b>게시판2</b></li>
      <li><b>개시판3</b></li>
    </ul>
    <div class="header_c">
      <b>개시판</b>
    </div>
    <div class="title">
      <span class="title_c"><h3>${result.title}</h3></span>
      <div class="writer">
        <span class="user_id">${result.writer}</span> |
        <span class="date">${result.regdate}</span>
      </div>
    </div>
    <form action="/test/modify.do" id="frm">
    	<input type="hidden" value="${result.seqno}" name="seqno" id="seqno" >
    </form>
    <div class="content">
      <div class="cont">
        <c:forEach items="${fullNameList}" var="vo">
        	<c:if test="${vo.fullname != 'no'}">
        		<c:set var = "string1" value = "${vo.fullname}"/>
    			<c:set var = "length" value = "${fn:length(string1)}"/>
    			<c:set var = "string2" value = "${fn:substring(string1, length -3, length)}" />
    				<c:if test="${string2 != 'png' && string2 != 'jpg' && string2 != 'gif' && string2 != 'jpeg'}">
    					<p></p>
    				</c:if>
    				
    				<c:if test="${string2 == 'png' || string2 == 'jpg' || string2 == 'gif' || string2 == 'jpeg'}">
	        			<a href="displayFile.do?fileName=${vo.fullname}" target="_blank"><img src="displayFile.do?fileName=${vo.fullname}"></a>
	        		</c:if>
	        	</c:if>
	        </c:forEach>
	  
        <textarea name="contents" class="text" readonly="readonly">${result.contents}</textarea>
      </div>
      <div class="file">
        <span class="file_text"><b>원본 첨부파일</b></span>
        <ul class="fileUpload">
        	<c:forEach items="${fullNameList}" var="vo">
          <li><a href= "displayFile.do?fileName=${vo.fullname}" target="_blank"> ${vo.oriname} | </a></li>
          </c:forEach>
        </ul>
      </div>
		<div class="button">
			<input type="button" value="수정" class="modfiy"> 
			<input type="button" value="삭제" class="delete"> 
			<input type="button" value="글쓰기" class="writer_re">
		</div>
	</div>
  </body>
</html>
