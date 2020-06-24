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
	$(document).ready(function() {
		$("#join").click(function() {
			location.href = '/test/join.do';
		});
		
		var message = '${	message}';
	      if(message){
	         alert(message);
	      }
	});
</script>

</head>
<body>
	<form id="frm" action="/test/login_re.do" method=post>
		<table>
			<tr>
				<td>ID :</td>
				<td><input type="text" name="user_id" id="user_id"></td>
			</tr>

			<tr>
				<td>PW :</td>
				<td><input type="password" name="pw" id="pw"></td>
			</tr>
			<tr>
				<td><input type="submit" value="로그인"></td>
			</tr>
		</table>
	</form>
	<input type="button" value="회원 가입" id="join">
</body>
</html>