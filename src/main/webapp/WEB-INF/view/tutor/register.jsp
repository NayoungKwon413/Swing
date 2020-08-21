<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="port" value="${pageContext.request.localPort}" />
<c:set var="server" value="${pageContext.request.serverName}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>튜터 수업 추가 페이지</title>
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
<style type="text/css">
hr{
	margin: 50px 0px; 
}
.title{
  font-size: 14px;
  line-height: 26px;
  color: #777777;
  font-weight: 700;
}
.title-300{
	margin-bottom: 300px;
}
.title-250{
	margin-bottom: 250px;
}
.title-200{
	margin-bottom: 200px;
}
.title-100{
	margin-bottom: 100px;
}
.title-50{
	margin-bottom: 50px;
}
.title-20{
	margin-bottom: 20px;
}

.upf_b{
	position: absolute;
	margin-left:95px;
	margin-top:90px;
}
.upf{
	width:130px;
	height:130px;
	border-radius:50%;
	background-position:center;
	background-size:cover;
}
.costbox{
	background-color: #d6d6d6;
	width:400px; height:150px; border: 1px c7c7c7; border-radius: 7px;
}
.costbox > p{
}

button {
    background-color: #3498DB;
    color: #fff;
    width: 80px;
    height: 35px;
    border-radius: 5px;
    font-size: 14px;
    border: 0;
    outline: none;
}

button:hover {
	opacity: 0.85;
}
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
// 각 입력칸 자료형에 맞는 유효성 검증 필요
// numclass, numtutee : 다회차, 그룹일 떄 2이상 입력 유효성 검증 필요 , 최대 수 얼마?
// 코드 더 줄일 수 있는지 검색

$(document).ready(function(){
	var price = 0;
	var time = 0;
	var totaltime = 0;
	if(${clas.maxtutee > 1}) {
		$("#numtutee").val(${clas.maxtutee})
		$("#numtutee").show();
	}else{
		$("#numtutee").hide();
	}
	
	$("#numclass").hide();
	
	$('input[name="maxtutee"]').change(function() {
	    // 모든 radio를 순회한다.
	    $('input[name="maxtutee"]').each(function() {
	        var value = $(this).val();            
	        var checked = $(this).prop('checked');  
	        // jQuery 1.6 이상 (jQuery 1.6 미만에는 prop()가 없음, checked, selected, disabled는 꼭 prop()를 써야함)
	        // jQuery 1.6 미만 (jQuery 1.6 이상에서는 checked, undefined로 return됨)
	 
	        if(value==1){
	        	if(checked){
	        		$("#numtutee").hide();
		        	$("#numtutee").val(1);
		        	
	        	}
	        }else if(value==2){
				if(checked){
					$("#numtutee").val(0);
					$("#numtutee").show();
	        	}
	        }
	    });
	});
	
	$('input[name="type"]').change(function() {
	    // 모든 radio를 순회한다.
	    $('input[name="type"]').each(function() {
	        var value = $(this).val();            
	        var checked = $(this).prop('checked');  
	        // jQuery 1.6 이상 (jQuery 1.6 미만에는 prop()가 없음, checked, selected, disabled는 꼭 prop()를 써야함)
	        // jQuery 1.6 미만 (jQuery 1.6 이상에서는 checked, undefined로 return됨)
	 
	        if(value==1){
	        	if(checked){
	        		$("#numclass").hide();
		        	$("#numclass").val(1);
		        	$("#totaltime").val(1);
			 		$("#totaltime").attr('readonly',true)
	        	}
	        }else if(value==2){
				if(checked){
					$("#numclass").val(0); 
					$("#numclass").show();
					$("#totaltime").attr('readonly',false);
	        	}
	        }
	    });
	});
	
	$("#price").on("propertychange change keyup paste input", function() {
    	price = $(this).val();
    	cal(price,time,totaltime);
	});
	
	$("#time").on("propertychange change keyup paste input", function() {
    	time = $(this).val();
    	cal(price,time,totaltime);
	});
	
	$("#totaltime").on("propertychange change keyup paste input", function() {
    	totaltime = $(this).val();
    	cal(price,time,totaltime);
	});
});

function cal(price, time, totaltime){
	document.getElementById("cal").textContent = price + "원 X " + time + "시간 X " + totaltime + "회";
	if(price!=0 && time!=0 && totaltime!=0) {
		var totalprice = price * time * totaltime;
		document.getElementById("cal2").textContent = "총 " + totalprice + "원";
	}
	
}
</script>
</head>
<body>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="#info1"><h2>튜터 등록</h2></a>
          <a href="#info1" class="select">01기본정보</a>&nbsp;>
          <a href="#info2">02제목/이미지</a>&nbsp;>
          <a href="#info3">03가격</a>&nbsp;>
          <a href="#info4">04수업</a>
          <hr style="margin-top: 15px;">
          </div>
     </div>
 </section>
