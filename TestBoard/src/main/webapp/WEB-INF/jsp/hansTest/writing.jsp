<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link href="<c:url value='/css/writing.css'/>" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
    <script type="text/javascript" charset="utf-8" src="/smartEditor/js/HuskyEZCreator.js"></script>
    <script>
        $(document).ready(function() {
            var index = $("#fontSize option").index($("#fontSize option:selected"));
            
            $('.submit').click(function() {
            	
            	//에디터에 값을 넣음
            	editor_object.getById["educontent"].exec("UPDATE_CONTENTS_FIELD",[]);
                   
                if ($('.writer').val() == "") {
                  alert("작성자를 입력해 주세요.")
                  $('.writer').focus();
                  // $('.writer').css('border', '2px solid #5264AE');
                } else if ($('.pw').val() == "") {
                  alert("비밀번호을 입력 해주세요")
                  $('.pw').focus();
                  // $('.pw').css('border', '2px solid #5264AE');
                } else if ($('.title').val() == "") {
                    alert("제목을 입력 하세요")
                    $('.title').focus();
                    // $('.title').css('border', '2px solid #5264AE');
                } else if ($('.content').val() == ""){
                    alert("내용을 입력해 주세요");
                    $('.content').focus();
                    // $('.content').css('border', '2px solid #5264AE');
                } else {
                    $("#frm").submit();
                }
            });
            
//             -------------------------------[smartEidt]-------------------

				var editor_object = []; 

				//스마트 에디터 생성 함수
		        nhn.husky.EZCreator.createInIFrame({
		          oAppRef : editor_object,
		          elPlaceHolder : "educontent", // newContents 는 스마트에디터가 추가될 텍스트 에어리어
		          sSkinURI : "/smartEditor/SmartEditor2Skin.html",
		          htParams : {
		            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseToolbar : true,
		            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseVerticalResizer : true,
		            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseModeChanger : false,
		          }
		     });
		        	  var boardAccount = $("#boardAccount").val();
		        	  var boardSubject = $("#boardSubject").val();
		        	  var smartEditor = $("#smartEditor").val();

//         	------------------------------[uploadFile]--------------------
        	function checkImageType(fileName) {
        		var pattern = /jpg$|gif$|png$|jpeg$/i;
        		return fileName.match(pattern);
        	}
        	
        	function getOriginalName(fileName) {
        		if(checkImageType(fileName)) {
        			var idx = fileName.lastIndexOf("_") + 1;
        			return fileName.substr(idx);
        		}
        		
        		var idx = fileName.indexOf("_") + 1;
        		return fileName.substr(idx);
        	}
        	
        	function getImgLike(fileName) {

        		if(!checkImageType(fileName)) {
        			return;
        		} else {
        			var front = fileName.substr(0,12);
        			var end = fileName.substr(14);
        		}
        		return front + end;
        	}
//         	-----------------------------------------------------------------------
        	$(".content").on("dragenter dragover", function(event) {
        		event.preventDefault();
        	});
        	$(".uploadedList").on("click", "small", function(event) {
        		var that = $(this);
        		
        		$.ajax({
        			url: "/test/deleteFile.do",
        			type: "POST",
        			data: {fileName:$(this).attr("data-src")},
        			dataType: "text",
        			success: function(result) {
        				if(result == 'deleted') {
        					that.closest("li").remove();
        					alert("deleted");
        				}
        			}
        		});
        	});
        	$(".content").on("drop", function(event) {
        		event.preventDefault();
        		
        		var files = event.originalEvent.dataTransfer.files;
        		var file = files[0];
//         		console.log(file);
        		var formData = new FormData();
        		formData.append("file",file);
        		
        		$.ajax({
        			url: 'test/uploadAjax.do',
        			data: formData,
        			dataType: 'text',
        			processData: false,
        			contentType: false,
        			type: 'POST',
        			success: function(data) {
        				
        				var str = "";
        				
        				if (checkImageType(data)) {
        					str = "<a href='displayFile.do?fileName="+getImgLike(data)+"'>"+getOriginalName(data)+"</a> | "
        								+ "<input type='text' name='fullnames' value="+getImgLike(data)+" /> "
        	        					+ "<input type='hidden' name='orinames' value="+getOriginalName(data)+">";
        				} else {
//         					str = "<div><a href='displayFile.do?fileName="+data+"'>"
//         						+ getOriginalName(data)+ "</a>"
//         						+ "<small data-src="+data+">X</small></div></div>"
        					str = "<a href='displayFile.do?fileName="+data+"'>"+getOriginalName(data)+"</a> | "
        						+ "<input type='hidden' name='fullnames' value="+data+">"
        						+ "<input type='hidden' name='orinames' value="+getOriginalName(data)+">";
        				}
        				$(".blas").append(str);
        				alert(data);
        			}
        		})
        	});
         });
</script>
  </head>
  <body>
    <h1 class="header">header</h1>
   	<c:import url="/test/nav.do" charEncoding="UTF-8"></c:import>
    <form id="frm" action='/test/writing_re.do' class="cc">
     <div class="header_c">
      <b>글쓰기</b>
    </div>

      <div class="frm">
      	<div class="con">
	        <div class="input_t">
	          <input type="text" class="writer" placeholder="닉네임" name="writer"/>
	          <input type="hidden" value=${sessionId} name="user_id">
	          <input type="password" class="pw" placeholder="비밀번호" name="pw_boader"/>
	          <input type="text" class="title" placeholder="제목을 입력해 주세요." name="title"/>
	        </div>
	
	        <div class="write_infobox">
	          <p>※ 쉬운 비밀번호를 입력하면 타인의 수정, 삭제가 쉽습니다.</p>
	          <p>
	            ※ 음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민,
	            형사상의 책임을 질 수 있습니다. [저작권법 안내] [게시물 활용 안내]
	          </p>
	        </div>
	
	        <div class="blas">
	          <br>
	        <p class="file_p">첨부파일</p>
	        </div>
	        <div class="text_a">
	          <textarea style="width:99%;height:400px;" maxlength="500" name=contents id="educontent" class="content" style="overflow:hidden"></textarea>
	        </div>
	        <div class="but">
	          <input type="button" value="취소" class="cansle" />
	          <input type="button" value="등록" class="submit" />
	        </div>
	     </div>
      </div>
    </form>

    <footer class="dcfoot">
      <div class="info_policy">
        <a href="#">회사소개 |</a>
        <a href="#">인재채용 |</a>
        <a href="#">제휴안내 | </a>
        <a href="#">광고안내 |</a>
        <a href="#">이용약관 |</a>
        <a href="#"><b>개인정보처리방침 |</b></a>
        <a href="#">청소년보호정책</a
        >
      </div>
      <div class="copyright">
        Copyright ⓒ 1999 - 2020 dcinside. All rights reserved.
      </div>
    </footer>
  </body>
</html>