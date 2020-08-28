<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
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
		$("#num").hide();
	}
	if(${clas.location2 != null}) {
		var area = "${clas.location1}";
		console.log(area);
		if(area=='서울'){
			msg = "<select id='location2'>"+
				"<option value='강남'>강남</option>"+
				"<option value='건대'>건대</option>"+
				"<option value='잠실'>잠실</option>"+
				"<option value='종로'>종로</option>"+
				"<option value='홍대'>홍대</option>"+
				"</select>";
		}else if(area=='경기'){
			msg = "<select id='location2'>"+
			"<option value='분당'>분당</option>"+
			"<option value='부천'>부천</option>"+
			"<option value='수원'>수원</option>"+
			"<option value='안산'>안산</option>"+
			"<option value='안양'>안양</option>"+
			"<option value='일산'>일산</option>"+
			"</select>";
		}else if(area=='인천'){
			msg = "<select id='location2'>"+
			"<option value='부평'>부평</option>"+
			"<option value='송도'>송도</option>"+
			"</select>"
		}else{
			msg="<select id='area'>"+
				"<option value=''>지역을 선택하세요</option>"+
				"</select>";
		}
		$("#location2").html(msg);
		$("#location2").val('${clas.location2}').prop("selected",true);
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
	        		$("#num").hide();
		        	$("#numtutee").val(1);
		        	
	        	}
	        }else if(value==2){
				if(checked){
					$("#numtutee").val(0);
					$("#numtutee").show();
					$("#num").show();
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
		        	$("#totaltime").val(1);
			 		$("#totaltime").attr('readonly',true)
			 		document.getElementById("cal").textContent = price + "원 X " + time + "시간 X 1회";
			 		$('#seqlist').empty();
			 		var form = "<p>1회차</p>"
	    	    	+ "<input type='text' class='form-cont' name='title' id='title1' placeholder='회차 제목' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>"
	    	        + "<input type='text' class='form-cont' name='curri' id='curri1' placeholder='회차 상세 내용' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>";
	    	    	$("<div>").attr("id","seq1").html(form).appendTo("#seqlist");
	    	    	$("typevalue").val("원데이 클래스");
	        	}
	        }else if(value==2){
				if(checked){
					$("#totaltime").attr('readonly',false);
					$("typevalue").val("다회차 수업");
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
	
	$("#totaltime").on("change", function() {
		var classeq = $(this).val();
		var max = ++classeq
		console.log("classeq:"+classeq);
    	$('#seqlist').empty();
    	for(i=1;i<max;i++){
    		console.log("회차:"+i);
    		var form = "<p>"+i+"회차</p>"
    	    	+ "<input type='text' class='form-cont' name='title' id='title"+i+"' placeholder='회차 제목' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>"
    	        + "<textarea class='form-cont' name='curri' id='curri"+i+"' rows='5' data-rule='required' data-msg='Please write something for us' placeholder='회차 상세 내용'></textarea>"
    	    $("<div>").attr("id","seq"+i).html(form).appendTo("#seqlist");
    	}
	});
	
});

function cal(price, time, totaltime){
	document.getElementById("cal").textContent = price + "원 X " + time + "시간 X " + totaltime + "회";
	if(price!=0 && time!=0 && totaltime!=0) {
		var totalprice = price * time * totaltime;
		document.getElementById("cal2").textContent = "총 " + totalprice + "원";
	}
	
}

