<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/css/find_id.css'/>" rel="stylesheet" type="text/css">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
    <script type="text/javascript" charset="utf-8" src="/smartEditor/js/HuskyEZCreator.js"></script> 
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
                    <h4>입력하신 정보(이름/이메일)와 일치하는 아이디를 안내해드립니다.</h4>
                    <p>보안을 위해 아이디는 2자까지만 노출됩니다.</p>
                    <p>해당 아이디를 모두 확인하시려면 하단 [등록한 이메일로 아이디 받기]를 통해 확인하실 수 있습니다.</p>
                    </div>
                    
                    <div class="form_box">
                    <div class="input_box">
                        <p class="id_2">${result.user_id}</p>
                        <p>입니다.</p>
                        <a href="/test/login.do"><input type="submit" value="로그인" class="input_but"></a>
                    </div>
                    </div>
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