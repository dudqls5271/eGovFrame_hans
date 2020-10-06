<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
	 <div class="input">
  		<div>
		  	<select name="searchType" id="select">
		   		<option value="tcw"> <c:out value="${cri.searchType == 'tcw'?'selected ':''}"/>
						전체
		   		</option>
		   		
		   		<option value="t"> <c:out value="${cri.searchType == 't'?'selected ':''}" />
						제목
		   		</option>
		   		
		   		<option value="c"> <c:out value="${cri.searchType == 'c'?'selected ':''}"/>
						내용
		   		</option>
		   		
		   		<option value="w" >
		   			<c:out value="${cri.searchType == 'w'?'selected ':''}"/>
						글쓴이
		   		</option>
		   		
		   		<option value="tc" > <c:out value="${cri.searchType == 'tc'?'selected ':''}"/>
						제목 + 내용
		   		</option>
		   	</select>
  			<input type="text" id="keywordInput">
  			<i class="fas fa-search" id="search" ></i>
  		</div>
  	</div>