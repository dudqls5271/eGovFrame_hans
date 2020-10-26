<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/css/find_id.css'/>" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
  <div class="header">
  	<div class="header_re">
  		<div class="but">
	  		<h4>DClone.do </h4> 
  		</div>
  	</div>
  </div>
  	<div class="contr">
	    <div class="content_main">
	        <div href="#" class="id">아이디 찾기</div>
	        <div href="#" class="pw">비밀번호 찾기</div>
	    </div>
	
	    <div>
	        <h3 class="main_name">아이디 찾기</h3>
	    </div>
	
	    <div class="contbox">
	        <div class="con">
	            <div class="info_txt">
	                <h4>회원가입 시 입력한 이름과 이메일(인증받은) 정보를 입력해 주시기 바랍니다.</h4>
	                <p>이메일은 반드시 인증받은(or 이메일 변경을 통해 변경한) 이메일을 입력하셔야 합니다.</p>
	                <p>회원 가입 시 실명이 아닌 다른 이름으로 가입했을 경우, 해당 가입 시 입력한 이름을 입력하셔야 합니다.</p>
	            </div>
				<form action="/test/find_id_re.do">
		            <div class="form_box">
		                <div class="input_box">
		                    <input type="text" class="input_name" placeholder="이름" name="user_name">
		                    <input type="text" class="input_email" placeholder="이메일" name="user_email">
		                    <input type="submit" value="확인" class="input_but">
		                </div>
		            </div>
				</form>
	            <div class="info_txt2">
	                <span><b>2013.02.18 이전 실명인증을 통해 가입한 아이디</b>는 실명인증 아이디 찾기를 통해 찾을 수 있습니다.
	                    실명인증 아이디 찾기 (인증 전환 회원 제외)
	                </span>
	            </div>
	        </div>
	    </div>
	  </div>
</body>
</html>