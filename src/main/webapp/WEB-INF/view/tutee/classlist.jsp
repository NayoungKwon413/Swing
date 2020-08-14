<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업중인목록</title>
<link href="${path}/assets/css/tutee.css" rel="stylesheet">
<script type="text/javascript">

</script>
<style type="text/css">
a:hover {
	text-decoration:none;
}
.title-box #class_status .select{
	color:red;
	font-weight: bold;
}

</style>
</head>
<body>
<section>
	<div class="container">
		<div class="title-box">
			<h1>수강목록</h1>
			<ul id="class_status">
				<li><a href="classlist.shop?state=1" <c:if test="${state==1}">class="select"</c:if> >수강중</a></li>
				<li><a href="classlist.shop?state=2" <c:if test="${state==2}">class="select"</c:if>>수강완료</a></li>
			</ul>
		</div>
		<div class="my-class-list">
		<c:if test="${classnum==0}">수강중인 수업이 없습니다.</c:if>
		<c:forEach var="course" items="${classlist}" varStatus="status">
			<div class="class-box">
				<div class="profile_box">
					<div class="profile" style="background-image: url('')"></div>
					<div class="name">${course.tutor} 튜터</div>
				</div>
				<div class="information-box">
					<h3><a href="${path}/class/detail.shop?classid=${course.classid}">${course.subject}</a></h3>
					<div class="start-box">
						<font>${course.location1} ${course.place}</font>						
					</div>
					<div class="start-box">
						<font class="class-type">
							<c:if test="${course.type==1}">원데이 수업</c:if>
							<c:if test="${course.type==2}">${course.totaltime}회차 수업	<c:if test="${state==2}">중 ${course.classseq}회 수업 진행 예정</c:if></c:if>
						</font>
					</div>
					<div class="start-date">
						<c:if test="${state==1}" >
						수강종료일 : <fmt:formatDate value="${course.enddate}" pattern="yyyy-MM-dd" />
						</c:if>
						<c:if test="${state==2}" >
						수강기간 : <fmt:formatDate value="${course.startdate}" pattern="yyyy-MM-dd" />~
								<fmt:formatDate value="${course.enddate}" pattern="yyyy-MM-dd" />
						</c:if>
					</div>
				<c:if test="${state==2}">
					<div class="price">
						<font class="class-start"><c:forEach begin="1" end="5" varStatus="vs">
								<c:if test="${vs.current<=course.star}">★</c:if>
								<c:if test="${vs.current>course.star}">☆</c:if>
							</c:forEach>(${course.reviewnum})</font>
						<font>\</font>
						<fmt:formatNumber value="${course.totalprice}" type="currency"/>
					</div>
					<div class="btn-box">
					<a href="javascript:reviewPop()"class="btn tp1">리뷰쓰기</a>
					<script>
						function reviewPop(){
							window.open('../class/review.shop','','width=500,height=600,menubar=no,status=no,toolbar=no')
						}
					</script>
					</div>
				</c:if>
				</div>
			</div>	
		</c:forEach>
		</div>
	</div>
</section>
</body>
</html>