<section id="tutor-regi" class="tutor-regi">
<form method="post" action="classEntry.shop" enctype="multipart/form-data">
<input type="hidden" name="cid" value="${cid}" />
<div class="container">
	<div class="row">
		<div class="col-lg-3">
	        <div class="info">
	          <div class="address">
	          <div id="info1"></div>
	             <i class="icofont-google-map"></i>
	               <h4>기본정보</h4>
	               <p>프로필,별명,인증</p>
	          </div>
	        </div>
        </div>
	    <div class="col-lg-8 mt-5 mt-lg-0">
	    <!-- 기본정보 -->
	    <div class="form-group">
	    	<div class="title">프로필-</div>
			<div style="margin: 30px 0">
				<img class="upf_b button"  src="https://front-img.taling.me/Content/Images/tutor/Images/btn_pfimg.png">
                <div class="upf" id="picture-cover" style="background-image: url('http://${server}:${port}${path}/user/save/${user.userid}_${user.file}')">
	                <input type="file" id="picture" name="picture" style="width:150px;height:130px;opacity:0;" onchange="setThumbnail(event);" value=""/>  
	                <input type="hidden" id="file" name="file" value=""/> 
                    <input type="hidden" id="fileurl" name="fileurl" />
                    <script> 
		   			 function setThumbnail(event) { 
						var reader = new FileReader(); 
						reader.onload = function(event) {
						document.getElementById("picture-cover").style.backgroundImage="url("+reader.result+")";
		            	document.getElementById("fileurl").value= reader.result;
	            	}; 
	            	reader.readAsDataURL(event.target.files[0]); 
	            	var fname =event.target.files[0].name;
	            	document.getElementById("file").value= fname;
            		}
	        		</script>    
                </div>
            </div>
			<div class="title">별명-</div>
                <input type="text" class="form-cont" name="nickname" id="nickname" value="${user.nickname}" placeholder="별명" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
        </div>
		<div class="form-group">
		<!-- 인증 -->
			<div class="title">학력-</div>
				<select name="edulevel">
					<option value="1" <c:if test="${user.edulevel eq 1}">selected="selected"</c:if>>고등학교</option>
					<option value="2" <c:if test="${user.edulevel eq 2}">selected="selected"</c:if>>대학교</option>
					<option value="3" <c:if test="${user.edulevel eq 3}">selected="selected"</c:if>>대학원</option>
				</select>
                <input type="text" class="form-cont" name="school" id="school" value="${user.school}" placeholder="ex)스윙대학교" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
                <input type="text" class="form-cont" name="major" id="major" value="${user.major}" placeholder="ex)스윙학과" data-rule="email" data-msg="Please enter a valid email">
                <div class="validate"></div>
                <input type="hidden" name="edufile" />
        </div>
		<div class="form-group">
			<div class="title">자격증-</div>
                <input type="text" class="form-cont" name="lctitle" id="lctitle" value="${license.lctitle}" placeholder="ex)토익900" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <input type="hidden" name="lcfile">
                <div class="validate"></div>
                <button type="submit">업로드</button>
		</div>
		<hr> 
       </div>  
	</div>
	<div class="row">
		<div class="col-lg-3">
	        <div class="info">
	          <div class="address">
   	          <div id="info2"></div>
	             <i class="icofont-google-map"></i>
	               <h4>수업등록</h4>
	               <p>지역,카테고리,수업형태,<br>참여인원,제목,이미지</p>
	          </div>
	        </div>
        </div>
	    <div class="col-lg-8 mt-5 mt-lg-0">
	    <!-- 기본정보 -->
	    <div class="form-group">
	    	<div class="title">지역-</div>
				<input type="text" class="form-cont" name="location1" id="location1" value="${clas.location1}" placeholder="ex)서울" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
                <input type="text" class="form-cont" name="location2" id="location2" value="${clas.location2}" placeholder="ex)금천구" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
			<div class="title">카테고리-</div>
				<select name="category">
					<option value="1" <c:if test="${clas.category eq 1}">selected="selected"</c:if>>요리/베이킹</option>
					<option value="2" <c:if test="${clas.category eq 2}">selected="selected"</c:if>>반려동물</option>
					<option value="3" <c:if test="${clas.category eq 3}">selected="selected"</c:if>>사진</option>
					<option value="4" <c:if test="${clas.category eq 4}">selected="selected"</c:if>>핸드메이드</option>
					<option value="5" <c:if test="${clas.category eq 5}">selected="selected"</c:if>>술</option>
				</select>
                <div class="validate"></div>
        </div>
		<div class="form-group">
		<!-- 인증 -->
			<div class="title">수업형태-</div>
                <input type="radio" name="type" value="1" <c:if test="${clas.type eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">원데이 클래스
                <!-- 다회차 클릭시 밑에 회차정보 갯수만큼 뜸 -->
                <input type="radio" name="type" value="2" <c:if test="${clas.type eq 2}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">다회차 수업
        		<!-- <input type="text" class="form-cont" name="numclass" id="numclass" value="1" />회 -->
        </div>
		<div class="form-group">
			<div class="title">참여인원-</div>
                <input type="radio" name="maxtutee" value="1" <c:if test="${clas.maxtutee eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">1:1
                <!-- 그룹 클릭시 인원 선택 뜸 -->
                <input type="radio" name="maxtutee" value="2" <c:if test="${clas.maxtutee > 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">그룹수업
                <input type="text" class="form-cont" name="numtutee" id="numtutee" value="" />명
		</div>
		<div class="form-group">
			<div class="title">수업제목-</div>
                <input type="text" class="form-cont" name="subject" id="subject" value="${clas.subject}" placeholder="수업제목" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
		</div>
		<div class="form-group">
			<div class="title">커버이미지-</div>
				<img style="width:400px; height:250px; border: 1px c7c7c7; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" src="${path}/assets/img/portfolio/portfolio-1.jpg">
                <button type="submit">업로드</button>
		</div>
		<hr> 
       </div>  
	</div>
	<div class="row">
		<div class="col-lg-3">
	        <div class="info">
	          <div class="address">
   	          <div id="info3"></div>
	             <i class="icofont-google-map"></i>
	               <h4>가격</h4>
	               <p>가격/시간/횟수,총 가격</p>
	          </div>
	        </div>
        </div>
	    <div class="col-lg-8 mt-5 mt-lg-0">
	    <!-- 기본정보 -->
	    <div class="form-group">
	    	<div class="title">시간당 가격-</div>
			<div class="form-row">
				<input type="text" class="form-cont" name="price" value="${clas.price}" id="price" placeholder="ex)30000" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" value="">
				원
                <div class="validate"></div>
			</div>
			<div class="title">1회당 수업 시간-</div>
            <div class="form-row">
				<input type="text" class="form-cont" name="time" value="${clas.time}" id="time" placeholder="1회당 수업시간을 선택하세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
				시간
                <div class="validate"></div>
			</div>
        </div>
		<div class="form-group">
		<!-- 인증 -->
			<div class="title">총 수업횟수-</div>
			<!-- 원데이 클래스는 1회 / 다회차 수업은 n회 선택 가능 (최대 회차수는?) -->
            <div class="form-row">
				<input type="text" class="form-cont" name="totaltime" value="${clas.totaltime}" id="totaltime" placeholder="ex)1" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" <c:if test="${clas.type eq 1}">readonly</c:if> >
				회
                <div class="validate"></div>
			</div>
        </div>
		<div class="form-group">
			<div class="title">총 가격-</div>
                <div class="costbox">
                <div style="padding: 30px;">
                	<p id="cal">0원 X 0시간 X 0회</p>
                	<p id="cal2" style="text-align: right;">총 0원</p>
					<p style="text-align: right;">연결 수수료 0원</p>
				</div>
				</div>
		</div>
		<hr> 
       </div>  
	</div>
	<div class="row">
		<div class="col-lg-3">
	        <div class="info">
	          <div class="address">
   	          <div id="info4"></div>
	             <i class="icofont-google-map"></i>
	               <h4>수업소개</h4>
	               <p>튜터소개,수업소개,수업상세</p>
	          </div>
	        </div>
        </div>
	    <div class="col-lg-8 mt-5 mt-lg-0">
	    <!-- 기본정보 -->
	    <div class="form-group">
	    	<div class="title">튜터소개-</div>
				<textarea class="form-cont" name="tutorintro" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="튜터소개">${clas.tutorintro}</textarea>
	            <div class="validate"></div>
			<div class="title">수업소개-</div>
                <textarea class="form-cont" name="classintro" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="수업소개">${clas.classintro}</textarea>
                <div class="validate"></div>
            <div class="title">수업레벨-</div>
            	<input type="radio" name="level" id="level1" value="1" <c:if test="${clas.level eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">입문자
                <input type="radio" name="level" id="level2" value="2" <c:if test="${clas.level eq 2}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">초/중급자          
                <input type="radio" name="level" id="level3" value="3" <c:if test="${clas.level eq 3}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">상급자                      
                <div class="validate"></div>
        </div>
		<div class="form-group">
		<!-- 인증 -->
		<!-- 	<div class="title">1회차-</div>
                <input type="text" class="form-cont" name="subject" id="subject" placeholder="수업 제목" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
                <input type="email" class="form-cont" name="email" id="email" placeholder="수업 상세 내용" data-rule="email" data-msg="Please enter a valid email">
                <div class="validate"></div>
        -->
        </div>
       </div>  
	</div>
	<hr> 
	<div class="row" style="float: center;"><button type="submit" name="button" value="미리보기">미리보기</button><button type="submit" name="button" value="임시저장">임시저장</button><button type="submit" name="button" value="승인요청">승인요청</button></div>
</div>
</form>
</section>
</body>
</html>