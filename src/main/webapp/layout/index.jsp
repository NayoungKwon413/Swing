<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator"
		   uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<title>스윙</title>
<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <c:set var="path" value="${pageContext.request.contextPath}"/>

  <meta content="" name="descriptison">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="${path}/assets/img/s.png" rel="icon">
  <link href="${path}/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Dosis:300,400,500,,600,700,700i|Lato:300,300i,400,400i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${path}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${path}/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="${path}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="${path}/assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="${path}/assets/vendor/line-awesome/css/line-awesome.min.css" rel="stylesheet">
  <link href="${path}/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="${path}/assets/css/common.css" rel="stylesheet">
  <link href="${path}/assets/css/index.css" rel="stylesheet">
    <link href="${path}/assets/css/list.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Butterfly - v2.1.0
  * Template URL: https://bootstrapmade.com/butterfly-free-bootstrap-theme/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<script type="text/javascript"
	src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<script type="text/javascript"
src="https://www.chartjs.org/dist/2.9.3/Chart.min.js"></script>
<script type="text/javascript" 
src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<decorator:head/>
<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">

      <a href="${path}/class/main.shop" class="logo mr-auto"><img src="${path}/assets/img/icon/ci3.png" alt="" class="img-fluid"></a>
      <!-- Uncomment below if you prefer to use text as a logo -->
      <!-- <h1 class="logo mr-auto"><a href="index.html">Butterfly</a></h1> -->

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <c:if test="${empty sessionScope.loginUser}">
          <li class="active"><a href="${path}/user/login.shop">로그인</a></li>
          <li><a href="${path}/user/join.shop">회원가입</a></li>
          </c:if>
          
          <c:if test="${!empty sessionScope.loginUser}">
          <c:if test="${sessionScope.loginUser.userid=='admin'}">
          <li><a href="${path}/admin/userlist.shop">회원목록</a></li>
          <li><a href="${path}/admin/classlist.shop?get=0">수업목록</a></li>
          <li><a href="${path}/admin/applylist.shop?get=0">수업신청목록</a></li>
          <li><a href="${path}/admin/chart.shop">수익조회</a></li>
          <li class="drop-down"><a href="">${sessionScope.loginUser.userid}님의 마이 페이지</a>
            <ul>
              <li><a href="${path}/user/info.shop?id=${sessionScope.loginUser.userid}">내 프로필</a></li>
              <li><a href="${path}/user/password.shop">비밀번호 변경</a></li>
              <li><a href="${path}/user/logout.shop">로그아웃</a></li>
            </ul>
          </li>
          </c:if>
          <c:if test="${sessionScope.loginUser.userid!='admin'}">
          <li class="drop-down"><a href="">튜 터</a>
            <ul>
              <li><a href="${path}/tutor/register.shop">튜터 등록</a></li>
              <li><a href="${path}/tutor/my.shop">승인 상태</a></li>
              <li><a href="${path}/tutor/result.shop">내 수업</a></li>
              <li><a href="${path}/tutor/outcome.shop">수업 성과</a></li>
            </ul>
          </li>
          <li><a href="" onclick="window.open('${path}/talk/main.shop?userid=${sessionScope.loginUser.userid}&type=tutee','','width=500, height=650');">실시간톡</a></li>
          <li><a href="${path}/tutee/classlist.shop?userid=${sessionScope.loginUser.userid}&state=1">수강목록</a></li>
          <li><a href="${path}/tutee/wishlist.shop">위시리스트</a></li>
          <li class="drop-down"><a href="">${sessionScope.loginUser.userid}님의 마이 페이지</a>
            <ul>
              <li><a href="${path}/user/info.shop?id=${sessionScope.loginUser.userid}">내 프로필</a></li>
              <li><a href="${path}/user/password.shop">비밀번호 변경</a></li>
              <li><a href="${path}/user/delete.shop">회원탈퇴</a></li>
              <li><a href="${path}/user/logout.shop">로그아웃</a></li>
            </ul>
          </li>
          </c:if>
          </c:if>
        </ul>
      </nav><!-- .nav-menu -->

    </div>
  </header><!-- End Header -->
<decorator:body/>
  <!-- ======= Footer ======= -->
  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6 footer-contact">
            <h3>Butterfly</h3>
            <p>
              A108 Adam Street <br>
              New York, NY 535022<br>
              United States <br><br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> info@example.com<br>
            </p>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Social Networks</h4>
            <p>Cras fermentum odio eu feugiat lide par naso tierra videa magna derita valies</p>
            <div class="social-links mt-3">
              <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
              <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
              <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
              <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
              <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="container py-4">
      <div class="copyright">
        &copy; Copyright <strong><span>Butterfly</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/butterfly-free-bootstrap-theme/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/jquery/jquery.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/venobox/venobox.min.js"></script>
  <script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
  <script src="assets/vendor/counterup/counterup.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>