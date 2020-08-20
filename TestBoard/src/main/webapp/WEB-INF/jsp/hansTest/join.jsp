<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/css/join.css'/>" rel="stylesheet"
	type="text/css">
<script defer
	src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
   <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      function sample6_execDaumPostcode() {
        new daum.Postcode({
          oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ""; // 주소 변수
            var extraAddr = ""; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === "R") {
              // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
            } else {
              // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === "R") {
              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                extraAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if (data.buildingName !== "" && data.apartment === "Y") {
                extraAddr +=
                  extraAddr !== ""
                    ? ", " + data.buildingName
                    : data.buildingName;
              }
              // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if (extraAddr !== "") {
                extraAddr = " (" + extraAddr + ")";
              }
              // 조합된 참고항목을 해당 필드에 넣는다.
              document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
              document.getElementById("sample6_extraAddress").value = "";
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample6_postcode").value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
          },
        }).open();
      }
<<<<<<< HEAD
      
      
      $(document).ready(function() {
    	//공백, 한글을 못사용하게 한다.
    	  $('#user_id').on("blur keyup", function() {
    			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    			$(this).val( $(this).val().replace( /\s/g,'' ) );
    		});
    		$('#pw').on("blur keyup", function() {
    			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    			$(this).val( $(this).val().replace( /\s/g,'' ) );
    		});
    		$('#pw_re').on("blur keyup", function() {
    			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    			$(this).val( $(this).val().replace( /\s/g,'' ) );
    		});
    		
    		
    		//숫자만 입력가능하게
    		$('#mem_tel1').focus(function() {
    			$('#hp1').val("");
    		});
    		$('#mem_tel2').focus(function() {
    			$('#hp2').val("");
    		});
    		$('#mem_tel3').focus(function() {
    			$('#hp3').val("");
    		});
    		$('#hp1').keydown(function(){
    			$(this).val( $(this).val().replace( /[^0-9]/g,'' ) );
    		
    			if($(this).val().length > 2){
    				$('#hp2').focus();
    			}
    		});
    		$('#hp2').keydown(function(event){
    			$(this).val( $(this).val().replace( /[^0-9]/g,'' ) );
    			
    			if($(this).val().length > 3){
    				$('#hp3').focus();
    			}
    		});
    		$('#hp3').keydown(function(event){
    			$(this).val( $(this).val().replace( /[^0-9]/g,'' ) );
    			
    		});
    		
			$("#user_id").blur(function(){
				var jsonv = {user_id : $("#user_id").val()};
				$.ajax({
					type:"POST", 
					url:'<c:url value="idChack.do" />',
					data:jsonv, 
					success:function(data){
						if(data == "Y"){
							$("#idcheck").text("회원가입이 가능합니다.");
							$("#idcheck").css("color","#29d616");
						}else if(data == "N"){
							$("#idcheck").text("이미 가입한 ID입니다.");
							$("#idcheck").css("color","red");
							$("#user_id").val("");
							$("#user_id").focus();
						}
					}//END OF 콜백함수 즉 DB상 중복체크를 해온결과가 data
				});//END OF AJAX
			});
    			
    	  
			$("#pw_re").blur(function(){
				if($("#pw").val() == $("#pw_re").val()) {
					$(".pw_chack").text("비밀번호 일치");
					$(".pw_chack").css("color","#29d616");
				} else {
					$(".pw_chack").text("비밀번호 재입력");
					$(".pw_chack").css("color","red");
				}
				
			});
			
			
    	  $('.wrap').click(function() {
    		  if ($('#user_id').val() == "") {
    			  alert("아이디를 입력해 주세요.");
    			   $("#user_id").focus();
    		  } else if ($('#alert').val() == "") {
    			  alert("닉네임를 입력해 주세요.");
    			   $("#nickname").focus();
    		  } else if ($('#pw').val() == "") {
    			  alert("비밀번호를 입력해 주세요.");
    			  $("#pw").focus();
    		  } else if ($('#pw_re').val() == "") {
    			  alert("비밀번호를 제입력해 주세요.");
    			  $("#pw_re").focus();
    		  } else if ($('#name').val() == "") {
    			  alert("이름을 입력해주세요");
    			  $("#name").focus();
    		  } else if ($('#hp1').val() == "" && $('#hp2').val() == "" && $('#hp3').val() == "") {
    			  alert("전화번호를 입력해 주세요");
    			  $("#hp1").focus();
    		  } else if ($('#sample6_postcode').val() == "") {
    			  alert("우편번호를 입력해 주세요.");
    			  $("#sample6_postcode").focus();
    		  } else if ($('#sample6_address').val() == "") {
    			  alert("상세주소를 입력해 주세요.")
    			  $("#sample6_address").focus;
    		  } else if ($("#pw").val() != $("#pw_re").val()) {	
    			   $("#pw").focus();
    			  alert("비밀번호를 다시 입력 해주세요");
    		  } else {
    			  $(".register-form").submit();
    		  }
    	  });
      });
      
