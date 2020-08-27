<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<link href="${path}/assets/css/user-style.css" rel="stylesheet">
<style type="text/css">
i{
padding-right: 2px;
    color: #49b5e7;
    font-size: 18px;
    line-height: 1;
}

a{


color: #777777;
    transition: 0.3s;
    display: inline-block;
    line-height: 1;
}

.div{
  font-size: 16px;
  color: #fff;
  line-height: 1;
  padding: 50px 0;
  text-align: center;
  width: 100%;
  transition: 0.3s;
}
</style>
</head>
<body>
	<section class="login d-flex align-items-center">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-3">
            <h4>로그인</h4>
            <p></p>
            
			<form:form modelAttribute="user" method="post" action="login.shop">
				<spring:hasBindErrors name="user">
					<font color="red">
						<c:forEach items="${errors.globalErrors}" var="error">
							<spring:message code="${error.code}">
							</spring:message></c:forEach>
					</font>
				</spring:hasBindErrors>
              <form:input path="userid" type="text" name="userid" placeholder="아이디"/>
              	<font color="red"><form:errors path="userid"/></font>
              <form:password path="pass" tpye="password" name="pass" placeholder="비밀번호"/>
              	<font color="red"><form:errors path="pass"/></font>
            <input class="bnt" type="submit" value="로그인">
			</form:form>
            <div class="div">
	          <i class="bx bx-chevron-right"></i> <a href="join.shop">회원가입</a>
	          <i class="bx bx-chevron-right"></i> <a href="find.shop">ID/PW찾기</a>
            </div>
          </div>
        </div>
      </div>
      </section>
</body>
</html>