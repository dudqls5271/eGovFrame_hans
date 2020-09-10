<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>
	<h3>Ajax File Upload</h3>
	
	<div class="fileDrop" style="width: 100px; height: 100px; border:black 1px solid;" ></div>
	
	<div class="uploadList"></div>
	<script type="text/javascript">
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		console.log(file);
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url: '/test/uploadAjax.do',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data) {
				console.log(data);
				alert(data);
			}
			
		});
	});
</script>
</body>
</html>