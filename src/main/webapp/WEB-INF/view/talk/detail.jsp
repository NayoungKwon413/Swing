<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간톡상세</title>
<link href="${path}/assets/css/talk.css" rel="stylesheet">
<c:set var="port" value="${pageContext.request.localPort}"/>
<c:set var="server" value="${pageContext.request.serverName}"/>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var ws = new WebSocket("ws://${server}:${port}${path}/chatting.shop");
		var jsonArray = new Array();
		var TotalJson = new Array();
		var finalObj = new Object();
		//socket 연결시
		ws.onopen=function(){
			$("#chatStatus").text("info:connection opened")
			$("#message").on("keydown",function(evt){
				if(evt.keyCode==13){ //enter key 코드 값
					var msg = $("#message").val();
					var json=new Object();
					json.message = msg;
					json.date = new Date();
					jsonArray.push(json);
					ws.send(JSON.stringify(json));
					//alert(JSON.stringify(jsonArray))
					$("#message").val("");//서버로 입력된 내용 전송
				}
			})
		}
		//서버에서 메세지 수신한 경우
		ws.onmessage = function(event){
			//event.data: 서버에서 보내 준 메세지
			console.log(event.data);
			var obj = JSON.parse(event.data);
			var sessionid = obj.sessionid;
			var message = obj.message;
			var profile = obj.profile;
			var date = obj.date;
			var name = obj.name;
			var current_session=$('#sessionuserid').val();
			console.log('current session id:'+current_session);
			if(sessionid==current_session){ //내가 보낸 message
				var printHTML = "<dl class='my'><dt>"+
				"<div class='profile' style='background-image:url'/swing/assets/img/"
				+profile+"'></div><div class='name'>"+name+"</div></dt>"+
				"<dd class='blo'>"+message+
				"<span class='date'>"+date+"</span></dd></dl>"
				$(".content").append(printHTML);
			}else{ //상대방 메시지
				var printHTML = "<dl class='other'><dt>"+
				"<div class='profile' style='background-image:url'/swing/assets/img/"
				+profile+"'></div><div class='name'>"+name+"</div></dt>"+
				"<dd class='blo'>"+message+
				"<span class='date'>"+date+"</span></dd></dl>"
				$(".content").append(printHTML);
			}
//			console.log('chatting data:'+data);
		}
		//socket 닫혔을시
		ws.onclose = function(event){
			$("#chatStatus").text("info:connection close");
		}
		/*
		$(window).bind("beforeunload",function(){
			var obj = {
					talk:jsonArray
			}
			$.ajax("${path}/talk/talkClose.shop?roomno=${param.roomno}&classid=${param.classid}&TotalJson="+encodeURI(JSON.stringify(obj)),{
				success:function(data){
					console.log(data);
				}
			})
		});*/
		
		$('#btn_list').click(function(){
			var obj2 = {
					talk:jsonArray
			}
			$.ajax("${path}/talk/talkClose.shop?roomno=${param.roomno}&classid=${param.classid}&TotalJson="+encodeURI(JSON.stringify(obj2)),{
				success:function(data){
					console.log(data);
					location.href="mainTutee.shop?userid=${sessionuser.userid}"
				}
			})			
		})
		$('#close').click(function(){
			var obj = {
					talk:jsonArray
			}
			$.ajax("${path}/talk/talkClose.shop?roomno=${param.roomno}&classid=${param.classid}&TotalJson="+encodeURI(JSON.stringify(obj)),{
				success:function(data){
					console.log(data);
					window.close();
				}
			})				
		})
		
	})
</script>  
</head>
<body>
<h1 class="qna_title">
	튜터님과의 대화
	<div id="btn_list" class="btn_list">목록</div>
</h1>
<div id="qna_view" class="qna_view" style="height: 400px;overflow-y: scroll;">
	<form method="POST" id="" enctype="multipart/form-data">
		<div class="content">
			<div class="info">
				수업일정과 강의 내용에 대해 문의해보세요.<br>
				(연락처 문의 또는 직접 알려주는 것은 불가)
			</div>
			<c:if test="${chat!=null}">
				<c:forEach items="${chat}" var="ch">
					<c:if test="${ch.userid==sessionuser.userid}">
						<dl class="my">
							<dt>
								<div class="profile" style="background-image:url'${ch.file}'">
								</div>
								<div class="name">${ch.name}</div>
							</dt>
							<dd class="blo">
								${ch.chat}
								<span class="date">
									<fmt:formatDate value="${ch.chatdate}" var="chatdate" pattern="yyyy-MM-dd HH:mm:ss"/>
									${chatdate}
								</span>
							</dd>
						</dl>
					</c:if>
					<c:if test="${ch.userid!=sessionuser.userid}">
						<dl class="other">
							<dt>
								<div class="profile" style="background-image:url'${ch.file}'">
								</div>
								<div class="name">${ch.name}</div>
							</dt>
							<dd class="blo">
								${ch.chat}
								<span class="date">
									<fmt:formatDate value="${ch.chatdate}" var="chatdate" pattern="yyyy-MM-dd HH:mm:ss"/>
									${chatdate}
								</span>
							</dd>			
						</dl>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
		<!-- 리스트 끝 -->
		<input type="hidden" id="sessionuserid" name="seuserid" value="${sessionuser.userid}">
	</form>
</div>
<div class="q_write">
	<textarea id="message" name="Message"></textarea>
	<a href="#" onclick="" id="qwbtn" class="qwbtn">전송</a>
</div>
<p>
</body>
</html>