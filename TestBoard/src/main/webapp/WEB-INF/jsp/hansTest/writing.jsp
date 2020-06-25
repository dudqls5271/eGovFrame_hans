<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/writing.css'/>" rel="stylesheet" type="text/css">
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
</head>
<body>
	<form id="frm" action='/test/writing_re.do'>
	<span>제목 : </span> 
	<div class="control">
		<div class="field">
		   <input class="input is-info" type="text" placeholder="Info input">
		  </div>
		</div>
	</form>
</body>
</html>