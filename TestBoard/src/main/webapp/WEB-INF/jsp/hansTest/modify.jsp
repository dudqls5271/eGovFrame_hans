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
    <script>
        $(document).ready(function() {
            var index = $("#fontSize option").index($("#fontSize option:selected"));
            
            $('.submit').click(function() {
                   
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
                }
                else {
                    $("#frm").submit();
                }
            });
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
        								+ "<input type='hidden' name='fullnames' value="+getImgLike(data)+" /> "
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
    <ul class="nav">
      <li><b class="pk">개시판 +</b></li>
      <li><b>메인</b></li>
      <li><b>게시판2</b></li>
      <li><b>개시판3</b></li>
    </ul>
    <form class="cc">
      <div class="name">
        <h4>수정</h4>
      </div>

      <div class="frm">
        <div class="input_t">
          <input type="text" class="writer" placeholder="닉네임" value="${result.writer}"/>
          <input type="password" class="pw" placeholder="비밀번호" value="${result.pw_boader}"/>
          <input type="text" class="title" placeholder="제목을 입력해 주세요." value="${result.title}"/>
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
          <c:forEach items="${fullNameList}" var="vo">
          	<c:if test="${vo.oriname != 'no'}">
          		<a href= "displayFile.do?fileName=${vo.fullname}" target="_blank"> ${vo.oriname} | </a>
          	</c:if>	
          </c:forEach>
        </div>

        <div class="text_a">
          <textarea name="" class="content" cols="30" rows="10">${result.contents}</textarea>
        </div>
        <div class="but">
          <input type="button" value="뒤로가기" class="cansle" />
          <input type="button" value="수정" class="submit" />
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
        <a href=#">청소년보호정책</a
        >
      </div>
      <div class="copyright">
        Copyright ⓒ 1999 - 2020 dcinside. All rights reserved.
      </div>
    </footer>
  </body>
</html>