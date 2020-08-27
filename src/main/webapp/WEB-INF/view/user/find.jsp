<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호아이디찾기</title>
<link href="${path}/assets/css/user-style.css" rel="stylesheet">
</head>
<body>
<section id="services" class="services section-bg">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-4 col-md-6" data-wow-delay="0.1s">
            <div class="icon-box">
              <div class="icon"><i class="las la-file-alt" style="color: #3fcdc7;"></i></div>
              <h4 class="title"><a href="">아이디 찾기</a></h4>
              <p class="description">가입된 아이디를 알려드려요.</p>
	          <form:form method="post" action="findid.shop"  enctype="multipart/form-data">
	              <c:if test="${param.userid==null || param.userid.equals('')}">
	              <input type="text" name="email" placeholder="가입된 이메일을 입력해주세요.">
	              </c:if>
	              <c:if test="${param.userid!=null && !param.userid.equals('')}">
	              <p class="description"><br>가입된 아이디는<br> ${param.userid} 입니다.</p>
	              </c:if>
            	  <button class="bnt" type="submit">확인</button>
	          </form:form>
            </div>
          </div>
          <div class="col-lg-4 col-md-6" data-wow-delay="0.1s">
            <div class="icon-box">
              <div class="icon"><i class="las la-book" style="color:#41cf2e;"></i></div>
              <h4 class="title"><a href="">비밀번호 찾기</a></h4>
              <p class="description">이메일로 임시 비밀번호를 보내드려요.
              <form:form method="post" action="findpw.shop"  enctype="multipart/form-data">	  
              	  <c:if test="${param.email==null || param.email.equals('')}">
              	  <input type="text" name="id" placeholder="가입된 아이디를 입력해주세요.">
	              <input type="text" name="email" placeholder="가입된 이메일을 입력해주세요.">
	              </c:if>
	              <c:if test="${msg.equals('입력')}">
	              	아이디 또는 이메일을 입력해주세요.
	              </c:if>
	              <c:if test="${param.email!=null && !param.email.equals('')}">
	              <p class="description"><br>${param.email}로<br>임시 비밀번호를 보냈습니다.</p>
	              </c:if>
	              <button class="bnt" type="submit">확인</button>
	          </form:form>
	          </p>
            </div>
          </div>
        </div>

      </div>
    </section>
</body>
</html>