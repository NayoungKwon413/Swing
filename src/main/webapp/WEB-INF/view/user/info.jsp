<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보페이지</title>
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
<style type="text/css">
hr{
	margin: 50px 0px; 
}
.title{
  font-size: 14px;
  line-height: 26px;
  color: #777777;
  font-weight: 700;
}
.title-300{
	margin-bottom: 300px;
}
.title-250{
	margin-bottom: 250px;
}
.title-200{
	margin-bottom: 200px;
}
.title-100{
	margin-bottom: 100px;
}
.title-50{
	margin-bottom: 50px;
}
.title-20{
	margin-bottom: 20px;
}

.upf_b{
	position: absolute;
	margin-left:95px;
	margin-top:90px;
}
.upf{
	width:130px;
	height:130px;
	border-radius:50%;
	background-position:center;
	background-size:cover;
}
.costbox{
	background-color: #d6d6d6;
	width:400px; height:150px; border: 1px c7c7c7; border-radius: 7px;
}
.costbox > p{
}

</style>
</head>
<body>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="#"><h2></h2></a>
          <div style="text-align: right;">
          </div>
          <hr style="margin-top: 15px;">
          </div>
     </div>
 </section>
<section id="tutor-regi" class="tutor-regi">
<div class="container">
	<form:form modelAttribute="user" method="post" action="join.shop">
	<div class="row">
			<div class="col-lg-3">
		        <div class="info">
		          <div class="address">
		          <div id="info1"></div>
		             <i class="icofont-google-map"></i>
		               <h4>회원정보</h4>
		               <p>회원정보 조회</p>
		          </div>
		        </div>
	        </div>
		    <div class="col-lg-8 mt-5 mt-lg-0">
		    <!-- 기본정보 -->
		    <div class="form-group">
		    	<div class="title">프로필-</div>
				<div style="margin: 30px 0">				
	                <div class="upf" id="picture-cover" style="background-image:url('http://${server}:${port}${path}/user/save/${user.userid}_${user.file}')">
	                </div>
	            </div>
	        </div>
		    <div class="form-group">
				<div class="title">아이디-</div>
					${user.userid}
	        </div>
	        <div class="form-group">
				<div class="title">이름-</div>
	                ${user.name}
	        </div>
	        <div class="form-group">
				<div class="title">이메일-</div>
	              	${user.email}
	        </div>
			<hr> 
            <a href="update.shop?id=${user.userid}" style="border: none; */
    background-color: ##49b5e7;
    padding: 12px;
    background-color: #49b5e7;
    border-radius: 5px 5px 5px 5px;
    font: #ffffff;
    color: #ffffff;
    margin: 0px 10px;">수정하기</a>
          	<c:if test="${sessionScope.loginUser.userid!='admin'}">
            <a href="delete.shop?id=${user.userid}" style="border: none; */
    background-color: ##49b5e7;
    padding: 12px;
    background-color: #49b5e7;
    border-radius: 5px 5px 5px 5px;
    font: #ffffff;
    color: #ffffff;
    margin: 0px 10px;">회원탈퇴</a>
            </c:if>
	       </div>
	</div>
	</form:form>
</div>
</section>
</body>
</html>