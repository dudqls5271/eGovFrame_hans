<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="<c:url value='/css/Modfiymember.css'/>" rel="stylesheet" type="text/css">
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
	
	$(".but_re").click(function() {
		if($(".inTag_ne").val() == "") {
			alert("닉네임을 입렵 해주세요.");
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
              <div class="id" id="user_info">개인 정보 변경</div>
              <div class="pw" id="pw_re">비밀번호 변경</div>
              <div class="pw" id="out">회원 탈퇴</div>
          </div>
      
          <div>
              <h3 class="main_name">기본 정보 변경</h3>
          </div>

        <div class="contbox">
            <div class="box">
                <div class="input_txt">
                    <div class="txt">아이디</div>
                    <div class="input">
                        <input type="text" class="inTag_t" value="${sessionId}" readonly="readonly">
                    </div>
                </div>

            <div class="input_txt">
                <div class="txt">닉네임</div>
	            <form action="/test/neck_re.do" id="frm">
	                <div class="input">
	                	<input type="hidden" value="${sessionId}" name="user_id">
	                    <input type="text" class="inTag_ne" value="${sessionNick}" name="nickname">
	                    <input type="button" value="변경 하기" class="but_re">
	                </div>
	            </form>
            </div>

            <div class="input_txt">
                <div class="txt">이름</div>
                <div class="input">
                    <input type="text" class="inTag_t" value="${name}" readonly="readonly" >
                </div>
            </div>

            <div class="input_txt">
                <div class="txt">가입이메일</div>
                <input type="text" class="inTag_E" readonly value="${email1}">
                <span class="gol">@</span>
                <input type="text" class="inTag_E" readonly value="${email2}">
            </div>
        </div>
    </div>
    <div class="but_ok">
        <div class="fr">
            <input type="button" value="확인" class="ok_but">
        </div>
    </div>
  </div>
</body>
</html>