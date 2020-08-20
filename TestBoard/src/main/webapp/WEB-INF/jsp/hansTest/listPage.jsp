<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="text-center">
               <ul class="pagination">
               
               <c:if test="${pageMaker.prev}">
                  <li><a href="listPage?page=${pageMaker.startPage - 1}">&laquo;</a></li>
               </c:if>
               
               <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var= "idx">
                  <li <c:out value="${pageMaker.cri.page == idx?'class = active' : '' }" />>
                     <a href="listPage?page=${idx}">${idx}</a>
                  </li>
               </c:forEach>
               
               <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
                  <li><a href="listPage?page=${pageMaker.endPage + 1 }">&raquo;</a></li>
               </c:if>
               
               </ul>
            </div>
</body>
</html>