<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 목록</title>
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
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
</style>
</head>
<body>
<script type="text/javascript">
   function listdo(page,get,id){
      f = document.sf;
      f.pageNum.value = page;
      f.get.value = get;
      f.id.value = id;
      console.log("page:"+page);
      console.log("get:"+get);
      console.log("id:"+id);
      
      f.submit();
   }
</script>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
           <a><h2>수강 목록</h2></a>
          
          <a href="classlist.shop?get=0" <c:if test="${param.get==0}">class="select"</c:if>>수강중(${classCount})</a>&nbsp;|
          <a href="classlist.shop?get=1" <c:if test="${param.get==1}">class="select"</c:if>>수강완료(${doneCount})</a>
          <hr style="margin-top: 15px;">
          </div>
          <div class="row bg-gray">
          <c:if test="${classSize==0}">
         목록이 없습니다.
        </c:if>
        <c:if test="${classSize>0}">
         <c:forEach items="${list}" var="c">
         <div class="col-lg-6 col-md-12 col-xs-12" onclick="location.href ='../class/detail.shop?classid=${c.classid}'" style="cursor:pointer;">
            <div class="team-item wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
               <div class="team-img">
               <c:if test="${c.coverimg!=null && !c.coverimg.equals('')}">
                  		<img class="img-fluid"  style="width:200px; height:200px;"  src="http://${server}:${port}${path}/class/coverimg/${c.classid}_${c.coverimg}" alt="">
                  </c:if>
                  <c:if test="${c.coverimg==null || c.coverimg.equals('')}">
                  		<img class="img-fluid"  style="width:200px; height:200px;" src="../assets/img/portfolio/portfolio-7.jpg" alt="">
                  </c:if>
               </div>
               <div class="contetn">
                  <div class="info-text">
                     <p><c:if test="${c.category==1}">요리베이킹</c:if>
                     <c:if test="${c.category==2}">반려동물</c:if>
                     <c:if test="${c.category==3}">사진</c:if>
                     <c:if test="${c.category==4}">핸드메이드</c:if>
                     <c:if test="${c.category==5}">술</c:if></p>
                     <h3><a href="#">
                     <span style="color: #ccc8c8; font-size: 12px;">>></span>${c.subject}</a></h3>
                     <p name="idd" value="${c.userid}">[회원]&nbsp;${c.userid}</p>
                     <p>[유형]&nbsp;
                     <c:if test="${c.type==1}">원데이</c:if>
                     <c:if test="${c.type==2}">그룹</c:if>
                     <span style="color: #ccc8c8; font-size: 12px;">|</span>[레벨]&nbsp;                   
                     <c:if test="${c.level==1}">입문자</c:if>
                     <c:if test="${c.level==2}">중/상급자</c:if> 
                     <c:if test="${c.level==3}">고급/숙련자</c:if></p>
                     <p>[위치]&nbsp;${c.location1}&nbsp;${c.location2}</p>
                     <p>${c.time}<span style="color: #ccc8c8; font-size: 12px;">|</span>
                     ${c.totaltime}<span style="color: #ccc8c8; font-size: 12px;">|</span>
                     ${c.price}<span style="color: #ccc8c8; font-size: 12px;">|</span>${c.totalprice}</p>
                  </div> 
               </div>
            </div>
         </div>
         </c:forEach>
         </c:if>
      </div>
      <div class="row">
     <div class="back-next">
     <form action="applylist.shop" method="post" name="sf">
      <input type="hidden" name="pageNum" value="1">
      <input type="hidden" name="get" value="0">
      <input type="hidden" name="id" value="">
      </form>
      <c:if test="${pageNum<=1}"><img src="../assets/img/icon/back.png"></c:if> 
      <c:if test="${pageNum>1}"><a href="javascript:listdo(${pageNum-1},${param.get},'')"><img src="../assets/img/icon/back.png"></a></c:if> 
      <c:forEach var="a" begin="${startpage}" end="${endpage}">
      <c:if test="${pageNum==a}"><a>${a}</a></c:if>
      <c:if test="${pageNum!=a}"><a href="javascript:listdo(${a},${param.get},'')">${a}</a></c:if>
      </c:forEach> 
      <c:if test="${pageNum>=maxpage}"><img src="../assets/img/icon/next.png"></c:if> 
      <c:if test="${pageNum<maxpage}"><a href="javascript:listdo(${pageNum+1},${param.get},'')"><img src="../assets/img/icon/next.png"></a></c:if>
   </div>
   </div>
   </div>
</section>
</body>
</html>