<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="<c:url value='/css/pw_re.css'/>" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
    
    <script type="text/javascript">
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
    	
		$('#pw_re2').blur(function(){
			if($("#pw_re1").val() == $("#pw_re2").val()) {
				$(".pw_txt").text("비밀번호 일치");
				$(".pw_txt").css('color','#29d616');
			} else {
				$(".pw_txt").text("비밀번호 재입력");
				$(".pw_txt").css('color','red');
			}
			
		});
    	
    	$('.input_but').click(function() {
  		  if ($('#pw').val() == "") {
  			  alert("현재 비밀번호를 입력해 주세요.");
  		  } else if ($('#pw_re1').val() == "") {
  			  alert("비밀번호를 입력 해주세요.");
  		  } else if ($('#pw_re2').val() == "") {
  			  alert("비밀번호 확인을 입력해 주세요.");
  		  }   else {
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
              <div class="id" id="pw_re">비밀번호 변경</div>
              <div class="pw" id="out">회원 탈퇴</div>
          </div>
      
          <div>
              <h3 class="main_name">비밀번호 변경</h3>
          </div>

        <div class="contbox">
            <div class="txt_input">
                <h4 class="red">비밀번호는 주기적으로 변경하여 주시기 바랍니다.</h4>
                <p>영문, 숫자을 조합 하여 8~20자로 설정해 주시기 바랍니다. (대소문자, 특수문자를 조합하시면 더욱 안전합니다.)</p>
                <p>영문, 숫자 동일 및 연속 3자리 또는 특수문자 동일 3자리 사용 불가합니다. 예) 123, 111, abc, aaa, !!!</p>
                
                <div class="form_box">
                	<form action="/test/pw_re_ck.do" id="frm" method=post>
                		<input type="hidden" value="${sessionId}" name="user_id">
	                    <input type="password" placeholder="현재 비밀번호" class="input_email" id="pw" name="pro_pw">
	                    <input type="password" placeholder="새 비밀번호" class="input_email" id="pw_re1" name="pw">
	                    <input type="password" placeholder="새 비밀번호 확인" class="input_email" id="pw_re2">
	                    <h4 class="pw_txt"></h4>
	                    <input type="button" value="확인" class="input_but" >
	             	</form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>