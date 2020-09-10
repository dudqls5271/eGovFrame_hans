<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${not empty sessionScope.sessionId}">
  <div class="user_contariner">
      <div class="user_name">
        <h4 class="user_name_in">
          <strong>${sessionNick}(${sessionId})</strong>님 <br />반갑습니다
        </h4>
        <div class="user_nav">
          <a href="#" class="log">로그 |</a>
          <a href="#" class="like">즐겨찾기 |</a>
          <a href="#" class="bell">알림 |</a>
          <a href="#" id="logout">로그아웃</a>
        </div>
      </div>
	</div>
</c:if>

<c:if test="${empty sessionScope.sessionId}">
  <div class="user_contariner">
      <div class="user_name">
        <h4 class="user_name_in">
          <strong><a href="/test/login.do">로그인을 해 주시기 바랍니다.</a></strong>
        </h4>
        <div class="user_nav">
          <a href="#" class="log">로그 |</a>
          <a href="#" class="like">즐겨찾기 |</a>
          <a href="#" class="bell">알림 |</a>
        </div>
      </div>
	</div>
</c:if>
