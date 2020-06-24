<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


		<form action="/test/login_re.do" method=post>
			<div class="login_forme">
				<strong>로그인을 해 주시기 바랍니다.</strong>
			</div>
		</form>

		<form id="frm" action='/test/view.do'>
			<input type="hidden" name="seqno" id="seqno">
			<div class="table_list">
				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
					<c:forEach items="${resultList}" var="result" varStatus="status">
						<tr data-id="${result.seqno}" class="board">
							<td class="board">${status.count}</td>
							<td class="board">${result.title}</td>
							<td class="board">${result.regdate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</form>
</body>
</html>