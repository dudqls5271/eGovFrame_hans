<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/out.css'/>" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
    <script type="text/javascript" charset="utf-8" src="/smartEditor/js/HuskyEZCreator.js"></script>
	
<script>
$(document).ready(function() {
	
	var msg = '${msg}';
	if (msg != "") {
    	alert(msg);	
	}
	
	$("#user_info").click(function(){
		location.href='/test/modifyMember.do';
	});
	
	$('#pw_re').click(function() {
		location.href='/test/pw_re.do';
	});
	
	$("#out").click(function() {
		location.href='/test/Dclone_out.do';
	})
	
	$(".ok_but").click(function() {
		location.href='/test/list.do';
	});
	
	$('.input_but').click(function() {
		  if ($('#pw').val() == "") {
			  alert("비밀번호를 입력해 주세요.");
		  } else {
			  $("#frm").submit();
		  }
	  });
  	
	
});
	</script>
</head>
<body>
<c:if test="${empty sessionScope.sessionId}">
	<script type="text/javascript">
	$(document).ready(function(){
		location.href = '/test/list.do';
		alert("로그인후 이용해주세요.");
	});
	</script>
</c:if>
	<div class="header">
        <div class="header_re">
            <div class="but">
                <h4>DClone.do </h4> 
            </div>
        </div>
    </div>
        <div class="contr">
          <div class="content_main">
              <div class="pw" id="user_info">개인 정보 변경</div>
              <div class="pw" id="pw_re">비밀번호 변경</div>
              <div class="id" id="out">회원 탈퇴</div>
          </div>
      
          <div>
              <h3 class="main_name">회원 탈퇴</h3>
          </div>

        <div class="contbox">
            <div class="txt_input">
                <form action="/test/out.do" id="frm" method=post>
	                <div class="form_box">
	                    <h4 class="red">개인 정보 보호를 위해 비밀번호를 입력해주세요</h4>    
	                    <input type="password" placeholder="현재 비밀번호" class="input_email" id="pw" name="pw">
	                    <input type="hidden" value="${sessionId}" name="user_id">
	                    <input type="button" value="확인" class="input_but" >
	                </div>
	            </form>
            </div>
        </div>
    </div>
</body>
</html>