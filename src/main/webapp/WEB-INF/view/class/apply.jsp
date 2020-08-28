<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link href="${path}/assets/css/apply.css" rel="stylesheet">
</head>
<body>
<section>
	<div class="container">
		<div class="tutor_cont">
			<div class="title_box">
				<h1>수업신청</h1>
				<ul>
					<li>01일정/장소</li>
					<span>></span>
					<li style="color:#49b5e7">02결제</li>
					<span>></span>
					<li>03완료</li>
				</ul>
			</div>
			<div class="class_title">
				${cls.subject}
			</div>
			<div class="apply">
				<div class="profile_box">
					<div class="profile" style="background-image:url('http://${server}:${port}${path}/user/save/${tutor.userid}_${tutor.file}')"></div>
					<p class="triangle-border top gray" style="margin-top:50px; text-align:center;">
						수업에 오신걸 환영해요!<br>
						결제는<br>
						<span>카카오페이</span>만 가능합니다.
					</p>
				</div>
				<div class="sh_box class_price">
					<form action="">
						<div id="alltime">
							<div class="level3 bottom">
								<div class="left" style="margin-top:15px;">전체 수업료</div>
								<div class="right2">
									<fmt:formatNumber value="${cls.totalprice}" var="price" pattern="#,###"/>
									<font style="font-size:14px; font-weight:500;">${price}원</font>
								</div>
							</div>
							<div class="level bottom" style="padding-top:0.5em;">
								<div class="left" style="width:20%;">결제금액</div>
								<div class="right2">
									<fmt:formatNumber value="${(cls.totalprice*0.1)+cls.totalprice}" var="totalprice" pattern="#,###"/>
									<span id="payArea2">${totalprice}</span>원
									<font color="#666" style="font-size:12px;">(수업가격+VAT 10%)</font>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div id="nextButton" class="next button" onclick="payPop();">결제</div>
			<script type="text/javascript">
				function payPop(){
			        var IMP = window.IMP; // 생략가능
			        IMP.init('imp23418340'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			        var msg;
			        
			        IMP.request_pay({
			            pg : 'kakaopay',
			            pay_method : 'card',
			            merchant_uid : 'merchant_' + new Date().getTime(),
			            name : '${cls.subject}',
			            amount : '${totalprice}',
			            buyer_email : '${tutee.email}',
			            buyer_name : '${tutee.name}',      
			          //  buyer_tel:'010-1234-4039',
			          //  m_redirect_url : 'http://www.naver.com' //결제 완료 후 보낼 컨트롤러 메소드명
			        }, function(rsp) {
			            if ( rsp.success ) {
			            	var msg="결제가 완료되었습니다."
			            	location.href='paysuccess.shop?classid=${param.classid}&classno=${param.classno}'
			            } else {
			                msg = '결제에 실패하였습니다.';
			                msg += '에러내용 : ' + rsp.error_msg;
			            }
			            alert(msg);
			        });
			        
				}
			</script>
		</div>
	</div>
</section>
</body>
</html>