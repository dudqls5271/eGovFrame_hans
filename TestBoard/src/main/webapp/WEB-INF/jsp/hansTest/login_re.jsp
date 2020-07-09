<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/login_style.css'/>" rel="stylesheet" type="text/css" >
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
	
<script>
$(document).ready(function() {
	
	$(".join").click(function(){
		   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
		});
	
	$('.id_re').click(function() {
		window.open("/test/idChack.do", "win_popup", "width=468, height=500");
	});
});
</script>

</head>
<body>
<div class="login-page">
  <div class="form">
    <form class="register-form" action="/test/join_re.do" method=post>
      <input type="text" placeholder="ID" name="user_id" id="user_id" class="text"/>
      <input type="button" value="중복 확인" class="id_re">
      <input type="text" placeholder="name" name="name" class="text"/> 
      <input type="text" placeholder="nickname" name="nickname" class="text"/>
      <input type="password" placeholder="password" name="pw" id="pw" class="text"/>
      <input type="text" placeholder="Phone" name="phone1" class="hp"/>-
      <input type="text" placeholder="" name="phone2" class="hp"/>-
      <input type="text" placeholder="" name="phone3" class="hp"/>
	  <input type="text" placeholder="Email" name="email" id="email" class="text"/>
      <input type="submit" value="회원가입" id="button">
      <p class="message">Already registered? <a href="#" class="join">Sign In</a></p>
    </form>	
    
    <form id="frm" action="/test/login_re.do" method=post> 
      <input type="text" placeholder="username" name="user_id" id="user_id" class="text"/>
      <input type="password" placeholder="password" name="pw" id="pw" class="text"/>
      <input type="submit" value="로그인" id="button">
      <p class="message">Not registered? <a class="join">Create an account</a></p>
    </form>
  </div>
</div>
</body>
</html>