<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>튜터의 내 수업 승인 상태</title>
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
<style type="text/css">
.team-img label{
   position: absolute;
   top: 10px;
   right: 20px;
}
</style>
<script type="text/javascript">
   function page(src){
      //open(src,"",);
      location.href=src;
   } 
   
   function deleteCheck(classid){
	   if(confirm("해당 클래스를 정말 삭제하시겠습니까?") == true){
		   location.href="classDelete.shop?classid="+classid;
		   alert("해당 클래스가 삭제되었습니다.");
		   
	   }else{
		   return false;
	   }
   }
</script>
</head>
<body>
    <section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="my.shop"><h2>내 수업 승인상태</h2></a>
          <c:choose>
          	<c:when test="${param.state == 1}">
          		<a href="my.shop" >전체</a>&nbsp;|
          		<a href="my.shop?state=1" class="select">등록진행중</a>&nbsp;|
          		<a href="my.shop?state=2">승인대기</a>&nbsp;|
          		<a href="my.shop?state=3">반려</a>&nbsp;|
         	 	<a href="my.shop?state=4">승인완료</a>
         	</c:when>
         	<c:when test="${param.state == 2}">
         		<a href="my.shop" >전체</a>&nbsp;|
          		<a href="my.shop?state=1" >등록진행중</a>&nbsp;|
          		<a href="my.shop?state=2" class="select">승인대기</a>&nbsp;|
          		<a href="my.shop?state=3">반려</a>&nbsp;|
          		<a href="my.shop?state=4">승인완료</a>
         	</c:when>
         	<c:when test="${param.state == 3}">
         		<a href="my.shop" >전체</a>&nbsp;|
          		<a href="my.shop?state=1" >등록진행중</a>&nbsp;|
          		<a href="my.shop?state=2" >승인대기</a>&nbsp;|
          		<a href="my.shop?state=3" class="select">반려</a>&nbsp;|
          		<a href="my.shop?state=4">승인완료</a>
         	</c:when>
         	<c:when test="${param.state == 4}">
         		<a href="my.shop" >전체</a>&nbsp;|
          		<a href="my.shop?state=1" >등록진행중</a>&nbsp;|
          		<a href="my.shop?state=2" >승인대기</a>&nbsp;|
          		<a href="my.shop?state=3">반려</a>&nbsp;|
          		<a href="my.shop?state=4" class="select">승인완료</a>
         	</c:when>
         	<c:otherwise>
         		<a href="my.shop" class="select">전체</a>&nbsp;|
          		<a href="my.shop?state=1" >등록진행중</a>&nbsp;|
          		<a href="my.shop?state=2" >승인대기</a>&nbsp;|
          		<a href="my.shop?state=3">반려</a>&nbsp;|
          		<a href="my.shop?state=4" >승인완료</a>
         	</c:otherwise>
          </c:choose>
          <hr>
          </div> 
         <div class="row">
         <c:if test="${classcount > 0}">
         <c:forEach var="cl" items="${classlist}">
         <div class="col-lg-4" style="cursor:pointer;">
                <div class="team-img" 
                	 onclick="page('<c:if test="${cl.state == 4}">register-class.shop?classid=${cl.classid}</c:if><c:if test="${cl.state == 1}">register.shop</c:if>')">                	 
               	  <c:if test="${cl.state == 1}">
                  	<label class="badge badge-success">등록진행중</label>
                  	<img class="img-fluid" style="width:350px; height:350px;" src="http://${server}:${port}${path}/class/coverimg/${cl.classid}_${cl.coverimg}" alt="">
                  </c:if>
                  <c:if test="${cl.state == 2}">
                  	<label class="badge badge-success">승인대기중</label>
                  	<img class="img-fluid" style="width:350px; height:350px;" src="http://${server}:${port}${path}/class/coverimg/${cl.classid}_${cl.coverimg}" alt="">
                  </c:if>
                  <c:if test="${cl.state == 3}">
                  	<label class="badge badge-danger">반&nbsp;려</label>
                    <img class="img-fluid" style="width:350px; height:350px;" src="http://${server}:${port}${path}/class/coverimg/${cl.classid}_${cl.coverimg}" alt="">
                  </c:if>
                  <c:if test="${cl.state == 4}">
                  	<label class="badge badge-success">승인완료</label>
                  	<img class="img-fluid" style="width:350px; height:350px;" src="http://${server}:${port}${path}/class/coverimg/${cl.classid}_${cl.coverimg}" alt="">
                  </c:if> 
                  
               </div>
               <div class="contetn">
                  <div class="info-text">                
                     <h4>
                     <c:choose>
                     	<c:when test="${cl.state == 1}"><a href="register.shop">${cl.subject}</a></c:when>
                     	<c:when test="${cl.state == 4}"><a href="register-class.shop?classid=${cl.classid}">${cl.subject}</a></c:when>
                     	<c:otherwise><a href="#">${cl.subject}</a></c:otherwise>
                     </c:choose>
                     </h4>
<%--                     <c:if test="${cl.state == 4}"><a href="register-class.shop?classid=${cl.classid}">${cl.subject}</a></c:if>
                     	 <c:if test="${cl.state < 4}"><a href="../class/detail.shop?classid=${cl.classid}">${cl.subject}</a></c:if></h4>--%>
                     <p>${cl.nickname}(${cl.userid})</p>
                     <p>[신청일시] <fmt:formatDate value="${cl.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                     <p>[위치] ${cl.location1} ${cl.location2}</p>
                     <p>[수업형태] <c:if test="${cl.maxtutee == 1}"> 1:1 </c:if>
                     			 <c:if test="${cl.maxtutee > 1 }"> 최대 ${cl.maxtutee}인</c:if>
                     			 <c:if test="${cl.type == 1}">원데이 클래스</c:if>
                     			 <c:if test="${cl.type == 2}">다회차 클래스</c:if></p>
                   	 <c:if test="${cl.state == 3}">
                   	 	<div style="float: right;">
                   	 	<input type="button" value="수정" onclick="location.href='../tutor/register.shop?classid=${cl.classid}'">&nbsp;
                   	 	<input type="button" value="삭제" onclick="deleteCheck(${cl.classid})">
                   	 	</div>
                   	 </c:if>
                  </div>
               </div>
         </div>
         </c:forEach>	
         </c:if>
         <c:if test="${classcount == 0}">
         	<div style="font-align:center;">
         	<p>등록된 수업이 없습니다.</p>
         	</div>
         </c:if>
         
      </div>
     </div>
    </section>  
</body>
</html>