<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/assets/css/apply.css" rel="stylesheet">
</head>
<body>
<section>
	<div class="container">
		<div class="tutor_cont">
			<div class="title_box">
				<h1>수업신청</h1>
				<ul>
					<li>01일정/장소</li>
					<span>></span>
					<li>02결제</li>
					<span>></span>
					<li style="color:#49b5e7">03완료</li>
				</ul>
			</div>
			<div class="class_title">
				클래스 제목
			</div>
			<div class="success">
				<h1>결제가 완료되었습니다.</h1>
			</div>
			<div id="nextButton" class="next button" onclick="location.href='classlist.shop'">수업목록</div>
		</div>
	</div>
</section>
</body>
</html>