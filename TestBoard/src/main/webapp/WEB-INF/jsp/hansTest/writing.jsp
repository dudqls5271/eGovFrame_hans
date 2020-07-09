<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/writing.css'/>" rel="stylesheet" type="text/css">
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

//  		var dragData = window.getSelection();
//  		var dragDataText = window.getSelection().toString();
//  		var dragParent = dragData.focusNode.parentNode;
//  		var inputArea = dragParent.parentNode;
//  		var dargParentText = dragParent.innerText;
//  		dargParentText = dargParentText.substr(0,dargParentText.indexOf(dragData));
//  		console.log(dargParentText);
 		
//  		inputArea.innerHTML = "";
//  		var newSpan = document.createElement("span");
//  		newSpan.innerText = dragDataText;
//  		newSpan.style.fontSize=$(this).val();
//  		inputArea.innerText = dargParentText;
//  		inputArea.appendChild(newSpan);
	});
});
</script>

</head>
<body>
	<form id="frm" action='/test/writing_re.do'>
		<div class="writing">
			<div class="group">      
	     		<input type="text" name="title" class="title" required />
	      		<span class="highlight"></span>
	      		<span class="bar"></span>
	      		<label>제목</label>
	      <c:if test="${empty sessionScope.sessionId}">		
	      	<div>
	    		<input type="text" name="writer">
	    		<input type="text" name="pw_boader">
	    		<input type="text" name="user_id">
	    	</div>
	    	</c:if>
	    	</div>
	    	
	    	<div>
	    		<input type="hidden" value=${sessionNick} name="writer">
	    		<input type="hidden" value=${sessionNick} name="pw_boader">
	    		<input type="hidden" value=${sessionId} name="user_id">
	    	</div>
	    	<div>
	    		<select id="fontSize">
	    			<option value="10px" id="10px">10px</option>
	    			<option value="20px" id="20px">20px</option>
	    			<option value="30px" id="30px">30px</option>
	    			<option value="40px" id="40px">40px</option>
	    			<option value="50px" id="50px">50px</option>
	    		</select>
	    	</div>
			<div>
				<textarea name="contents" class="text"></textarea>
			</div>	
	    	
	    	<div class="wrap">
	    		<p>완료</p>
	    		<div id="sub"></div>
   			</div>
	    </div>
	</form>
</body>
</html>