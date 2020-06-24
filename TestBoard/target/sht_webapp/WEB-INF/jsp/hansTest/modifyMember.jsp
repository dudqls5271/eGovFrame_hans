<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id = "frm" action="/test/join_re.do" method=post>
	<table>
		<tr>
			<td>ID :</td>
			<td><input type="text" id="user_id" name="user_id" value="${result.user_id}"></td>
		</tr>

		<tr>
			<td>PW :</td>
			<td><input type="password" id="pw" name="pw" value="${result.pw}"></td>
		</tr>


		<tr>
			<td>email :</td>
			<td><input type="text" id="email" name="email" value="${result.email}"></td>
		</tr>
		
		<tr>
			<td><input type="submit" value="회원가입"></td>
		</tr>
	</table>
	</form>
</body>
</html>