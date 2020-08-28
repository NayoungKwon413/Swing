<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>  
<html>
<head>
<meta charset="UTF-8">
<title>수업목록</title>
 <script type="text/javascript">
    $(function(){
			var starboxs = $('.starbox');
			$('.starbox').each(function(i,item) {
				var idx = $('.avg').eq(i).val()/0.5;
					var star = $('.starbox').eq(i);
					for(var j=0; j<=idx; j++){
				       $(this).children(".star").eq(j).addClass("on");
				    }			     
			})
		})
		/*
		function listdo(page){
		      var pageNum = page;
		      var location1 = ${param.locion1};
		      var location2 = ${param.loction2};
		      var type= ${param.type};
		      var maxtutee = ${param.maxtutee};
		      
		      location.href = "classlist.shop?location1="+location1+"&lcoation2="+location2+"&type="+type+
		      				"&maxtutee="+maxtutee+"&pageNum="+pageNum;
		     }
    */
</script>
</head>
<body>
<section id="category" class="align-items-center">
	<div id="container">
		<div class="cate_list">
			<ul>
				<li id="menu1">
					<a href="classlist.shop?cate=1">
						<div id="cate1">요리베이킹</div>
					</a>
				</li>
				<li id="menu2">
					<a href="classlist.shop?cate=2">
						<div id="cate2">반려동물</div>
					</a>
				</li>
				<li id="menu3">
					<a href="classlist.shop?cate=3">
						<div id="cate3">사진</div>
					</a>
				</li>
				<li id="menu4">
					<a href="classlist.shop?cate=4">
						<div id="cate4">핸드메이드</div>
					</a>
				</li>
				<li id="menu5">
					<a href="classlist.shop?cate=5">
						<div id="cate5">술</div>
					</a>
				</li>
				<li id="menu6" style="background-color:rgba(255,255,255); border-bottom:1px solid rgb(201,201,201);">
					<div id="filter">필터</div>
				</li>
			</ul>
		</div>
		<div class="catesub filter" style="display:block;">
			<div class="main">
				<div class="inbox">
					<div class="left">지역</div>
					<div class="right" id="regionSub" style="margin-right: 1em;">
						<select id="city">
							<option value="">지역</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
						</select>
					</div>
					<div class="right2" id="regionSub2">
						<select id='area'>
							<option value="">지역을 선택하세요</option>
						</select>
					</div>
				</div>
				<script>
					$(function(){
						$('#city').change(function(){
							var area = $(this).val();
							var msg = "";
							if(area=='서울'){
								msg = "<select id='area'>"+
									"<option value=''>서울ALL</option>"+
									"<option value='강남'>강남</option>"+
									"<option value='건대'>건대</option>"+
									"<option value='잠실'>잠실</option>"+
									"<option value='종로'>종료</option>"+
									"<option value='홍대'>홍대</option>"+
									"</select>";
							}else if(area=='경기'){
								msg = "<select id='area'>"+
								"<option value=''>경기ALL</option>"+
								"<option value='분당'>분당</option>"+
								"<option value='부천'>부천</option>"+
								"<option value='수원'>수원</option>"+
								"<option value='안산'>안산</option>"+
								"<option value='안양'>안양</option>"+
								"<option value='일산'>일산</option>"+
								"</select>";
							}else if(area=='icn'){
								msg = "<select id='area'>"+
								"<option value='부평'>부평</option>"+
								"<option value='송도'>송도</option>"+
								"</select>"
							}else{
								msg="<select id='area'>"+
									"<option value=''>지역을 선택하세요</option>"+
									"</select>";
							}
							$("#regionSub2").html(msg);
						})
					})
				</script>			
				<div class="inbox">
					<div class="left">수업형태</div>
					<div class="right">
						<div class="days">
							<ul id="tTypes">
								<li value="1">원데이클래스</li>
								<li value="2">다회차</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="inbox">
					<div class="left">수업인원</div>
					<div class="right">
						<div class="days">
                        	<ul id="tTypes2">
                            	<li value="1">1:1수업</li>
                                <li value="2">그룹</li>
                           </ul>
                       </div>
                       <div class="filter_button" id="search">
                       			내게 맞는 수업 보기
                       </div>
					</div>
				</div>
				<script>
				$(function(){
					$(".catesub.filter").hide();
					$("#menu6").click(function(){
						$(".catesub.filter").toggle();
					})
					$("#tTypes2 li").click(function(){
						$(this).siblings().removeClass("on");
						$(this).addClass("on");
					})
					$("#tTypes li").click(function(){
						$(this).siblings().removeClass("on");
						$(this).addClass("on");
					})
					$('#search').click(function(){
						var location1 = $('#city').val();
						var location2 = $('#area').val();
						var type = $('#tTypes li.on').val();
						var maxtutee = $('#tTypes2 li.on').val();
						if(type==undefined){
							type="";
						}
						if(maxtutee==undefined){
							maxtutee="";
						}
						//alert(type);
						var url = "classlist.shop?location1="+location1+"&location2="+location2+
						"&type="+type+"&maxtutee="+maxtutee;
						if(${text!=null}) {
							url = url+"&text="+document.all.text.value;
						}
						location.href = url;
					})
				})
				</script>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="filter_head" style="margin-top:0px;">
			<div class="sorted">
				<ul id="sorted">
					<li><a href="classlist.shop?cate=${param.cate}&location1=${param.location1}&lcoation2=${param.location2}&type=${param.type}
		      				&maxtutee=${param.maxtutee}&pageNum=${a}&sorted=1">최신 등록순</a></li>
					<li><a href="classlist.shop?cate=${param.cate}&location1=${param.location1}&lcoation2=${param.location2}&type=${param.type}
		      				&maxtutee=${param.maxtutee}&pageNum=${a}&sorted=2">별점순</a></li>
				</ul>
			</div>
			<div class="num_class">
				${listcount}개의 수업
			</div>
		</div>
		<div class="class_box">
			<div class="class">
			<c:if test="${listcount>0}"><%--등록된 게시물 있음 --%>
			
			<c:if test="${text!=null}">
			<form:hidden path="text" name="text" value="${text}"/>
			</c:if>
			
				<c:set value="0" var="i"/>
				<c:forEach items="${classlist}" var="cls" varStatus="status">
					<c:if test="${status.count%3==2}">
						<div class="class_list" style="margin-right:20px;">
					</c:if>
					<c:if test="${status.count%3==1}">
						<div class="class_list" style="margin:0 10px;">
					</c:if>
					<c:if test="${status.count%3==0}">
						<div class="class_list" style="margin-right:0; margin-left:20px;">
					</c:if>
							<a href="detail.shop?classid=${cls.classid}">
							<div class="img" style="background-image:url('${path}/assets/img/${cls.coverimg}')">
								<div class="d_day">${cls.totaltutee}명 참여</div>
								<div class="level">
									<c:if test="${cls.level==1}">입문자용</c:if>
									<c:if test="${cls.level==2}">중/상급자용</c:if>
									<c:if test="${cls.level==3}">숙련자용</c:if>
								</div>
							</div>
							<div class="profile_box">
								<div class="profile" style="background-image:url('${tutor[i].file}')"></div>
								<div class="name">${tutor[i].name}</div>
							</div>
							<div class="title">
								${cls.subject}
							</div>
							<div class="price">
								₩${cls.price}
							</div>
							<div class="info">
								<div class="info2">
									<div class="starbox">
										<input type="hidden" id="Avg" class="avg" value="${cls.staravg}">
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
									</div>
									<div class="review" style="margin-right:15px;">
										(${cls.reviewcnt})
									</div>
									<div class="location">
										${cls.location2}
									</div>
								</div>
							</div>
						</a>
					</div>	
					<c:set var="i" value="${i+1}"/>
				</c:forEach>
			</c:if>
			<c:if test="${listcount==0}"> <%-- 등록된 게시물 없음 --%>
			<p>해당하는 수업이 없습니다.</p>
			</c:if>
			</div>
		      <c:if test="${pageNum<=1}"><img src="../assets/img/icon/back.png"></c:if> 
		      <c:if test="${pageNum>1}">
		      	<a href="classlist.shop?cate=${param.cate}&location1=${param.location1}&lcoation2=${param.location2}&type=${param.type}&maxtutee=${param.maxtutee}&pageNum=${pageNum-1}">
		      	<img src="../assets/img/icon/back.png"></a></c:if>    
		      <c:forEach var="a" begin="${startpage}" end="${endpage}">
		      <c:if test="${pageNum==a}"><a>${a}</a></c:if>
		      <c:if test="${pageNum!=a}">
		      	<a href="classlist.shop?cate=${param.cate}&location1=${param.location1}&lcoation2=${param.location2}&type=${param.type}&maxtutee=${param.maxtutee}&pageNum=${a}">${a}</a></c:if>
		      </c:forEach> 
		      <c:if test="${pageNum>=maxpage}"><img src="../assets/img/icon/next.png" style="width: 48px;height: 48px;"></c:if> 
		      <c:if test="${pageNum<maxpage}">
		      <a href="classlist.shop?cate=${param.cate}&location1=${param.location1}&lcoation2=${param.location2}&type=${param.type}&maxtutee=${param.maxtutee}&pageNum=${pageNum+1}">
		      <img src="../assets/img/icon/next.png" style="width: 48px;height: 48px;"></a></c:if>
		</div>
	</div>
</section>
</body>
</html>