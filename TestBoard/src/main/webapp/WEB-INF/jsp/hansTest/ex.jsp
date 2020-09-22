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
	});
	
// 	------------------------------[uploadFile]--------------------
	function checkImageType(fileName) {
		var pattern = /jpg$|gif$|png$|jpeg$/i;
		return fileName.match(pattern);
	}
	
	function getOriginalName(fileName) {
		if(checkImageType(fileName)) {
			var idx = fileName.lastIndexOf("_") + 1;
			return fileName.substr(idx);
		}
		
		var idx = fileName.indexOf("_") + 1;
		return fileName.substr(idx);
	}
	
	function getImgLike(fileName) {

		if(!checkImageType(fileName)) {
			return;
		} else {
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
		}
		return front + end;
	}
// 	-----------------------------------------------------------------------
	$(".text").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	$(".uploadedList").on("click", "small", function(event) {
		var that = $(this);
		
		$.ajax({
			url: "/test/deleteFile.do",
			type: "POST",
			data: {fileName:$(this).attr("data-src")},
			dataType: "text",
			success: function(result) {
				if(result == 'deleted') {
					that.closest("li").remove();
					alert("deleted");
				}
			}
		});
	});
	$(".text").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
// 		console.log(file);
		var formData = new FormData();
		formData.append("file",file);
		
		$.ajax({
			url: 'test/uploadAjax.do',
			data: formData,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data) {
				
				var str = "";
				
				if (checkImageType(data)) {
					str = "<li class='list_img'><p class= 'img_t'><a href='displayFile.do?fileName="+getImgLike(data)+"'>"
					+ "<img style='border-radius: 20px 20px 5px 5px;' src='displayFile.do?fileName="+data+"'/>"
					+ "</a><div data-src="+data+" class='OriName'><p class='delete'>"+getOriginalName(data)+"</span><small data-src="+data+">X</small></div></p></li>"
					+ "<input type='hidden' name='fullname' value="+getImgLike(data)+">"
					if(data == "") {
					+ "<input type='hidden' name='s_fullname' value='no'>";
					} else {
					+ "<input type='hidden' name='s_fullname' value="+data+">";
					}
					

				} else {
// 					str = "<div><a href='displayFile.do?fileName="+data+"'>"
// 						+ getOriginalName(data)+ "</a>"
// 						+ "<small data-src="+data+">X</small></div></div>"
					str = "<li class='list_img'><p class= 'img_t'><a href='displayFile.do?fileName="+data+"'>"
					+ "<img style='border-radius: 20px 20px 5px 5px; width: 100px;' src='/img/file.png'/>"
					+ "</a><div data-src="+data+" class='OriName'><p class='delete'>"+getOriginalName(data)+"</span><small data-src="+data+">X</small></div></p></li>";
				}
				$(".uploadedList").append(str);
				alert(data);
			}
		})
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
	    		<input type="text" name="writer" placeholder="작성자">
	    		<input type="password" name="pw_boader" placeholder="비밀번호">
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
	    		<ul class="uploadedList"></ul>
	    	<div class="wrap">
	    		<p>완료</p>
	    		<div id="sub">
	    		</div>
   			</div>
	    </div>
	</form>
</body>
</html>