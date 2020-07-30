<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/login.css'/>" rel="stylesheet" type="text/css" >
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
	
<script>
$(document).ready(function() {
	if('${msg}' != ''){
		alert("${msg}")
	}
	
	$(".join").click(function(){
		   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
		});
	
	$('.login').click(function() {
		if ($('#user_id').val() == "") {
			alert("아이디를 입력해 주세요.");
		} else if ($('#pw').val() == "") {
			alert("비밀번호를 입력해 주세요.");
		} else {
			$("#frm").submit();
		}
	});
});
</script>

</head>
  <body>
  <form id="frm" action="/test/login_re.do" method=post> 
    <div class="se">
      <div class="from">
        <div class="ping">
          <input type="text" class="id" placeholder="아이디" name="user_id" id="user_id" />
          <input type="password" class="pw" placeholder="비밀번호" name="pw" id="pw" />
          <input type="button" value="로그인" class="login" />

          <div class="nav">
            <a href="#">아이디 찾기</a>
            <a href="#" class="f">비밀번호 찾기</a>
            <a href="join.do" class="f">회원가입</a>
          </div>
        </div>
      </div>
    </div>
    </form>
</body>
</html>