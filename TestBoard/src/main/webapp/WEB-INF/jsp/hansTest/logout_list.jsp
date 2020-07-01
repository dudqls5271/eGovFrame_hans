<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</script>		
</head>
<body>

	<section class="writing_div">			
			<div class="table_list">
				<form id="frm" action='/test/view.do'>
					<input type="hidden" name="seqno" id="seqno">
					<table>
						<tr>
							<th class="num">번호</th>
							<th class="title">제목</th>
							<th class="writer">글쓴이</th>
							<th class="date">등록일</th>
						</tr>
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr data-id="${result.seqno}" class="board">
								<td>${status.count}</td>
								<td>${result.title}</td>
								<td>${result.writer }</td>
								<td>${result.regdate}</td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</div>
			<div class="user_name">
				<h4 class="user_inform">
					<strong class="login_forme">로그인을 해 주시기 바랍니다.</strong>
				</h4>
			</div>
		</section>
</body>
</html>