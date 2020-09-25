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
    
<script type="text/javascript" charset="utf-8" src="/smartEditor/js/HuskyEZCreator.js"></script>

<script>
$(document).ready(function() {	
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
			});
</script>
</head>
<body>
	<textarea style="width:99%;height:200px;" maxlength="500" name="educontent" id="educontent"></textarea>
</body>
</html>