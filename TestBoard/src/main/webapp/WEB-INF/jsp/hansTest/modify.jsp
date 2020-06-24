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
	<form id="frm" action='/test/modify_re.do'>
		<input type="hidden" name="seqno" id="seqno" value="${result.seqno}">
		<table>
			<tr>
				<td>제목 :</td>
				<td><input type="text" placeholder="제목" id="title" name="title"
					value="${result.title}"></td>
			</tr>

			<tr>
				<td>내용 :</td>
				<td><textarea rows="40px" cols="80px" id="contents"
						name="contents">${result.contents}</textarea></td>
			</tr>
		</table>
		<input type="submit" value="수정" id="writing">
	</form>
</body>
</html>