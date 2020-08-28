<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 목록</title>
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
<link href="${path}/assets/css/user-style.css" rel="stylesheet">
<link href="${path}/assets/css/admin-style.css" rel="stylesheet">
<style type="text/css">
@import url("https://fonts.googleapis.com/css?family=Arvo:700|Open+Sans");
html {
  overflow-x: hidden;
}

body {
  background: #fff;
  font-size: 14px;
  font-weight: 400;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-font-smoothing: subpixel-antialiased;
  color: #abacae;
  line-height: 25px;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
  overflow-x: hidden;
}

#star_grade a{
        text-decoration: none;
        color: gray;
    }
#star_grade a.on{
        color: red;
    }
.team-img label{
	position: absolute;
	top: 10px;
	right: 20px;
}
.review_point {
    display: inline-block;
}

div#calc_point {
    display: inline-block;
    font-size: 2em;
    padding-left: 0.4em;
    /* vertical-align: text-bottom; */
    position: relative;
    bottom: 0.6em;
    font-weight: 600;
}
.star{
  display:inline-block;
  width: 30px;height: 60px;
  cursor: pointer;
}
.star_left{
  background: url('/swing/assets/img/icon/star.png') no-repeat 0 0; 
  background-size: 60px; 
  margin-right: -3px;
}
.star_right{
  background: url('/swing/assets/img/icon/star.png') no-repeat -30px 0; 
  background-size: 60px; 
  margin-left: -3px;
}
.star.on{
  background-image: url('/swing/assets/img/icon/star_on.png');
}

.detail{
	float: right; margin-right: 20px;
}
</style>
<script type="text/javascript">
$(function(){
	$(".star").on('click',function(){
		var idx = $(this).index();
		$(".star").removeClass("on");
		for(var i=0; i<=idx; i++){
			$(".star").eq(i).addClass("on");
		}
		var point = (idx+1)*0.5;
		$("#calc_point").html(point);
	});
  
	$(".classbody").on("click", function(){ 
		var idx= $(".classbody").index(this);    <%-- 클래스의 인덱스를 가져와 사용하는 방법 --%>
		$(".infotable:eq("+idx+")").toggle();
	});

});
</script>
</head>
<body>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="result.shop"><h2>내 수업 목록</h2></a>
          <c:choose>
          	<c:when test="${param.state == 5}">
          		<a href="result.shop">전체보기</a>&nbsp;|         		
         		<a href="result.shop?state=5" class="select">수업진행중</a>&nbsp;|
          		<a href="result.shop?state=6">수업완료</a>&nbsp;
          	</c:when>
          	<c:when test="${param.state == 6}">
          		<a href="result.shop">전체보기</a>&nbsp;|
         		<a href="result.shop?state=5" >수업진행중</a>&nbsp;|
          		<a href="result.shop?state=6" class="select">수업완료</a>&nbsp;
          	</c:when>
          	<c:otherwise>
          		<a href="result.shop" class="select">전체보기</a>&nbsp;|
         		<a href="result.shop?state=5">수업진행중</a>&nbsp;|
          		<a href="result.shop?state=6">수업완료</a>&nbsp;
          	</c:otherwise>
          </c:choose>
          <hr style="margin-top: 15px;">
          </div>
          
         <div class="row bg-gray">
         <c:if test="${classcount > 0}">
         
         <div class="col-lg-12 col-md-12 col-xs-12">            
         <c:forEach items="${classlist}" var="cl" varStatus="stat">
         <input type="hidden" name="classid" value="${cl.classid}">
            <div class="classbody team-item wow fadeInRight animated" data-wow-delay="0.2s"  
            	style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s; cursor:pointer;">
               <div class="team-img">
                  <img class="img-fluid" src="http://${server}:${port}${path}/class/coverimg/${cl.classid}_${cl.coverimg}" alt="">
               </div>
               <div class="contetn">
                  <div class="info-text">
                     <h3><a href="#">${cl.subject}</a></h3>
                     <p>${cl.nickname}(${cl.userid})</p>
                     <p>[수업시작일] <fmt:formatDate value="${cl.date}" pattern="yyyy-MM-dd" /></p>
                     <p>[위치] ${cl.location1} ${cl.location2}</p>
                  </div>                  
                  <div class="detail">
                  	<input type="button" value="수업추가하기" onclick="location.href='register-class.shop?classid=${cl.classid}'">&nbsp;&nbsp;
                  	<input type="button" value="수업상세보기" onclick="location.href='../class/detail.shop?classid=${cl.classid}'">&nbsp;&nbsp;
                  </div>
               </div>
            </div>            
            <div class="infotable" style="display:none">
            	<table class="table table-hover">
            	<tr><th>차수-회차</th><th>장소</th><th>날짜</th><th>시작시간</th><th>끝나는시간</th><th>수업진행상태</th><th>신청튜티리스트</th></tr>            	
            	<c:forEach items="${classinfolist}" var="info" varStatus="stat2">     	
            	<c:if test="${cl.classid == info.classid}">
	           	<fmt:parseDate value="${info.starttime}" pattern="HH:mm" var="starttime" />
            	<fmt:parseDate value="${info.endtime}" pattern="HH:mm" var="endtime" />        
            	<fmt:formatDate value="${starttime}" pattern="HH:mm" var="starttime" />
            	<fmt:formatDate value="${endtime}" pattern="HH:mm" var="endtime" />
            	<tr><td>${info.classno}차수-${info.classseq}회차</td><td>${info.place}</td><td>${info.date}</td><td>${starttime}</td><td>${endtime}</td>
            		<td>
            		<c:if test="${info.date > today}">
            		<label class="badge badge-warning">진행예정</label></c:if>
            		<c:if test="${info.date == today}">
            		<label class="badge badge-warning">진행</label></c:if>
            		<c:if test="${info.date < today}">
            		<label class="badge badge-info">완료</label></c:if>
            		</td>
            		<td><button onclick="location.href='applylist.shop?classid=${info.classid}&classno=${info.classno}'">조회</button></td></tr>
            	</c:if>
            	</c:forEach>                       	 	
            	</table>
            </div>
         </c:forEach>   
         </div>
      </c:if>
      <c:if test="${classcount == 0}">
         	<div style="font-align:center;">
         	<p>승인완료된 수업이 없습니다.</p>
         	</div>
      </c:if>
      </div>
   </div>
</section>
</body>
</html>