function vaildation(kbn){
	if(kbn==2){
		if(document.f.nickname.value==''){
			alert('별명을 입력하세요.');
			document.f.nickname.focus();
			return false;
		}
		if(document.f.edulevel.value==0){
			alert('최종학력을 설정하세요.');
			document.f.edulevel.focus();
			return false;
		}
		if(document.f.location1.value==''){
			alert('지역을 설정하세요.');
			document.f.location1.focus();
			return false;
		}
		if(document.f.type.value==''){
			alert('수업형태를 설정하세요.');
			document.f.type.focus();
			return false;
		}
		if(document.f.maxtutee.value==''){
			alert('참여인원을 설정하세요.');
			document.f.maxtutee.focus();
			return false;
		}
		if(document.f.numtutee.value>8){
			alert('참여인원은 최대 8명까지 가능합니다.');
			document.f.numtutee.focus();
			return false;
		}
		if(document.f.subject.value==''){
			alert('수업 제목을 입력하세요.');
			document.f.subject.focus();
			return false;
		}
		if(document.f.price.value==''){
			alert('시간당 가격을 설정하세요.');
			document.f.price.focus();
			return false;
		}
		if(document.f.price.value<1){
			alert('시간당 가격은 1원 이상 입력 가능합니다.');
			document.f.price.focus();
			return false;
		}
		if(document.f.time.value==''){
			alert('회당 수업시간을 설정하세요.');
			document.f.time.focus();
			return false;
		}
		if(document.f.time.value<1){
			alert('회당 수업시간은  1시간 이상 입력 가능합니다.');
			document.f.time.focus();
			return false;
		}
		if(document.f.totaltime.value==''){
			alert('총 수업횟수를 설정하세요.');
			document.f.totaltime.focus();
			return false;
		}
		if(document.f.totaltime.value<1){
			alert('총 수업횟수는 1이상 입력 가능합니다.');
			document.f.totaltime.focus();
			return false;
		}
		if(document.f.totaltime.value>8){
			alert('총 수업횟수는 최대 8회차까지 입력 가능합니다.');
			document.f.totaltime.focus();
			return false;
		}
		if(document.f.tutorintro.value==''){
			alert('튜터 소개를 입력하세요.');
			document.f.tutorintro.focus();
			return false;
		}
		if(document.f.classintro.value==''){
			alert('수업 소개를 입력하세요.');
			document.f.classintro.focus();
			return false;
		}
		if(document.f.level.value==''){
			alert('수업레벨을 설정하세요.');
			document.f.level.focus();
			return false;
		}
		/*
		if(document.f.title.value==''){
			alert('회차 제목을 입력하세요');
			document.f.title.focus();
			return false;
		}
		if(document.f.curri.value==''){
			alert('회차 내용을 입력하세요');
			document.f.curri.focus();
			return false;
		}*/
	}
	
	document.f.action = "classEntry.shop?kbn="+kbn;
	document.f.submit();
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
<form method="post" action="classEntry.shop" enctype="multipart/form-data" name="f">
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
				<input type="hidden" id="imgurl1" value="http://${server}:${port}${path}/user/save/${user.userid}_${user.file}"/>
				<img class="upf_b button"  src="https://front-img.taling.me/Content/Images/tutor/Images/btn_pfimg.png">
                <div class="upf" id="picture-cover" style="background-image: url('http://${server}:${port}${path}/user/save/${user.userid}_${user.file}')">
	                <input type="file" id="fileurl2" name="fileurl2" style="width:150px;height:130px;opacity:0;" onchange="setThumbnail(event);" value=""/>  
                    <script> 
		   			 function setThumbnail(event) { 
						var reader = new FileReader(); 
						reader.onload = function(event) {
						document.getElementById("picture-cover").style.backgroundImage="url("+reader.result+")";
						document.getElementById("imgurl1").value = reader.result;
	            	}; 
	            	reader.readAsDataURL(event.target.files[0]); 
	            	var fname =event.target.files[0].name;
            		}
	        		</script>    
                </div>
            </div>
			<div class="title">별명-</div>
                <input type="text" class="form-cont" name="nickname" id="nickname" value="${user.nickname}" placeholder="별명" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <spring:hasBindErrors name="user">
                	<c:if test="${errors.hasFieldErrors('nickname')}">
                		<strong>${errors.getFieldError('nickname').defaultMessage}</strong>
                	</c:if>
                </spring:hasBindErrors>    
        </div>
		<div class="form-group">
		<!-- 인증 -->
			<div class="title">학력-</div>
				<select name="edulevel">
					<option value="0" <c:if test="${user.edulevel eq 0}">selected="selected"</c:if>>-최종학력-</option>
					<option value="1" <c:if test="${user.edulevel eq 1}">selected="selected"</c:if>>고등학교</option>
					<option value="2" <c:if test="${user.edulevel eq 2}">selected="selected"</c:if>>대학교</option>
					<option value="3" <c:if test="${user.edulevel eq 3}">selected="selected"</c:if>>대학원</option>
				</select>
                <input type="text" class="form-cont" name="school" id="school" value="${user.school}" placeholder="ex)스윙대학교" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
                <input type="text" class="form-cont" name="major" id="major" value="${user.major}" placeholder="ex)스윙학과" data-rule="email" data-msg="Please enter a valid email">
                <div class="validate"></div>
                <input type="file" name="edufileurl" id="edufileurl" accept="image/*" style="display: none;"/>
                <button type="button" onclick="document.all.edufileurl.click()" style="width: 130px;">학력증명서 업로드</button>
        </div>
		<div class="form-group">
			<div class="title">자격증-</div>
				<div id="license">
				<c:if test="${empty lclist}">
					<c:set var="cnt" value="0"/>
					<input type="hidden" name=lcnolist[0] value="0"/>
                	<input type="text" class="form-cont" name="lctitlelist[0]" id="lctitlelist0" value="" placeholder="ex)토익900" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                	<input type="file" name="lcfilelist[0]" id="lcfilelist0" accept="image/*" style="display: none;"/>
                	<div class="validate"></div>
                	<button type="button" onclick="document.all.lcfilelist0.click()" style="width: 130px;">자격증명서 업로드</button>
				</c:if>
				<c:if test="${not empty lclist}">
					<c:set var="cnt" value="0"/>
					<c:forEach items="${lclist}" var="lc" varStatus="status">
						<c:set var="cnt" value="${status.index}"/>
						<input type="hidden" name=lcnolist[${status.index}] value="${lc.lcno}"/>
                		<input type="text" class="form-cont" name="lctitlelist[${status.index}]" id="lctitlelist${status.index}" value="${lc.lctitle}" placeholder="ex)토익900" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                		<input type="file" name="lcfilelist[${status.index}]" id="lcfilelist${status.index}" accept="image/*" style="display: none;"/>
                		<div class="validate"></div>
                		<button type="button" onclick="document.all.lcfilelist${status.index}.click()" style="width: 130px;">자격증명서 업로드</button>
					</c:forEach>
				</c:if>
				</div>
				<br>
				<script>
					function addlc(){
						var html = "<c:set var='cnt' value='${cnt + 1}'/>"
									+"<input type='hidden' name=lcnolist[${cnt}] value='0'/>"
	                	 			+"<input type='text' class='form-cont' name='lctitlelist[${cnt}]' id='lctitlelist[${cnt}]' value='' placeholder='ex)토익900' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>"
	                				+"<input type='file' name='lcfilelist[${cnt}]' id='lcfilelist[${cnt}]' accept='image/*' style='display: none;'/>"
	                				+"<div class='validate'></div>"
	                				+"<button type='button' onclick='document.all.lcfilelist[${cnt}].click()' style='width: 130px;'>자격증명서 업로드</button>";
						$("#license").append(html);
					}
				</script>
				<button type="button" onclick="addlc()">자격증 추가</button>
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
	    		<select id="location1" name="location1">
	    			<option value="">지역</option>
					<option value="서울" <c:if test="${clas.location1 eq '서울'}">selected="selected"</c:if>>서울</option>
					<option value="경기" <c:if test="${clas.location1 eq '경기'}">selected="selected"</c:if>>경기</option>
					<option value="인천" <c:if test="${clas.location1 eq '인천'}">selected="selected"</c:if>>인천</option>
	    		</select>
                <div class="validate"></div>
                <select id="location2" name="location2">
                	<option value="">지역을 선택하세요</option>
                </select>
                <div class="validate"></div>
            <script>
            $(function(){
				$('#location1').change(function(){
					var area = $(this).val();
					var msg = "";
					if(area=='서울'){
						msg = "<select id='location2'>"+
							"<option value='강남'>강남</option>"+
							"<option value='건대'>건대</option>"+
							"<option value='잠실'>잠실</option>"+
							"<option value='종로'>종로</option>"+
							"<option value='홍대'>홍대</option>"+
							"</select>";
					}else if(area=='경기'){
						msg = "<select id='location2'>"+
						"<option value='분당'>분당</option>"+
						"<option value='부천'>부천</option>"+
						"<option value='수원'>수원</option>"+
						"<option value='안산'>안산</option>"+
						"<option value='안양'>안양</option>"+
						"<option value='일산'>일산</option>"+
						"</select>";
					}else if(area=='인천'){
						msg = "<select id='location2'>"+
						"<option value='부평'>부평</option>"+
						"<option value='송도'>송도</option>"+
						"</select>"
					}else{
						msg="<select id='area'>"+
							"<option value=''>지역을 선택하세요</option>"+
							"</select>";
					}
					$("#location2").html(msg);
				})
			})
            </script>
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
				<input type="hidden" id="typevalue" <c:if test="${clas.type eq 1}">value="원데이 클래스"</c:if><c:if test="${clas.type eq 2}">value="다회차 수업"</c:if> />
                <input type="radio" name="type" value="1" <c:if test="${clas.type eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">원데이 클래스
                <!-- 다회차 클릭시 밑에 회차정보 갯수만큼 뜸 -->
                <input type="radio" name="type" value="2" <c:if test="${clas.type eq 2}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">다회차 수업
        </div>
		<div class="form-group">
			<div class="title">참여인원-</div>
                <input type="radio" name="maxtutee" value="1" <c:if test="${clas.maxtutee eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">1:1
                <!-- 그룹 클릭시 인원 선택 뜸 -->
                <input type="radio" name="maxtutee" value="2" <c:if test="${clas.maxtutee > 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">그룹수업
                <input type="text" class="form-cont" name="numtutee" id="numtutee" value="${clas.maxtutee}" /><p id="num">명</p>
		</div>
		<div class="form-group">
			<div class="title">수업제목-</div>
                <input type="text" class="form-cont" name="subject" id="subject" value="${clas.subject}" placeholder="수업제목" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">
                <div class="validate"></div>
		</div>
		<div class="form-group">
			<div class="title">커버이미지-</div>
				<input type="hidden" id="imgurl2" value="http://${server}:${port}${path}/class/coverimg/${clas.classid}_${clas.coverimg}" />
				<img id="coverimg" style="width:400px; height:250px; border: 1px c7c7c7; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" src="http://${server}:${port}${path}/class/coverimg/${clas.classid}_${clas.coverimg}">
                <input type="file" name="coverimgurl" id="coverimgurl" accept="image/*" onchange="setThumbnail2(event);" style="display: none;"/>
                <button type="button" onclick="document.all.coverimgurl.click()">업로드</button>
			<script> 
		    function setThumbnail2(event) { 
		    	console.log("이벤트실행")
				var reader = new FileReader(); 
				reader.onload = function(event) {
					console.log("reader");
					document.getElementById("coverimg").src = reader.result;
					document.getElementById("imgurl2").value = reader.result;
	            }; 
	            reader.readAsDataURL(event.target.files[0]); 
	            var fname =event.target.files[0].name;
	            console.log(fname);
            }
	        </script>
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
				<input type="text" class="form-cont" name="price" id="price" value="${clas.price}" id="price" placeholder="ex)30000" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				원
                <div class="validate"></div>
			</div>
			<div class="title">1회당 수업 시간-</div>
            <div class="form-row">
				<input type="text" class="form-cont" name="time" id="time" value="${clas.time}" id="time" placeholder="1회당 수업시간을 선택하세요" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				시간
                <div class="validate"></div>
			</div>
        </div>
		<div class="form-group">
		<!-- 인증 -->
			<div class="title">총 수업횟수-</div>
			<!-- 원데이 클래스는 1회 / 다회차 수업은 n회 선택 가능 (최대 회차수는?) -->
            <div class="form-row">
				<input type="text" class="form-cont" name="totaltime" id="totaltime" value="${clas.totaltime}" id="totaltime" placeholder="ex)1" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" <c:if test="${clas.type eq 1}">readonly</c:if> >
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
				<textarea class="form-cont" name="tutorintro" id="tutorintro" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="튜터소개">${clas.tutorintro}</textarea>
	            <div class="validate"></div>
			<div class="title">수업소개-</div>
                <textarea class="form-cont" name="classintro" id="classintro" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="수업소개">${clas.classintro}</textarea>
                <div class="validate"></div>
            <div class="title">수업레벨-</div>
            	<input type="radio" name="level" id="level1" value="1" <c:if test="${clas.level eq 1}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">입문자
                <input type="radio" name="level" id="level2" value="2" <c:if test="${clas.level eq 2}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">초/중급자          
                <input type="radio" name="level" id="level3" value="3" <c:if test="${clas.level eq 3}"> checked="checked" </c:if> data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject">상급자                      
                <div class="validate"></div>
        </div>
        <div class="title">회차소개-</div>
		<div class="form-group" id="seqlist" >
		<!-- 인증 -->
		<c:if test="${empty classinfo}">
			<div id="seq1">
			<p>1회차</p>
	    	<input type="text" class="form-cont" name="title" id="title1" value="" placeholder='회차 제목' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>
	    	<textarea class="form-cont" name="curri" id="curri1" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="회차 상세 내용"></textarea>
			</div>
		</c:if>
		<c:if test="${not empty classinfo}">
		<c:forEach items="${classinfo}" var="info" varStatus="status">
			<div id="seq${status.count}">
			<p>${status.count}회차</p>
	    	<input type="text" class="form-cont" name="title" id="title${status.count}" value="${info.title}" placeholder='회차 제목' data-rule='minlen:4' data-msg='Please enter at least 8 chars of subject'>
	    	<textarea class="form-cont" name="curri" id="curri${status.count}" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="회차 상세 내용">${info.curri}</textarea>
			</div>
		</c:forEach>
		</c:if>
        </div>
        </div>  
	</div>
	<hr> 
	<script type="text/javascript">
        var openWin;
        function openChild()
        {
            // window.name = "부모창 이름"; 
            window.name = "parentForm";
            // window.open("open할 window", "자식창 이름", "팝업창 옵션");
            openWin = window.open("detail.shop",
                    "childForm", "width=570, height=350, resizable = no, scrollbars = no");    
        }
    </script>
	<div class="row" style="float: center;">
	<button type="button" name="button" value="미리보기" onclick="openChild()">미리보기</button>
	<button type="button" name="button" value="임시저장" onclick="vaildation(1)">임시저장</button>
	<button type="button" name="button" value="승인요청" onclick="vaildation(2)">승인요청</button></div>
</div>
</form>
</section>
</body>
</html>