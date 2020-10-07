<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var bno = 1234;
		$.getJSON("/reply/all/" + bno + ".do", function(data) {
			var str = "";
			console.log($(data).length);
			
			$(data).each(
				function() {
						str += "<li data-rno='"+this.rno+"' class='replyLi'>"
							+ this.rno + ":" + this.replytext +"<button>MOD</button>"
							+ "</li>"
				});
			
			$("#reply").html(str);
		});
		
		$("#replyAddBtn").on("click", function() {
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			
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
					replytext : replytext
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("등록")
						
						$.getJSON("/reply/all/" + bno + ".do", function(data) {
							var str = "";
							console.log($(data).length);
							
							$(data).each(
								function() {
										str += this.rno + ":" + "<li data-rno='"+this.rno+"' class='replyLi'>"
											+ this.replytext +"<button>MOD</button>"
											+ "</li>"
								});
							
							$("#reply").html(str);
						});
					}
				}
			});
		});
		
		$("#reply").on("click", ".replyLi button", function() {
			var reply = $(this).parent();
			
			var rno = reply.attr("data-rno");
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
										str += this.rno + ":" + "<li data-rno='"+this.rno+"' class='replyLi'>"
											+ this.replytext +"<button>MOD</button>"
											+ "</li>"
								});
							
							$("#reply").html(str);
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
						
					}
				}
			});
		});
		
		
	});
	
</script>
</head>
<body>
	<h2>AjaxTest</h2>
	<div>
		<div>
			REPLYER<input type="text" name="replyer" id="newReplyWriter">
		</div>
		
		<div>
			REPLYER<input type="text" name="replytext" id="newReplyText">
		</div>
		<button id="replyAddBtn">ok</button>
	</div>
	<ul id = "reply">
	</ul>
	
	<div id="modal-title"></div>
	<div>
		<input type="text" id="replytext">
	</div>
	<div>
		<button type="button" id="replyModBtn">수정</button>
		<button type="button" id="replyDeleteBtn">삭제</button>
		<button type="button" id="colseBtn">닫기</button>
	</div>
</body>
</html>