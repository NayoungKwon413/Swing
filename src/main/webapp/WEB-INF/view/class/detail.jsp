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
	$(function(){
//		var height=$('section').height();
		var height=$('.class_wrap').height()+50;
		var cnt = $('.class_detail').length;
		for(var i=0; i<cnt; i++){
			height+=$('.class_detail:eq('+i+')').height();
		};
		$('section').height(height+"px");
		
	})
</script>
<script>
	var b_box=0;
	var boxheight=0;
	var cnt=0; 
	$(function(){
		$(".option.extra").hide();
		$(".region2").hide();
		$(".drop").on("click","img",function(){
			$('.region2').hide();
			if($('#region').hasClass('on')){
				var index = $("img").index(this);
				var idx = index-1;
				boxheight=$(".region2:eq("+idx+")").height();
				b_box=$("#region").height();
				$("#region").height(b_box-boxheight-40+"px");
				$("#region").removeClass('on');
				$(".region2:eq("+idx+")").hide();
			}else{
				var index = $("img").index(this);
				var idx = index-1;
				boxheight=$(".region2:eq("+idx+")").height()+40;
				b_box=$("#region").height();
				$("#region").height(b_box+boxheight+"px");
				$("#region").addClass('on');
				$(".region2:eq("+idx+")").show();
			}
		})
		$("#more").click(function(){
			cnt=$('.option.extra').length;
			if($(this).hasClass('on')){
				boxheight=($('.option.extra').height())*cnt;
				b_box=$("#region").height();
				$("#region").height(b_box-boxheight-40+"px");
				$(this).removeClass('on');
				$(this).html("+ 다른 일정 더보기");
				$(".option.extra").hide();			
			}else{
				boxheight=($('.option.extra').height())*cnt;
				b_box=$("#region").height();
				$("#region").height(b_box+boxheight+40+"px");
				$(this).addClass('on');
				$(this).html("- 일정 숨기기");
				$(".option.extra").show();	
			}
		})
	});
</script>
</head>
<body>
<section>
	<div class="container">
		<div class="class_wrap">
			<div class="class_price" id="class_price" style="position:relative; top:0px;; left:0px;">
				<div class="regions" style="margin-bottom: 3em;">
					<div class="title">
					<c:if test="${cls.type==1}">원데이 클래스</c:if>
					<c:if test="${cls.type==2}">다회차 수업</c:if>
					</div>
					<div class="region" id="region" style="/*height:20em;*/">
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
										<div class="timedetail">
										<c:if test="${info.list!=null}">									
											<c:forEach items="${info.list}" var="list">
											<fmt:parseDate var="infodate2" value="${list.date}" pattern="yyyy-MM-dd" />
											<fmt:formatDate value="${infodate2}" var="date2" pattern="MM.dd (E)"/>												
												<div class="indate">${date2}</div>
											<fmt:parseDate value="${list.starttime}" var="starttime2" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${starttime2}" var="start2" pattern="HH:mm"/>
											<fmt:parseDate value="${list.endtime}" var="endtime2" pattern="HH:mm:ss"/>
											<fmt:formatDate value="${endtime2}" var="end2" pattern="HH:mm"/>
											${start2}~${end2}<br>
											</c:forEach>
										</c:if>
										</div>									
										상세지역:${info.place}

									</div>
								</div>
						</c:forEach>
				</div>
				<c:if test="${fn:length(clsinfo)>3}">
				<div class="more" id="more">
					+ 다른 일정 더보기
				</div>
				</c:if>
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
						if(${sessionScope.loginUser==null}){
							alert("로그인 후 이용하세요");
						}else{
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
						}

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
				<c:if test="${clscurri!=null}">
				<div class="class_detail detail_sec_bor" id="curriculum">
					<div class="section01">
					<h1>커리큘럼</h1>
					<c:forEach items="${clscurri}" var="curri">
						<div class="curriculum_cont">
							<h2>${curri.classseq}회차</h2>
							<dl class="step_cont">
								<dd>
								${curri.title}<br><br>
								${curri.curri}
								</dd>
							</dl>
						</div>
					</c:forEach>
					</div>
				</div>
				</c:if>
			<div class="class_detail detail_sec_bor" id="review">
				<div class="section01">
					<h1>리뷰(${reviewcnt})</h1>
					<a href="javascript:reviewPop()"class="btn_st" id="btn-write-review">리뷰쓰기</a>
					<script>
						function reviewPop(){
							window.open('review.shop?classid=${param.classid}','','width=500,height=600,menubar=no,status=no,toolbar=no')
						}
					</script>
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
								<c:if test="${reviewcnt==0}">등록된 리뷰가 없습니다.</c:if>
								<c:if test="${reviewcnt!=0}">
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
								<div class="paging">
								  <c:if test="${pageNum<=1}"><img src="../assets/img/icon/back.png"></c:if> 
							      <c:if test="${pageNum>1}">
							      	<a href="detail.shop?classid=${param.classid}&pageNum=${pageNum-1}">
							      	<img src="../assets/img/icon/back.png"></a></c:if>    
							      <c:forEach var="a" begin="${startpage}" end="${endpage}">
							      <c:if test="${pageNum==a}"><a>${a}</a></c:if>
							      <c:if test="${pageNum!=a}">
							      	<a href="detail.shop?classid=${param.classid}&pageNum=${a}">${a}</a></c:if>
							      </c:forEach> 
							      <c:if test="${pageNum>=maxpage}"><img src="../assets/img/icon/next.png" style="width: 48px;height: 48px;"></c:if> 
							      <c:if test="${pageNum<maxpage}"><a href="detail.shop?classid=${param.classid}&pageNum=${pageNum+1}">
							      <img src="../assets/img/icon/next.png" style="width: 48px;height: 48px;"></a></c:if>
								</div>
								</c:if>
							</div>
						</ul>
					</div>
					<script> 
						$(function(){
							var cnt =$('#innerReviewDiv li').length;
							var boxheight = ($('#innerReviewDiv li').height()+60)*cnt;
							$('.review_list').height(boxheight+40+"px");
						})
					</script>
				</div>
			</div>
		</div>
	</div>
	</div>
</section>
</body>
</html>