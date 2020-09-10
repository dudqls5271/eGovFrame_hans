<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="uploadForm.do" method="post" id="form1" enctype="multipart/form-data">
		<input type="file" name="file"> <input type="submit">
	</form> 
	<iframe name="zeroFra"></iframe>
	
	<script type="text/javascript">
		function addFilePath(msg) {
			alert(msg);
			document.getElementById("form1").reset();
		}
	</script>
</body>
</html>