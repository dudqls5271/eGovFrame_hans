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
    
    $('#sub').click(function() {
    	if ($('.title').val() == "") {
    		alert("제목을 입력 하세요")
    	} else if ($('.text').val() == ""){
    		alert("내용을 입력해 주세요");
    		$('.text').focus();
			$('.text').css('border', '2px solid #5264AE');
    	} else {
    		$("#frm").submit();
    	}
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
	     		<input type="text" required name="title" class="title">
	      		<span class="highlight"></span>
	      		<span class="bar"></span>
	      		<label>제목</label>
	    	</div>
	    	
	    	<div>
	    		<input type="hidden" value=${sessionNick} name="writer">
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
	    	
<!-- 	    	<section contenteditable="true" class="text" required> -->
<!-- 	    		<p><span><br></span></p> -->
<!-- 	    	</section> -->
			<div>
				<textarea name="contents" class="text"></textarea>
			</div>	
	    	
	    	<div class="wrap">
   				<a class="btn-0" href="#">Swipe</a>
   			</div>
	    </div>
	</form>
</body>
</html>