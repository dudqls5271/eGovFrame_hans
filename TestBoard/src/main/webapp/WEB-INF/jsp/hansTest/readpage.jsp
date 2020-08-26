<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>

<script>
	$(".btn-primary").on("click", function() {
		formObj.attr("method", "get");
		formObj.attr("action", "/test/listPage");
		fromObj.submit();
	});
</script>
</head>
<body>
	<form role="form" action="modifyPage" method="post">
		<input type="hidden" name = "seqno" value="${boardVO.seqno }">
		<input type="hidden" name = "page" value="${cri.page }">
		<input type="hidden" name = "perPageNum" value="${cri.perPageNum }">
		
	</form>
</body>
</html>