=======
>>>>>>> parent of 7ccb025... 제이슨 아이디 중복 체크
    </script>
</head>
<body>
<body>
	<form class="register-form" action="/test/join_re.do" method=post>
		<div class="content">
			<div class="join">
				<div class="title_div">
					<h3 class="title">기본 정보 입력</h3>
				</div>

				<div class="from">
					<div class="con">
						<div class="id">
							<div class="text_g">아이디 입력</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" class="int" placeholder="아이디를 입력해 주세요"
										name="user_id" id="user_id" maxlength="20" />
								</div>
								<div class="text_D">5~20자 영문, 숫자로 입력해 주세요.</div>
							</div>
						</div>

						<div class="nekname">
							<div class="text_g">닉네임 만들기</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" class="int" placeholder="닉네임를 입력해 주세요"
										name="nickname" maxlength="20" />
								</div>
								<div class="text_D">2~20자 닉네임을 입력해 주세요.(띄어쓰기는 할 수없습니다.)</div>
							</div>
						</div>

						<div class="pw">
							<div class="text_g">비밀번호 입력</div>
							<div class="from_text">
								<div class="div_in">
									<input type="password" class="int" placeholder="비밀번호를 입력해 주세요"
										name="pw" maxlength="20" />
								</div>
								<div class="div_in">
									<input type="password" class="pw_ch"
										placeholder="비밀번호를 제확인해 주세요" maxlength="20" name="pw_re" />
								</div>
								<div class="text_D">5~20자 영문, 숫자로 입력해 주세요. <span class="pw_chack"></span> </div>
							</div> 
						</div>

						<div class="name">
							<div class="text_g">이름</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" class="int" placeholder="이름를 입력해 주세요"
										name="name" />
								</div>
								<div class="text_D">ID/PW 분실 시 가입 정보를 통해 찾을 수 있으므로 정확히 입력해
									주시기 바랍니다.</div>
							</div>
						</div>

						<div class="hp">
							<div class="text_g">전화번호</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" placeholder="Phone" name="phone1"
										class="int_add_num" maxlength="3" />- <input type="text"
										placeholder="" name="phone2" class="int_add_num" maxlength="4" />-
									<input type="text" placeholder="" name="phone3"
										class="int_add_num" maxlength="4" />
								</div>
								<div class="text_D">'-' 없이 입력해주세요</div>
							</div>
						</div>

						<div class="add">
							<div class="text_g">주소</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" id="sample6_postcode" placeholder="우편번호"
										onclick="sample6_execDaumPostcode()" class="int_add_num"
										readonly name="add1" /> <input type="text"
										id="sample6_address" placeholder="주소" class="add_int_s"
										readonly name="add2" /><br /> <input
										type="text" id="sample6_extraAddress" placeholder="참고항목"
										class="add_int" readonly name="add3" /> <input
										type="text" id="sample6_detailAddress" placeholder="상세주소"
										class="add_int" name="add4" />
								</div>
								<div class="text_D">우편번호를 클릭 하여 입력해주세요</div>
							</div>
						</div>



						<div class="nekname">
							<div class="text_g">이메일</div>
							<div class="from_text">
								<div class="div_in">
									<input type="text" class="int_e" name="email1" /> @ <input
										type="text" class="int_e" name="email2" />
									<!-- <select name="email" id="email">
                        <option value="daum.com">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="hanmail.com">hanmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="daum.com">daum.com</option>
                    </select> -->
								</div>
								<div class="text_D">정확한 이메일를 입력해 주세요.</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="sub">
				<div class="button">
					<input type="submit" class="ok" value="완료"></input>
				</div>
			</div>
		</div>
	</form>
</body>
</html>