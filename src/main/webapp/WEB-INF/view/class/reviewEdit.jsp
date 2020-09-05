<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/assets/css/classdetail.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<style type="text/css">
body {margin: 0;}
</style>
<script>
$(function(){
	$(".star").on('click',function(){
		   var idx = $(this).index();
		   $(".star").removeClass("on");
		     for(var i=0; i<idx; i++){
		        $(".star").eq(i).addClass("on");
		   }
		    var point = (idx)*0.5;
		    $("#calc_point").html(point);
		   $("#star").val(point)
		 });	
	$("#content").keyup(function(){
		var content=$(this).val();
		$('#counter').html(content.length+"/150");
		$("#content").keyup();
	})
	})
</script>
</head>
<body>
<div class="pop_review">
	<div class="top">내 리뷰 등록</div>
	<div class="star_box">
		<div class="title">${subject}</div>
		<div class="input_star">
			<div class="review_point">
				<input type="hidden" id="Avg" value="${review.star}">
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
			<script type="text/javascript">
				$(function(){
					var idx = $('#Avg').val()/0.5;
					for(var i=0; i<idx; i++){
						$(".star").eq(i).addClass("on");
						$(".review_box .star").eq(i).addClass("on");
					}
				})
			</script>
			<div id="calc_point">${review.star}</div>
			<p>별점을 입력하세요</p>
		</div>
	</div>  
	<form:form modelAttribute="review" name="form" id="form" method="post">
	<input type="hidden" id="star" name="star" value="">
	<form:hidden path="classid" id="classid" name="classid" />
	<form:hidden path="classno" id="classno" name="classno" />
	<form:hidden path="reviewno" id="reviewno" name="reviewno" />
	<div class="input">
		<form:textarea path="content" class="input_content" 
		cols="1" rows="1" maxlength="150"/>
		<span id="counter">0/150</span>
	</div>
	<div class="bottom">
	<div id="cancelButton" class="cancel button" onclick="window.close();">취소</div>
	<div id="nextButton" class="next button">수정</div>
		<script type="text/javascript">
		$(function(){
			$("#nextButton").click(function(){
				var params = $("#form").serialize();
				$.ajax({
					type:"POST",
					url:'reviewEdit.shop',
					data:params,
					success:function(data){
						opener.parent.location.reload();
						window.close();
					},error:function(xhr,status){
						alert(xhr+":"+status);
					}
				});	
			})
			})
	</script>
	</div>
	</form:form>
</div>
</body>
</html>