<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>튜티의 위시리스트</title>
<link href="${path}/assets/css/tutee.css" rel="stylesheet">
<script type="text/javascript">
function delwish(userid,classid) {
	location.href="wishDelete.shop?userid="+userid+"&classid="+classid
	alert("위시리스트에서 삭제되었습니다.");
}

$(function(){
	for(var n=0; n< ${wishnum}; n++){
		var idx = $('#Avg'+n).val()/0.5;
		for(var i=0; i<idx; i++){
			$(".star"+n).eq(i).addClass("on");
		}
	}
})
</script>
</head>
<body>
<section>
	<div class="container">
		<div class="title-box">
			<h1>위시리스트</h1>
		</div>
		<div class="my-class-list">
		<c:if test="${wishnum==0}">위시리스트 목록이 없습니다.</c:if>
		<c:forEach var="wish" items="${wishlist}" varStatus="status">
			<div class="class-box">
			<!-- ${path}/class/save/${wish.coverimg} -->
				<div class="image" style="background-image:url('http://${server}:${port}${path}/class/coverimg/${wish.classid}_${wish.coverimg}')"></div>
				<div class="information-box">
					<h3><a href="${path}/class/detail.shop?classid=${wish.classid}">${wish.subject}</a></h3>
					<div class="start-box">
						<font class="class-type"><c:if test="${wish.type==1}">원데이 수업</c:if>
												 <c:if test="${wish.type==2}">다회차 수업 - ${wish.totaltime}회</c:if></font>
						<span>|</span>
						<font class="class-type">참여인원 : ${wish.particinum}</font>
					</div>
					<div class="start-date">
						<font>수업 시작일 :<fmt:formatDate value="${wish.startdate}" pattern="yyyy-MM-dd" /></font>
						<span>|</span>
						<font>${wish.location2}</font>
					</div>
					<div class="price">
						<a class="starimg">
							<input type="hidden" id="Avg${status.index}" value="${wish.star}">
							<span class="star star${status.index} star_left"></span>
						    <span class="star star${status.index} star_right"></span>
						
						    <span class="star star${status.index} star_left"></span>
						    <span class="star star${status.index} star_right"></span>
						
						    <span class="star star${status.index} star_left"></span>
						    <span class="star star${status.index} star_right"></span>
						
						   <span class="star star${status.index} star_left"></span>
						   <span class="star star${status.index} star_right"></span>

						   <span class="star star${status.index} star_left"></span>
						   <span class="star star${status.index} star_right"></span>
						</a><font>(${wish.reviewnum})</font>
						<font>\</font>
						<fmt:formatNumber value="${wish.totalprice}" type="currency"/>
					</div>
					<div class="btn-box">
						<a class="btn tp1" href="${path}/class/check.shop?classid=${wish.classid}">신청</a>
						<a class="btn tp1" onclick="delwish('test',${wish.classid})">삭제</a>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</div>
</section>
</body>
</html>