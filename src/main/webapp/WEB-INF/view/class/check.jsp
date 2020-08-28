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
					<li style="color:#49b5e7">01일정/장소</li>
					<span>></span>
					<li>02결제</li>
					<span>></span>
					<li>03완료</li>
				</ul>
			</div>
			<div class="class_title">
				${cls.subject}
			</div>
			<div class="apply">
				<div class="profile_box">
					<div class="profile" style="background-image:url('${path}/assets/img/${tutor.file}')"></div>
					<p class="triangle-border top gray" style="margin-top:50px; text-align:center;">
						수업에 오신걸 환영해요!<br>
						<span>장소, 수업일, 시간</span>을<br>
						 선택해주세요
					</p>
				</div>
				<div class="sh_box class_price">
					<div class="head">
					<img src="${path}/assets/img/icon/calendar.png">
						원하시는 수업 일정을 선택해주세요
					</div>
					<div class="regions">
						<div class="region" id="region">
							<c:forEach items="${clsinfo}" var="info">
								<div class="option">
									<div class="top">
										<label><input type="hidden" class="no" value="${info.classno}"></label>
										<div class="text">
											<%--<fmt:formatDate value="${info.date}" var="date" pattern="MM.dd (E)"/>--%>
											<fmt:parseDate value="${info.starttime}" var="starttime" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${starttime}" var="start" pattern="HH:mm"/>
											<fmt:parseDate value="${info.endtime}" var="endtime" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${endtime}" var="end" pattern="HH:mm"/>
											${info.date} ${start}~${end}
											<span>|</span>
											<font>${cls.location2}</font>
										</div>
									</div>
									<div class="region2">
										상세지역: ${info.place}
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					$(function(){
						var classno=0;
						$(".region2").hide();
						$(".top").on("click","label",function(){
							$(".region2").hide();
							$(".top label").removeClass("on");
							$(this).addClass("on");
							var index = $("label").index(this);
							$(".region2:eq("+index+")").show();
							classno = $(".no:eq("+index+")").val();
						})
						$("#nextButton").click(function(){
							location.href="apply.shop?classid=${param.classid}&classno="+classno;
						})
					})
				</script>
			</div>
			<div id="nextButton" class="next button">신청서 작성하러가기</div>
		</div>
	</div>
</section>
</body>
</html>