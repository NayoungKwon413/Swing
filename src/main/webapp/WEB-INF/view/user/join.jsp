<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입페이지</title>
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
          <a href="#"><span style="color:#f21616;">*</span>필수 입력 정보</a>
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
		               <h4>회원가입</h4>
		               <p>회원정보 입력</p>
		          </div>
		        </div>
	        </div>
		    <div class="col-lg-8 mt-5 mt-lg-0">
		    <!-- 기본정보 -->
		    <div class="form-group">
		    	<div class="title">프로필-</div>
				<div style="margin: 30px 0">
					<img class="upf_b button" src="https://front-img.taling.me/Content/Images/tutor/Images/btn_pfimg.png">
	                <div class="upf" id="picture-cover" style="background-image:url('//img.taling.me/Content/Uploads/Profile/106bb03ba39eaf53e3243d4cc2f6575fd0328e49.jpg')">
	                	<input type="hidden" id="ProfileThumbnailUrl" value="//img.taling.me/Content/Uploads/Profile/106bb03ba39eaf53e3243d4cc2f6575fd0328e49.jpg">
	                    <input type="file" id="picture" name="picture" style="width:150px;height:130px;opacity:0;">
	                </div>
	            </div>
	        </div>
		    <div class="form-group">
				<div class="title"><span style="color:#f21616;">*</span>아이디-</div>
					<form:input path="userid" class="form-cont" name="subject" id="subject" placeholder="아이디를 입력해주세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject"/>
	                <div class="validate"></div>
	        </div>
	        <div class="form-group">
				<div class="title"><span style="color:#f21616;">*</span>이름-</div>
	                <form:input path="name" class="form-cont" name="subject" id="subject" placeholder="이름을 입력해주세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject"/>
	                <div class="validate"></div>
	        </div>
	        <div class="form-group">
				<div class="title"><span style="color:#f21616;">*</span>비밀번호-</div>
	                <form:input path="pass" class="form-cont" name="subject" id="subject" placeholder="비밀번호를 입력해주세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject"/>
	                <div class="validate"></div>
	        </div>
	        <div class="form-group">
				<div class="title"><span style="color:#f21616;">*</span>비밀번호 확인-</div>
	                <input type="text" class="form-cont" name="subject" id="subject" placeholder="비밀번호를 한번 더 입력해주세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
	                <div class="validate"></div>
	        </div>
	        <div class="form-group">
				<div class="title">이메일-</div>
	                <form:input path="email" class="form-cont" name="subject" id="subject" placeholder="이메일을 입력해주세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject"/>
	                <div class="validate"></div>
	        </div>
			<hr> 
            <button type="submit">완료</button>
	       </div>
	</div>
	</form:form>
</div>
</section>
</body>
</html>