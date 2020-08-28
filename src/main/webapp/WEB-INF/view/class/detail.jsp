<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 세부 사항</title>
<link href="${path}/assets/css/classdetail.css" rel="stylesheet">
<style>
	section {
    height: 200em;
	}
	.reviewOption {
	text-align:right;
	}
</style>
<script>
function reviewPop(url){
	window.open(url,'','width=500,height=600,menubar=no,status=no,toolbar=no')
}
</script>
</head>
<body>
<section>
	<div class="container">
		<div class="class_wrap">
			<div class="class_price" id="class_price" style="position:relative; top:0px;; left:0px;">
				<div class="regions">
					<div class="title">
					<c:if test="${cls.type==1}">원데이 클래스</c:if>
					<c:if test="${cls.type==2}">다회차 수업</c:if>
					</div>
					<div class="region" id="region" style="height:20em;">
						<c:forEach items="${clsinfo}" var="info" varStatus="status">
							<c:if test="${status.count<=3}">
								<div class="option">
							</c:if>
							<c:if test="${status.count>3}">
								<div class="option extra">
							</c:if>
									<div class="top">
										<div class="timedetail">
											<fmt:parseDate var="infodate" value="${info.date}" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${infodate}" var="date" pattern="MM.dd (E)"/>
											<div class="indate">${date}</div>
											<fmt:parseDate value="${info.starttime}" var="starttime" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${starttime}" var="start" pattern="HH:mm"/>
											<fmt:parseDate value="${info.endtime}" var="endtime" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${endtime}" var="end" pattern="HH:mm"/>
											${start}~${end}
										</div>
										<span>|</span>
										<div class="region_name">${cls.location2}</div>
										<span class="drop"><img src="${path}/assets/img/icon/drop.png"></span>
									</div>
									<div class="region2">
										상세지역:${info.place}
									</div>
								</div>
						</c:forEach>
				</div>
				<script>
					$(function(){
						$(".option.extra").hide();
						$(".region2").hide();
						
						$(".drop").on("click","img",function(){
							$(".region2").hide();
							var index = $("img").index(this);
							var idx = index-1;
							$(".region2:eq("+idx+")").toggle();
						})
						$("#more").click(function(){
							$(".option.extra").show();
						})
					})
				</script>
				<div class="more" id="more">
					+ 다른 일정 더보기
				</div>
			</div>
			<!-- 여기까지 날짜,시간,장소 정보 -->
			<a onclick="window.open('${path}/talk/newchat.shop?classid=${param.classid}','','width=500,height=650')" class="btn_talk">실시간 톡</a>
			<div class="btn_payment">
				<a href="check.shop?classid=${param.classid}">
					<span class="btntxt" id="checkbt">수업 신청하기</span>
				</a>
			</div>
			<div class="price">
				<div class="hp1">
					<b>₩${cls.price}원</b>/시간
				</div>
				<div class="tp1">₩${cls.totalprice}/총 ${cls.totaltime}회 ${cls.time}시간</div>
			</div>
		</div>
		<!-- 상단 이미지 부분 -->
		<div class="class_img">
			<img src="http://${server}:${port}${path}/class/coverimg/${cls.classid}_${cls.coverimg}">
		</div>
		<div class="class_d_wrqp">
			<div id="class_navi" class="class_navi fixedLayer" style="left:0px;">
				<ul>
					<li>
						<a href="javascript:Move('summary')">요약</a>
					</li>
					<li>
						<a href="javascript:Move('tutor')">튜터</a>
					</li>
					<li>
						<a href="javascript:Move('Introduction')">수업정보</a>
					</li>
					<li>
						<a href="javascript:Move('review')">리뷰</a>
					</li>
				</ul>
			</div>
			<script type="text/javascript">
				function Move(section){
					var offset = $("#"+section).offset();
					$('html,body').animate({scrollTop:offset.top},400);
				}
				
				$(function(){
					$('#wishBtn').click(function(){
						$.ajax("${path}/class/checkwishlist.shop?classid=${param.classid}",{
							success:function(data){
								console.log(data);
								//alert(data);
								if(data==0){
									$('#heart').attr("src",'${path}/assets/img/icon/heart_on.png')
								}else{
									$('#heart').attr("src",'${path}/assets/img/icon/heart.png')
								}
							}
						})
					})
				})
			</script>
			<div class="class_detail" id="sumary">
				<div class="class_name">
					<div class="tutor_img">
						<img alt="" src="${path}/assets/img/${tutor.file}">
					</div>
					<div class="name">${tutor.name}</div>
				</div>
				<div class="class_title">
					<div class="title">${cls.subject}</div>
					<a id="wishBtn" class="bnt_wishlist">
					<c:if test="${cls.wish==0}">
					<img id="heart" src="${path}/assets/img/icon/heart.png">찜하기</a>
					</c:if>
					<c:if test="${cls.wish==1}">
					<img id="heart" src="${path}/assets/img/icon/heart_on.png">찜하기</a>
					</c:if>
					<div class="info">
						<a class="starimg">
							<input type="hidden" id="Avg" value="${cls.staravg}">
							<span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						    <span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						    <span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						   <span class="star star_left"></span>
						   <span class="star star_right"></span>
						
						   <span class="star star_left"></span>
						   <span class="star star_right"></span>
						  <font style="vertical-align: inherit;position: relative;bottom: 0.5em;">
						   (${cls.reviewcnt})
						 </font>
						</a>
					</div>
					<div class="info">
						<ul>
							<li class="ar" id="regionAll">
								<img src="${path}/assets/img/icon/marker2.png">
								${cls.location2}</li>
							<li class="hu">
								<img src="${path}/assets/img/icon/clock.png" style="margin: 0 1.2em;">
								<font color="#49b5e7">${cls.time}</font>시간/
								<c:if test="${cls.totaltime!=1}">${cls.totaltime}</c:if>회</li>
							<li class="gr">
								<img src="${path}/assets/img/icon/people.png" style="margin: 0 2.1em;">
								<c:if test="${cls.maxtutee==1}">1:1수업</c:if>
								<c:if test="${cls.maxtutee>1}">
									최대인원<font color="#49b5e7">2~${cls.maxtutee}명</font>
								</c:if>
							</li>
							<li class="ohu">
								<img src="${path}/assets/img/icon/won2.png" style="margin: 0 2em;">
								<font color="#49b5e7">￦${cls.price}</font>/시간</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="tutorinfo">
				<div class="section01" id="tutor">
					<h1>튜터정보</h1>
					<div class="cert">
						<ul>
							<li class="com">${tutor.school}대학교 ${tutor.major}</li>
							<c:if test="${license!=null}">
								<c:forEach items="${license}" var="lc">
									${lc.lctitle}
								</c:forEach>
							</c:if>
						</ul>
					</div>
					<div class="d_info">
						${cls.tutorintro}
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="Introduction">
				<div class="section01">
					<h1>수업소개</h1>
					<div class="d_info">
						${cls.classintro}					
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="review">
				<div class="section01">
					<h1>리뷰(${fn:length(review)} )</h1>
					<c:if test="${classno!=0}">
					<a href="javascript:reviewPop('review.shop?classid=${param.classid}&classno=${classno}')"class="btn_st" id="btn-write-review">리뷰쓰기</a>
					</c:if>
					<div class="review_box">
							<span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						    <span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						    <span class="star star_left"></span>
						    <span class="star star_right"></span>
						
						   <span class="star star_left"></span>
						   <span class="star star_right"></span>
						
						   <span class="star star_left"></span>
						   <span class="star star_right"></span> 
						   <fmt:formatNumber value="${cls.staravg}" var="staravg" pattern=".0"/>
						   <p>${staravg}</p>
					</div>
					<script type="text/javascript">
						$(function(){
							var idx = $('#Avg').val()/0.5;
							for(var i=0; i<idx; i++){
								$(".star").eq(i).addClass("on");
								$(".review_box .star").eq(i).addClass("on");
							}
						})
					</script>
					<div class="review_list">
						<ul>
							<div id="innerReviewDiv">
								<c:if test="${cls.reviewcnt==0}">등록된 리뷰가 없습니다.</c:if>
								<c:if test="${cls.reviewcnt!=0}">
									<c:forEach items="${review}" var="re" varStatus="status">
										<li>
											<div class="review">
												<div class="profilebox">
													<div class="profile">
														<img alt="" src="../user/save/${re.userid}_${re.file}">
													</div>
													<div class="name">
														${re.name}
													</div>
												</div>
											<c:if test="${re.userid == sessionScope.loginUser.userid}">
												<div class="reviewOption">
													<a href="javascript:reviewPop('reviewEdit.shop?reviewno=${re.reviewno}')">수정</a> |
													<a href="reviewDelete.shop?reviewno=${re.reviewno}">삭제</a>
												</div>
											</c:if>
												<div class="review_content">
													<div class="content">
														${re.content}
													</div>
													<fmt:formatDate value="${re.regdate}" var="regdate" pattern="yyyy-MM-dd HH:mm:ss"/>
													<div class="date">${regdate}</div>
												</div>
											</div>
										</li>
									</c:forEach>
								</c:if>
							</div>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</section>
</body>
</html>