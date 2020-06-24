<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
	<form id="frm" action='/test/writing_re.do'>
		<table>
			<tr>
				<td>제목 :</td>
				<td><input type="text" placeholder="제목" id="title" name="title"></td>
			</tr>

			<tr>
				<td>내용 :</td>
				<td><textarea rows="40px" cols="80px" id="contents" name="contents"></textarea></td>
			</tr>
		</table>
		<input type="submit" value="글쓰기" id="writing">
	</form>
</body>
</html>