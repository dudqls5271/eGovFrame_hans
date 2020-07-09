<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/view.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/button.css'/>" rel="stylesheet" type="text/css">
	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	
    var index = $("#fontSize option").index($("#fontSize option:selected"));
    
    $('.wrap').click(function() {
    	if ($('.title').val() == "") {
    		alert("제목을 입력 하세요")
    		$('.title').focus();
    	} else if ($('.text').val() == ""){
    		alert("내용을 입력해 주세요");
    		$('.text').focus();
			$('.text').css('border', '2px solid #5264AE');
    	} else {
    		$("#frm").submit();
    	}
    });
    $('.text').blur(function(){
    	if($('.text').val() != ""){
    		$('.text').css('border', '1px solid black');	
    	}    	
    });
    
    
    $('.wrap').mouseover(function() {
		$('#sub').stop().animate({
			width: "100px"
		}, 100, "linear");
	});
    
    $('.wrap').mouseout(function() {
		$('#sub').stop().animate({
			width: "0px"
		}, 100, "linear");
	});
    
	$('#fontSize').change(function() {
		$('.text').css('font-size',this.value);
	});
});
</script>

</head>
<body>
	<form id="frm" action='/test/modify.do'>
	<input type="hidden" name="seqno" id="seqno" value="${result.seqno}">
		<div class="writing">  
	    	<div class="user">
	    		<p>${result.title}</p>
	    		<span>${result.writer}	|	</span>
	    		<span>${result.regdate}</span>
	    		<input type="hidden" value="${sessionId}" name="user_id">
	    	</div>
	    	
			<div>
				<textarea name="contents" class="text" readonly="readonly">${result.contents}</textarea>
			</div>	
			<input type="submit" value="수정">
			<input type="button" value="삭제">
	    </div>
	</form>
</body>
</html>