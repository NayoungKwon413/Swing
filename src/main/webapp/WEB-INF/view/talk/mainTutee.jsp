<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- width:500 height:650 설정 -->
<!DOCTYPE html>
<html>  
<head>
<meta charset="UTF-8">
<title>실시간톡메인_튜터</title>
<link href="${path}/assets/css/talk.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
<input type="hidden" id="tuteecnt" value="${tuteecnt}">
<input type="hidden" id="tutorcnt" value="${tutorcnt}">
	<div id="pop_qna">
		<div class="q_tab">
			<ul>
				<li><a href="#">수강생</a>
					<c:if test="${tuteecnt>0}">
						<div class="newtalk" style="position: relative; right: 4em; margin: 0;">N</div>
					</c:if>
				</li>
				<li><a href="mainTutor.shop?userid=${param.userid}">튜터</a>
					<c:if test="${tutorcnt>0}">
						<div class="newtalk" style="position: relative; right: 4em; margin: 0;">N</div>
					</c:if>				
				</li> 
			</ul>
		</div>
		<!-- 리스트 시작 -->
		<div class="qna_cont">
			<div class="qna_list">
			<c:if test="${fn:length(chat)==0}">문의한 내용이 없습니다.</c:if>
			<c:if test="${chat!=null}">
				<c:forEach items="${chat}" var="ch">
					<a href="detail.shop?roomno=${ch.roomno}&classid=${ch.classid}&newtalk=${ch.newtalk}">
						<div class="profile">
							<div class="profileimg" style="background-image:url('${ch.file}')"></div>
							<div class="name">${ch.name}</div>
						</div>
						<div class="qtxt">
							<h2>${ch.subject}</h2>
							<div class="q_intxt">${ch.chat}</div>
							<c:if test="${ch.newtalk>0}">
								<div class="newtalk">${ch.newtalk}</div>
							</c:if>
							<div class="date">
								<fmt:formatDate value="${ch.chatdate}" var="chatdate" pattern="yyyy-MM-dd HH:mm:ss"/>
								${chatdate}
							</div>
						</div>
					</a>
				</c:forEach>
			</c:if>
			<c:if test="${chat==null}">
				문의가 없습니다.
			</c:if>
			</div>
		</div>
 <%-- 새로운 메시지가 도착했는지 체크할값 script에서 ajax으로 계속 체크함 --%>
	</div>
	<script>
		setInterval("check()",10000);
		function check(){
//			var cnt = $('#cnt').val();
			var tuteecnt = $('#tuteecnt').val();
			var tutorcnt = $('#tutorcnt').val();
			$.ajax('${path}/talk/check.shop?userid=${param.userid}',{
				success:function(data){
					nCnt = data.split(",");
					nTuteeCnt = nCnt[0];
					nTutorCnt = nCnt[1];
					if(nTuteeCnt>tuteecnt || nTutorCnt>tutorcnt){
						alert("새로운 메시지가 도착했습니다.");
						location.reload();
					}
				}
			})
		}
	</script>
</body>
</html>