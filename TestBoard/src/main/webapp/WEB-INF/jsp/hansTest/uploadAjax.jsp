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
	<div class="fileDrop" style="width: 500px; height: 500px; border:black 1px solid;" ></div>
	
	<div class="uploadedList"></div>
	<script type="text/javascript">
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
// 		console.log(file);
		var formData = new FormData();
		formData.append("file",file);
		
		function checkImageType(fileName) {
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			return fileName.match(pattern);
		}
		
		function getOriginalName(fileName) {
			if(checkImageType(fileName)) {
				var idx = fileName.lastIndexOf("_") + 1;
				return fileName.substr(idx);
// 				return;
			}
			
			var idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);
		}
		
		function getImgLike(fileName) {
			
			if(!checkImageType(fileName)) {
				return;
			}
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
			
			return front + end;
		}
		
		$(".uploadedList").on("click", "small", function(event) {
			var that = $(this);
			
			$.ajax({
				url: "/test/deleteFile.do",
				type: "POST",
				data: {fileName:$(this).attr("data-src")},
				dataType: "text",
				success: function(result) {
					if(result == 'deleted') {
						that.parent("div").remove();
						alert("deleted");
					}
				}
			});
		});
		
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
// 					str = "<div><a href='displayFile.do?fileName="+getImgLike(data)+"'>"
// 						+ "<img src='displayFile.do?fileName="+data+"'/>"
// 						+ "</a><small data-src="+data+">X</small></div>";

					str = "<div><a href='displayFile.do?fileName="+getImgLike(data)+"'>"
					+ "<span>"+ getOriginalName(data)+ "</span>"
					+ "</a><small data-src="+data+">X</small></div>";
				} else {
					str = "<div><a href='displayFile.do?fileName="+data+"'>"
						+ getOriginalName(data)+ "</a>"
						+ "<small data-src="+data+">X</small></div></div>"
				}
				$(".uploadedList").append(str);
				alert(data);
			}
		})
	});
</script>
</body>
</html>