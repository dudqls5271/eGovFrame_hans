<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>ID 중복 체크</h3>
	<hr size="1" width="400">
	<form class="register-form" action="/test/id_re.do">
	<input type="text" placeholder="ID" name="user_id"> 
	<p>${sessionNick}d</p>
	<input type="submit" value="중복 확인">
	</form>
</body>
