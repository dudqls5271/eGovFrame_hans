<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/css/find_id.css'/>" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<title>Insert title here</title>
    <script>
	$(document).ready(function() {
		
		 $('.input_but').click(function(){
			 if ($('#pw').val() == "") {
                 alert("비밀번호를 입력해주세요.");
               } else if ($('#pw_re').val() == "") {
                 alert("비밀번호를 다시 입력해주세요.");
               } else if ($('#pw').val() != $('#pw_re').val()){
            	 alert("비밀번호가 일치 하지 않습니다.")
               } else {
                   $("#frm").submit();
               } 
		 });

        $('#pw_re').blur(function(){
            if($("#pw").val() == $("#pw_re").val()) {
                $(".pw_chack").text("비밀번호 일치");
                $(".pw_chack").css('color','#29d616');
            } else {
                $(".pw_chack").text("비밀번호 재입력");
                $(".pw_chack").css('color','red');
            }
            
        });
	 });
    </script>

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
              <div class="id">아이디 찾기</div>
              <div class="pw">비밀번호 찾기</div>
          </div>
      
          <div>
              <h3 class="main_name">비밀번호 찾기</h3>
          </div>

    <div class="contbox">
        <div class="con">
            <div class="info_txt">
                <h4>비밀번호 설정</h4>
                <p>보안을 위해 아이디는 2자까지만 노출됩니다.</p>
                <p>해당 아이디를 모두 확인하시려면 하단 [등록한 이메일로 아이디 받기]를 통해 확인하실 수 있습니다.</p>
            </div>
			<form action="/test/pw_re_login.do" method="post" id="frm">
	            <div class="form_box">
	                <div class="input_box">
	                    <p class="id_2">아이디 : ${result.user_id}</p>
	                    <input type="hidden" name="user_id" value="${result.user_id}">
	                    <p class="id_3">5~20자 영문, 숫자로 입력해 주세요. </p>
	                    <input type="password" placeholder="새 비밀번호" class="input_email" id="pw" name="pw">
	                    <input type="password" placeholder="새 비밀번호" class="input_email" id="pw_re">
	                    <span class="pw_chack"></span>
	                    <input type="button" value="확인" class="input_but" >
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