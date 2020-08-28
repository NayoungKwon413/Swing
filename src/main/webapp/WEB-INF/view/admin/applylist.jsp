<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 신청 목록</title>
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

.img16{
	width:16px;
	height:16px;
	margin-right: 10px;
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
          <a href="applylist.shop?get=0"><h2>신청 목록</h2></a>
          <a href="applylist.shop?get=0"  <c:if test="${param.get==0}">class="select"</c:if> >승인요청(${classCount})</a>&nbsp;|
          <a href="applylist.shop?get=2"  <c:if test="${param.get==2}">class="select"</c:if>>반려(${reCount})</a>&nbsp;|
          <a href="applylist.shop?get=1"  <c:if test="${param.get==1}">class="select"</c:if>>승인완료(${doneCount})</a>
          <hr style="margin-top: 15px;">
          </div>
          <div class="row bg-gray">
          <c:if test="${classSize==0}">
			목록이 없습니다.
		  </c:if>
		  <c:if test="${classSize>0}">
         <c:forEach items="${list}" var="c">
         <div class="col-lg-6 col-md-12 col-xs-12">
            <div class="team-item wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
               <div class="team-img">
                  <!-- <img class="img-fluid" src="../class/save/${c.userid}_${c.coverimg}" alt=""> -->
                  <c:if test="${c.coverimg!=null && !c.coverimg.equals('')}">
                  		<img class="img-fluid" src="http://${server}:${port}${path}/class/coverimg/${c.classid}_${c.coverimg}" alt="">
                  </c:if>
                  <c:if test="${c.coverimg==null || c.coverimg.equals('')}">
                  		<img class="img-fluid" src="../assets/img/portfolio/portfolio-7.jpg" alt="">
                  </c:if>
               </div>
               <div class="contetn">
                  <div class="info-text" onclick="location.href ='../class/detail.shop?classid=${c.classid}'" style="cursor:pointer;">
                     <p style="color:#49b5e7; font-size: 11px;"><c:if test="${c.category==1}">요리베이킹</c:if>
                     <c:if test="${c.category==2}">반려동물</c:if>
                     <c:if test="${c.category==3}">사진</c:if>
                     <c:if test="${c.category==4}">핸드메이드</c:if>
                     <c:if test="${c.category==5}">술</c:if></p>
                     <h3><a href="#">
                     <span style="color: #ccc8c8; font-size: 18px;">>&nbsp;&nbsp;</span>${c.subject}</a></h3>
                     <p name="idd" value="${c.userid}"><img class="img16" src="${path}/assets/img/icon/user.png">${c.userid}</p>
                     <p>
                     <c:if test="${c.type==1}"><img class="img16" src="${path}/assets/img/icon/one-page.png">원데이 클래스</c:if>
                     <c:if test="${c.type==2}"><img class="img16" src="${path}/assets/img/icon/two-pages.png">그룹 레슨</c:if>
                     (<c:if test="${c.level==1}">입문자</c:if>
                     <c:if test="${c.level==2}">중/상급자</c:if>
                     <c:if test="${c.level==3}">고급/숙련자</c:if>)</p>
                     <p><img class="img16" src="${path}/assets/img/icon/marker.png">&nbsp;${c.location1}&nbsp;${c.location2}</p>             
                     <p><img class="img16" src="${path}/assets/img/icon/stopwatch.png">총 ${c.totaltime}회
                     (회당 ${c.time}시간)</p>
                     <p><img class="img16" src="${path}/assets/img/icon/pricing.png">
                     <fmt:formatNumber value="${c.totalprice}" pattern="#,###"/>원
                     (회당 <fmt:formatNumber value="${c.price}" pattern="#,###"/>원)</p>
                  </div>
                  <div style="float: right; margin-top: -40px;">
                  <c:if test="${param.get==0}">
                     <button type="button" onclick="changestate('0','1','${c.userid}','${c.classid}')"><label class="badge badge-success">승인</label></button>
                     <button type="button" onclick="changestate('2','2','${c.userid}','${c.classid}')"><label class="badge badge-danger">반려</label></button>
                  </c:if>
                  <c:if test="${param.get==2}">
                     <button type="button" onclick="changestate('0','1','${c.userid}','${c.classid}')"><label class="badge badge-success">승인</label></button>
                  </c:if>
					<script>
						
						function changestate(get,type,id,classid){
							if(type=='1'){
								regicheck(get,id,classid);
							}else{
								window.open('reason.shop?id='+id+"&classid="+classid,'','width=500,height=400,menubar=no,status=no,toolbar=no');
							}
						}
						
						function regicheck(get,id,classid) {
							 if (confirm(id+"님의 클래스 요청을 승인하시겠습니까?") == true){ 
								 $.ajax({
										type: 'POST',
										url: 'chageClassState.shop',
										data:{
							                "id" : id,
							                "classid" : classid,
							                "get" : get
										},
										success: function(data) {
											 alert("승인 완료되었습니다.");
											 location.href = "applylist.shop?get="+get;
										},error:function(xhr,status){
											alert(xhr+":"+status);
										}
									});
							 }else{return false;}
						}
					</script>
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