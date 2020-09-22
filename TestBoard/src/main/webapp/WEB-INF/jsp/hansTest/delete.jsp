<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link href="<c:url value='/css/delete.css'/>" rel="stylesheet" type="text/css">
  </head>
  <body>
    <h1 class="header">header</h1>
    <ul class="nav">
      <li><b class="pk">개시판 +</b></li>
      <li><b>메인</b></li>
      <li><b>게시판2</b></li>
      <li><b>개시판3</b></li>
    </ul>

    <div class="header_c">
      <b>삭제</b>
    </div>

    <div class="cont">
      <div class="content">
        <div class="pw_p">
          <p>비밀번호를 입력해주세요.</p>
          <input type="password" class="pw" />
          <div class="button">
            <input type="button" value="취소" class="back" />
            <input type="button" value="확인" class="ok" />
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
