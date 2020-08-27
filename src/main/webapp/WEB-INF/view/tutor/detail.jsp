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
</style>
<script type="text/javascript">
$(document).ready(function(){
	// 수업형태
	var type = opener.document.getElementById("typevalue").value;
	$("#title").html(type);
	// 수업인원
	var maxtutee = opener.document.getElementById("numtutee").value;
	console.log(maxtutee);
	if(maxtutee==1){
		
		$("#maxtutee").append("1:1 수업")
	}else if(maxtutee>1){
		$("#maxtutee").append("2~"+maxtutee+"명");
	}
	// 수업제목
	var subject = opener.document.getElementById("subject").value;
	$("#subject").html(subject);
	// 수업소개
	var classintro = opener.document.getElementById("classintro").value;
	$("#classintro").html(classintro);
	// 수업이미지
	var coverurl = opener.document.getElementById("imgurl2").value;
	$("#coverimgurl").attr("src", coverurl);
	// 튜터이름
	var nickname = opener.document.getElementById("nickname").value;
	$("#nickname").html(nickname);
	// 튜터이미지
	var userurl = opener.document.getElementById("imgurl1").value;
	$("#userimgurl").attr("src", userurl);
	// 튜터학력
	var school = opener.document.getElementById("school").value;
	var major = opener.document.getElementById("major").value;
	$("#school").append(school+" "+major);
	// 튜터소개
	var tutorintro = opener.document.getElementById("tutorintro").value;
	$("#tutorintro").html(tutorintro);
	// 수업장소
	var location2 = opener.document.getElementById("location2").value;
	$("#regionAll").append(location2);
	// 가격 
	var price = opener.document.getElementById("price").value;
	var html = "<b>₩"+price+"원</b>/시간";
	$("#price1").html(html);
	var time = opener.document.getElementById("time").value;
	var totaltime = opener.document.getElementById("totaltime").value;
	var totalprice = price*time*totaltime;
	html = "₩"+totalprice+"/총 "+totaltime+"회 "+time+"시간";
	$("#price2").html(html);
	html = "<font color='#49b5e7'>"+time+"</font>시간/"+totaltime+"회";
	$("#price3").append(html);
	html ="<font color='#49b5e7'>￦"+price+"</font>/시간";
	$("#price4").append(html);
	// 회차 정보
	var seqnum = opener.document.getElementById("totaltime").value;
	for(i=++seqnum;i<9;i++){
		$("#seq"+i).hide();
	}
	for(i=1;i<seqnum;i++){
		document.getElementById("title"+i).value = opener.document.getElementById("title"+i).value;
		document.getElementById("curri"+i).value = opener.document.getElementById("curri"+i).value;
	}
	

	
	
});
</script>
</head>
<body>
<section>
	<div class="container">
		<div class="class_wrap">
			<div class="class_price" id="class_price" style="position:relative; top:0px;; left:0px;">
				<div class="regions">
					<div class="title" id="title" >
					</div>
					<div class="region" id="region" style="height:20em;">
								<div class="option">
									<div class="top">
										<div class="timedetail">
											<div class="indate">08.28 (Fri)</div>
											09:00~11:00
										</div>
										<span>|</span>
										<div class="region_name">${cls.location2}</div>
										<span class="drop"><img src="${path}/assets/img/icon/drop.png"></span>
									</div>
									<div class="region2">
										상세지역:
									</div>
								</div>
					</div>
				<script>
					$(function(){
						$(".option.extra").hide();
						$(".region2").hide();

					})
				</script>
				<div class="more" id="more">
					+ 다른 일정 더보기
				</div>
			</div>
			<!-- 여기까지 날짜,시간,장소 정보 -->
			<a onclick="" class="btn_talk">실시간 톡</a>
			<div class="btn_payment">
				<a><span class="btntxt" id="checkbt">수업 신청하기</span></a>
			</div>
			<div class="price">
				<div class="hp1" id="price1">
				</div>
				<div class="tp1" id="price2">
				</div>
			</div>
		</div>
		<!-- 상단 이미지 부분 -->
		<div class="class_img">
			<!-- ****수업 이미지 -->
			<img id="coverimgurl" src="">
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
			</script>
			<div class="class_detail" id="sumary">
				<div class="class_name">
					<div class="tutor_img">
						<!-- ****튜터 이미지 -->
						<img id="userimgurl" alt="" src="">
					</div>
					<div class="name" id="nickname"></div>
				</div>
				<div class="class_title">
					<div class="title" id="subject"></div>
					<a id="wishBtn" class="bnt_wishlist">
					<img id="heart" src="${path}/assets/img/icon/heart.png">찜하기</a>
					<div class="info">
						<a class="starimg">
							<input type="hidden" id="Avg" value="">
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
						   (0)
						 </font>
						</a>
					</div>
					<div class="info">
						<ul>
							<li class="ar" id="regionAll">
								<img src="${path}/assets/img/icon/marker2.png">
							</li>
							<li class="hu" id="price3">
								<img src="${path}/assets/img/icon/clock.png" style="margin: 0 1.2em;">
							</li>
							<li class="gr" id="maxtutee">
								<img src="${path}/assets/img/icon/people.png" style="margin: 0 2.1em;">
							</li>
							<li class="ohu" id="price4">
								<img src="${path}/assets/img/icon/won2.png" style="margin: 0 2em;">
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="tutorinfo">
				<div class="section01" id="tutor">
					<h1>튜터정보</h1>
					<div class="cert">
						<ul>
							<li class="com" id="school"></li>
							<!-- ****license -->
							<c:if test="${license!=null}">
								<c:forEach items="${license}" var="lc">
									${lc.lctitle}
								</c:forEach>
							</c:if>
						</ul>
					</div>
					<div class="d_info" id="tutorintro">
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="Introduction">
				<div class="section01">
					<h1>수업소개</h1>
					<div class="d_info" id="classintro">
					</div>
					<div class="form-group" id="seqlist">
						<!-- 회차 최대 8회차 -->
						<c:forEach  begin="1" end="8" varStatus="status">
							<div id="seq${status.count}">
							<p>${status.count}회차</p>
	    					<input type="text" class="form-cont" name="title" id="title${status.count}" placeholder='회차 제목' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>
	    					<input type="text" class="form-cont" name="curri" id="curri${status.count}" placeholder='회차 상세 내용' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="class_detail detail_sec_bor" id="review">
				<div class="section01">
					<h1>리뷰(0)</h1>
					<a href=""class="btn_st" id="btn-write-review">리뷰쓰기</a>
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
						   <p>0.0</p>
					</div>
					<div class="review_list">
						<ul>
							<div id="innerReviewDiv" style="text-align: center;">
								등록된 리뷰가 없습니다.
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