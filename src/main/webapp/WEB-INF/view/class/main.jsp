<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
      			var index=0;
      			$(function(){
					$('.heart').click(function(){
						index = $('.heart').index(this);
					})
				})
				
				function wish(classid){
						$.ajax("${path}/class/checkwishlist.shop?classid="+classid,{
							success:function(data){
								console.log(data);
								//alert(data);
								if(data==0){
									$('.heart').eq(index).attr("src",'${path}/assets/img/icon/heart_on.png')
								}else{
									$('.heart').eq(index).attr("src",'${path}/assets/img/icon/heart.png')
								}
							}
						})
					}
</script>
</head>
<body>
   <section id="hero" class="d-flex align-items-center">
    <div class="container">
      	<h1>Spread your wings! SWING</h1>
		<form action="classlist.shop?text='${param.text}'" method="get">
			<input type="hidden" name="pageNum" value="1">
			<input type="text" name="text" style="outline: none;" value="${param.text}">
			<input type="submit" value="검색" style="outline: none;">
		</form>
    </div>
  </section><!-- End Hero -->
  <main id="main">
    <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container">
      	<!-- 카테고리 메뉴 -->
        <div class="q_menu">
			<ul>
				<li>
					<a href="classlist.shop?cate=1">
						<div class="icon baking">
							<img alt src="${path}/assets/img/icon/Baking.png">
						</div>
						<mark>
							요리/베이킹
						</mark>
					</a>
				</li>
				<li>
					<a href="classlist.shop?cate=2">
						<div class="icon baking">
							<img alt src="${path}/assets/img/icon/Pet.png">
						</div>
						<mark>
							반려동물
						</mark>
					</a>
				</li>
				<li>
					<a href="classlist.shop?cate=3">
						<div class="icon baking">
							<img alt src="${path}/assets/img/icon/Camera.png">
						</div>
						<mark>
							사진
						</mark>
					</a>
				</li>
				<li>
					<a href="classlist.shop?cate=4">
						<div class="icon baking">
							<img alt src="${path}/assets/img/icon/Handmade.png">
						</div>
						<mark>
							핸드메이드
						</mark>
					</a>
				</li>
				<li>
					<a href="classlist.shop?cate=5">
						<div class="icon baking">
							<img alt src="${path}/assets/img/icon/Wine.png">
						</div>
						<mark>
							술
						</mark>
					</a>
				</li>
			</ul>
        </div>
      </div>
      <!-- 인기수업 -->
      <div class="container">
      <div id="talentLayout1">
      	<div class="swiper-area">
      		<h2 style="margin-top: 2em;">인기 수업</h2>
      		<div class="item_lst">
      			<ul class="swiper-wrapper">
      				<c:forEach items="${hotlist}" var="cls" varStatus="status">
      					<c:if test="${status.count%3==2}">
      						<li class="swiper-slide" style="margin-right:50px;">
      					</c:if>
      					<c:if test="${status.count%3==1}">
      						<li class="swiper-slide" style="margin:0 20px;">
      					</c:if>
      					<c:if test="${status.count%3==0}">
      						<li class="swiper-slide" style="margin-left:50px; margin-right:0;">
      					</c:if>
      							<a href="detail.shop?classid=${cls.classid}">
      								<div class="img" style="background-image:url('http://${server}:${port}${path}/class/coverimg/${cls.classid}_${cls.coverimg}');"></div>
      								<p class="t1">${cls.subject}</p>
      								<div class="t2">
      									<span class="profile">
      										<img class="roundImg" src="${path}/assets/img/${cls.file}" style="width: 24px; height: 24px;">
      									</span>
      									<span class="name">${cls.name}</span>
      									<fmt:formatDate value="${cls.date}" var="date" pattern="MM월dd일"/>
      									<span class="d_day">${date}</span>
      									<span>${cls.location2}</span>
      								</div>
      							</a> 
      							<div class="t3">
      								<span class="num">${cls.totaltutee}명 참여</span>
      								 <fmt:formatNumber value="${cls.staravg}" var="staravg" pattern=".0"/>
      								<span class="score">${staravg}(${cls.reviewcnt})</span>
      								<a href="javascript:wish(${cls.classid})" class="btn_wish">
      								<c:if test="${cls.wish==0}">
      									<img id="heart" class="heart" src="${path}/assets/img/icon/heart.png" style="width: 25px;"></a>
      								</c:if>
      								<c:if test="${cls.wish==1}">
      									<img id="heart" class="heart" src="${path}/assets/img/icon/heart_on.png" style="width: 25px;"></a>
      								</c:if>
      							</div>
      						</li>     					
      				</c:forEach>
      			</ul>
      		</div>
      		<h2 style="margin-top: 2em;">최신 수업</h2>
      		<div class="item_lst">
      			<ul class="swiper-wrapper">
      				<c:forEach items="${latestlist}" var="cls" varStatus="status">
      					<c:if test="${status.count%3==2}">
      						<li class="swiper-slide" style="margin-right:50px;">
      					</c:if>
      					<c:if test="${status.count%3==1}">
      						<li class="swiper-slide" style="margin:0 20px;">
      					</c:if>
      					<c:if test="${status.count%3==0}">
      						<li class="swiper-slide" style="margin-left:50px; margin-right:0;">
      					</c:if>
      							<a href="detail.shop?classid=${cls.classid}">
      								<div class="img" style="background-image:url('http://${server}:${port}${path}/class/coverimg/${clas.classid}_${clas.coverimg}');"></div>
      								<p class="t1">${cls.subject}</p>
      								<div class="t2">
      									<span class="profile">
      										<img class="roundImg" src="${path}/assets/img/${cls.file}" style="width: 24px; height: 24px;">
      									</span>
      									<span class="name">${cls.name}</span>
      									<fmt:formatDate value="${cls.date}" var="date" pattern="MM월dd일"/>
      									<span class="d_day">${date}</span>
      									<span>${cls.location2}</span>
      								</div>
      							</a> 
      							<div class="t3">
      								<span class="num">${cls.totaltutee}명 참여</span>
      								<fmt:formatNumber value="${cls.staravg}" var="staravg" pattern=".0"/>
      								<span class="score">${staravg}(${cls.reviewcnt})</span>
      								<%--<button class="btn_wish" type="button" onclick="javascript:wish(${cls.classid})"></button>--%>
      								<a href="javascript:wish(${cls.classid})" class="btn_wish">
      								<c:if test="${cls.wish==0}">
      									<img id="heart" class="heart" src="${path}/assets/img/icon/heart.png" style="width: 25px;"></a>
      								</c:if>
      								<c:if test="${cls.wish==1}">
      									<img id="heart" class="heart" src="${path}/assets/img/icon/heart_on.png" style="width: 25px;"></a>
      								</c:if>
      							</div>
      						</li>     					
      				</c:forEach>
      			</ul>
      		</div>
      	</div>
      </div>
      </div>
    </section><!-- End About Section -->
  </main>
</body>
</html>