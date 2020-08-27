<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${pagMaker.prev}">
				<li><a href="listpage?page=${pageMaker.startPage - 1 }"></a></li>
			</c:if>
			
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endpage }" var="idx">
			<li <c:out value="${pageMaker.cri.page == idx? 'class =active ':'' }"/>>
				<a href="listPage?Page=${idx} ">${idx}</a>
			</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endpage > 0 }">
			<li><a href="listPage?page=${pageMaker.endPage + 1 }">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
	
