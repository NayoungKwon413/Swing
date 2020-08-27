<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" 
src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.selectbox { 
	position: relative; 
	width: 100%; 
	height: 40px; 
	line-height: 40px; 
	background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; 
	border: 1px solid #999; 
	z-index: 1; 
	margin-top: 30px;
} 
.selectbox label { 
	position: absolute; 
	top: 0px; 
	left: 5px; 
	height: 40px; 
	line-height: 40px; 
	color: #999; 
	z-index: -1; 
} 
.selectbox select { 
	width: 100%; 
	height: 40px; 
	line-height: 40px; 
	font-family: inherit; 
	border: 0; 
	opacity: 0; 
	filter:alpha(opacity=0); 
	-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
	-moz-appearance: none; 
	appearance: none; 
}

.send{
    border: 0;
    background: none;
    font-size: 16px;
    padding: 8px 20px;
    background: #49b5e7;
    color: #fff;
    transition: 0.3s;
    border-radius: 4px 4px 4px 4px;
    box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.1);
  	outline: none;    
  	margin-top: 50px;
}
.send:hover{
	opacity: 0.85;
}

input[type="password"]{
    width: 100%;
    border: 1px solid #bfbbbb;
    box-shadow: 0 8 0 0;
    margin-top: 30px;
    height: 30px;
    padding: 2px;
    outline: none;
}
</style>
</head>
<body>
<div style="padding: 50px 120px; text-align: center;">
<c:if test="${param.type=='remove'}">
<h2>탈퇴사유</h2>
<div class="selectbox">
    <label for="ex_select">탈퇴사유 선택</label>
    <select id="ex_select">
        <option>활동 없음</option>
        <option>유해 인물</option>
        <option>사용자 요청</option>
        <option>기타</option>
    </select>
    <form name="f">
    <input type="password" name="pass" placeholder="이메일 비밀번호를 입력해주세요">
    <button class="send" type="submit" onclick="sendMail('${param.id}','${param.type}')">전&nbsp;&nbsp;송</button>
	</form>
</div>
</c:if>
<c:if test="${param.type!='remove'}">
<h2>반려사유</h2>
<div class="selectbox">
    <label for="ex_select">반려사유 선택</label>
    <select id="ex_select">
        <option>카테고리 부적합</option>
        <option>컨텐츠 부적합</option>
        <option>튜터 소개 내용 부족</option>
        <option>수업 소개 내용 부족</option>
    </select>
    <form name="f">
    <input type="password" name="pass" placeholder="이메일 비밀번호를 입력해주세요">
    <button class="send" type="submit" onclick="sendMail('${param.id}','${param.classid}')">전&nbsp;&nbsp;송</button>
	</form>
</div>
</c:if>
</div>

<script type="text/javascript">
	var select_value;
	
	$(document).ready(function() { 
	var selectTarget = $('.selectbox select'); 
	selectTarget.change(function(){ 
		select_value = $(this).children('option:selected').text(); 
		$(this).siblings('label').text(select_value); 
		}); 
	});
	
	function sendMail(id,classid) {
		var pass = f.pass.value;
		$.ajax({
			type: 'POST',
			url: 'reason01.shop',
			data:{
                "id" : id,
                "classid" : classid,
                "pass" : pass, 
                "reason" : select_value
			},
			success: function(data) {
				console.log("success"+data);
			},error:function(xhr,status){
				console.log("error");
			}
		});
		alert(id+"님에게 사유를 전송하였습니다.");
	    self.close();
	}	
</script>
</body>
</html>