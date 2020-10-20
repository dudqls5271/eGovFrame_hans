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
			
			if(this.rno == this.rnolevel) {
				$(data).each(
						function() {
							str += this.rno + ":<ul id='"+this.rno+"'><li data-rno='"+this.rno+"' class='replyLi'>"
							+ "<span class='replyClass'>"+this.replytext + "</span><input type='button' value='MOD' class='but'>"
							+ "<div id='replylevel' style='display: none;'></br>"
							+ 	"REPLYER<input type='text'></br>"
							+	"replytext<input type='text'></br>"
							+ 	"rno<input type='text'value='"+this.rno+"'>"
							+ "<button id='replyAnd'>ok</button>"
							+ "</div>"
							+ "</li>"
							+ "</ul>"
				});	
			}
			
			$("#reply").html(str);
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
						alert("등록")
						
						$.getJSON("/reply/all/" + bno + ".do", function(data) {
							var str = "";
							console.log($(data).length);
							
							$(data).each(
								function() {
									str += this.rno + ":<ul id='"+this.rno+"'><li data-rno='"+this.rno+"' class='replyLi'>"
									+ "<span class='replyClass'>"+this.replytext + "</span><input type='button' value='MOD' class='but'>"
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
									+ "<span class='replyClass'>"+this.replytext + "</span><input type='button' value='MOD' class='but'>"
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
									+ "<span class='replyClass'>"+this.replytext + "</span><input type='button' value='MOD' class='but'>"
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
				console.log(bno,replyer,replytext,replyrno);
				
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
							
							$.getJSON("/reply/all/" + bno + ".do", function(data) {
								var str = "";
								console.log($(data).length);
								
								$(data).each(
									function() {
										str += this.rno + ":<li data-rno='"+this.rno+"' class='replyLi'>"
										+ "<span class='replyClass'>"+this.replytext + "</span><input type='button' value='MOD' class='but'>"
										+ "<div id='replylevel' style='display: none;'></br>"
										+ 	"REPLYER<input type='text'></br>"
										+	"replytext<input type='text'></br>"
										+ 	"rno<input type='text'value='"+this.rno+"'>"
										+ "<button id='replyAnd'>ok</button>"
										+ "</div>"
										+ "</li>"
									});
								
								ulObj.html(str);
							});
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
			rno<input type="text" name="replyrno" id="replyrno" value="${result + 1}">
		</div>
		<button id="replyAddBtn">ok</button>
	</div>
	
	<div id = "reply">
	</div>
	
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