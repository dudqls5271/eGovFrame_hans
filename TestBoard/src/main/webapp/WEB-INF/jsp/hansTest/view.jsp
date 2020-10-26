<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"> 
	
    <link href="<c:url value='/css/view.css'/>" rel="stylesheet" type="text/css">
    <script type="text/javascript" charset="utf-8" src="/smartEditor/js/HuskyEZCreator.js"></script>
<script>
	$(document).ready(function() {
		$(".modfiy").click(function() {
			var frmFrom = $("#frm");
			console.log(frmFrom);
			frmFrom.attr("action", "/test/pw_ch.do").attr("method","get");
			frmFrom.submit();
		});
		
		$(".delete").click(function() {
// 			var inputString = prompt('비밀번호를 입렵해주세요', '비밀번호 입력'); 
// 			alert(inputString);
			 $( "#dialog" ).dialog();
		})
		
		
		
		
		
// 		--------------------------------------------[reply]------------------------

		var bno = $("#seqno").val();
		
		$.getJSON("/reply/all/" + bno + ".do", function(data) {
			var str = "";
			var str_reply = "";
			console.log(bno);
			console.log($(data).length);
			
				$(data).each(function() {
					
					var ulObj = this.rno
					console.log (ulObj);
					
					if (this.level == 0){
						str = "<ul id='"+this.rno+"'>"
						+ "<div class= 'first_reply'>"
						+ "<li data-rno='"+this.rno+"' class='replyLi'>"
						+ "<div class='replyer'>"
						+ "<span class='reply_writer'>"+this.replyer+":</span>"
						+ "</div>"
						+ "<p class='replyClass'>"+this.replytext + "</p>"
						+ "<span class='replydate'>"+this.regdate + "</span>"
						+ "<div id='replylevel' style='display: none;'></br>"
						+ 	"REPLYER<input type='text'></br>"
						+	"replytext<input type='text'></br>"
						+ 	"rno<input type='text'value='"+this.rno+"'>"
						+ "<button id='replyAnd'>ok</button>"
						+ "</div>"
						+ "</li>"
						+ "</div>"
						+ "</ul>";
						
						$("#reply").html($("#reply").html() + str);
					}else if (this.level == 1) {
						var replyRnoLevel = this.rnolevel;
						var replyRno = this.rno;
						var replyText = this.replytext;
						var replyer = this.replyer;
						var regdate = this.regdate;
						
						$("#reply").find("ul").each(function(){
							if(replyRnoLevel == this.id){
								str = "<div class = 'reply_reply'>"
								+ "<li data-rno='"+replyRno+"' class='replyLi'>"
								+ "<div class='replyer'>"
								+ "<span class='reply_writer'>" +replyer+":</span>"
								+ "</div>"
								+ "<span class='replyClass'><span>└</span> "+replyText + "</span>"
								+ "<span class='replydate_reply'>"+regdate + "</span>"
								+ "<div id='replylevel' style='display: none;'></br>"
								+ 	"REPLYER<input type='text'></br>"
								+	"replytext<input type='text'></br>"
								+ 	"rno<input type='text'value='"+replyRnoLevel+"'>"
								+ "<button id='replyAnd'>ok</button>"
								+ "</div>"
								+ "</li>";
								+ "</div>"
								this.innerHTML = this.innerHTML + str;
							}
						});
						
						
// 						$(ulid).html($(ulid).html() + str);
					}								
				});	
		});
		
		$("#replyAddBtn").on("click", function(data) {
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			var replyrno = $("#replyrno").val();
			
			$.ajax({
				type : 'post',
				url : '/reply/reply.do',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify ({
					bno : bno,
					replyer : replyer,
					replytext : replytext,
					level : 0,
					rnolevel : replyrno
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("등록");
						
						str = replyrno + ":<ul id='"+replyrno+"'><li data-rno='"+replyrno+"' class='replyLi'>"
						+ "<span>"+replyer+":</span>"
						+ "<span class='replyClass'>"+replytext + "</span>"
						+ "<div id='replylevel' style='display: none;'></br>"
						+ 	"REPLYER<input type='text'></br>"
						+	"replytext<input type='text'></br>"
						+ 	"rno<input type='text'value='"+replyrno+"'>"
						+ "<button id='replyAnd'>ok</button>"
						+ "</div>"
						+ "</li>"
						+ "</ul>";
						
						$("#reply").html($("#reply").html() + str);
					}
				}
			});
			location.reload();
		});
		
		$("#reply").on("click", ".replyLi .replyClass", function() {
			alert("부탁한다");
			$(this).next().next().css ({	
				display: "inline"
			});
		});
		
		$("#reply").on("click", ".replyLi .but", function() {
			var reply = $(this).prev();
			
			var rno = reply.parent().attr("data-rno");
			var replytext = reply.text();
			
			$("#modal-title").html(rno);
			$("#replytext").val(replytext);
			
			alert(rno + ":" + replytext);
		});
		
		$("#replyDeleteBtn").on("click", function() {
			
			var rno = $("#modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'delete',
				url : '/reply/'+ rno +'.do',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					if (result == 'SUCCESS') {
						alert("삭제");
						$.getJSON("/reply/all/" + bno + ".do", function(data) {
							var str = "";
							console.log($(data).length);
							
							$(data).each(
								function() {
									str += this.rno + ":<ul id='"+this.rno+"'><li data-rno='"+this.rno+"' class='replyLi'>"
									+ "<span class='replyClass'>"+this.replytext + "</span>"
									+ "<div id='replylevel' style='display: none;'></br>"
									+ 	"REPLYER<input type='text'></br>"
									+	"replytext<input type='text'></br>"
									+ 	"rno<input type='text'value='"+this.rno+"'>"
									+ "<button id='replyAnd'>ok</button>"
									+ "</div>"
									+ "</li>"
									+ "</ul>"
								});
							
							$("#reply").html(str);
					        locaction.reload();
						});
					}
				}
			});
		});
		
		$("#replyModBtn").on("click", function () {
			var rno = $("#modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'put',
				url : '/reply/'+ rno +'.do',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"},
				data:JSON.stringify({replytext:replytext}),
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					if (result == 'SUCCESS') {
						alert("수정");
						
						$.getJSON("/reply/all/" + bno + ".do", function(data) {
							var str = "";
							console.log($(data).length);
							
							$(data).each(
								function() {
									str += this.rno + ":<ul id='"+this.rno+"'><li data-rno='"+this.rno+"' class='replyLi'>"
									+ "<span class='replyClass'>"+this.replytext + "</span>"
									+ "<div id='replylevel' style='display: none;'></br>"
									+ 	"REPLYER<input type='text'></br>"
									+	"replytext<input type='text'></br>"
									+ 	"rno<input type='text'value='"+this.rno+"'>"
									+ "<button id='replyAnd'>ok</button>"
									+ "</div>"
									+ "</li>"
									+ "</ul>"
								});
							
							$("#reply").html(str);
						});

					}
				}
					
			});
			
		});
		
		
	$(document).on("click","#replyAnd", function(data) {
				var ulObj = $(this).parent().parent().parent();
				var replyer = $(this).prev().prev().prev().prev().prev().val();
				var replytext = $(this).prev().prev().prev().val();
				var replyrno = $(this).prev().val();
				
				$.ajax({
					type : 'post',
					url : '/reply/reply.do',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'text',
					data : JSON.stringify ({
						bno : bno,
						replyer : replyer,
						replytext : replytext,
						level : 1,
						rnolevel : replyrno
					}),
					success : function(result) {
						if (result == 'SUCCESS') {
							alert("등록 등록")
							str = replyrno + ":<li data-rno='"+replyrno+"' class='replyLi'>"
							+ "<span>"+replyer+":</span>"
							+ "<span class='replyClass'>"+replytext + "</span>"
							+ "<div id='replylevel' style='display: none;'></br>"
							+ 	"REPLYER<input type='text'></br>"
							+	"replytext<input type='text'></br>"
							+ 	"rno<input type='text'value='"+replyrno+"'>"
							+ "<button id='replyAnd'>ok</button>"
							+ "</div>"
							+ "</li>";
							
							ulObj.html(ulObj.html() + str);
						}
					}
			});
		});
	});
</script>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <c:import url="/test/header.do" charEncoding="UTF-8"></c:import>
    <ul class="nav">
      <li style="border: 0px; font-size: 16px;"><b class="pk">개시판 +</b></li>
      <li style="border: 0px; font-size: 16px;"><b>메인</b></li>
      <li style="border: 0px; font-size: 16px;"><b>게시판2</b></li>
      <li style="border: 0px; font-size: 16px;"><b>개시판3</b></li>
    </ul>
    <div class="header_c">
      <b>개시판</b>
    </div>
    <div class="title">
      <span class="title_c"><h3>${result.title}</h3></span>
      <div class="writer">
        <span class="user_id">${result.writer}</span> |
        <span class="date">${result.regdate}</span>
      </div>
    </div>
    <form action="/test/modify.do" id="frm">
    	<input type="hidden" value="${result.seqno}" name="seqno" id="seqno" >
    </form>
    <div class="content">
      <div class="cont">
        <c:forEach items="${fullNameList}" var="vo">
        	<c:if test="${vo.fullname != 'no'}">
        		<c:set var = "string1" value = "${vo.fullname}"/>
    			<c:set var = "length" value = "${fn:length(string1)}"/>
    			<c:set var = "string2" value = "${fn:substring(string1, length -3, length)}" />
    				<c:if test="${string2 != 'png' && string2 != 'jpg' && string2 != 'gif' && string2 != 'jpeg'}">
    					<p></p>
    				</c:if>
    				
    				<c:if test="${string2 == 'png' || string2 == 'jpg' || string2 == 'gif' || string2 == 'jpeg'}">
	        			<a href="displayFile.do?fileName=${vo.fullname}" target="_blank"><img src="displayFile.do?fileName=${vo.fullname}"></a>
	        		</c:if>
	        	</c:if>
	        </c:forEach>
	  
        ${result.contents}
      </div>
      <div class="file">
        <span class="file_text"><b>원본 첨부파일</b></span>
        <ul class="fileUpload">
        	<c:forEach items="${fullNameList}" var="vo">
          <li><a href= "displayFile.do?fileName=${vo.fullname}" target="_blank"> ${vo.oriname} | </a></li>
          </c:forEach>
        </ul>
      </div>
		<div class="reply_spaes">
			<p>전체 리플</p>
			<div id = reply>
			</div>
			
		<div class="reply_text_area">
				<div class="user_id_and_pw">
					<div class="input_text">
						<input type="text" class="input_text_user"  name="replyer" id="newReplyWriter">
					</div>
					<div class="input_text">
						<input type="text" class="input_text_user" name="replyrno" id="replyrno" value="${result_re + 1}">
					</div>
				</div>		
		<div class="text_area">
			<div class="writer_reply">
				<textarea class="reply_add" name="replytext" id="newReplyText"></textarea>
			</div>
			
			<div class="reply_add_but">
				<input type="button" value="등록" class="reply_but" id="replyAddBtn">
				<input type="button" value="등록+추천" class="reply_but_bs">
			</div>	
		</div>
	</div>
<!-- 	----------------------------------[re]-------------------------- -->
		<div class="button">
			<input type="button" value="수정" class="modfiy"> 
			<input type="button" value="삭제" class="delete"> 
			<input type="button" value="글쓰기" class="writer_re">
		</div>
	</div>

  </body>
</html>