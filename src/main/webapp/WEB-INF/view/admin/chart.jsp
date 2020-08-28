<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수익 조회</title>
<link href="${path}/assets/css/admin-style.css" rel="stylesheet">
<link href="${path}/assets/css/tutor-style.css" rel="stylesheet">
<style type="text/css">
.achievement__item {
    text-align: center;
    margin-bottom: 30px;
}
.fa {
    background-image: url('${path}/assets/img/hero-img.png');
    display: inline-block;
    font: normal normal normal 14px/1 FontAwesome;
    font-size: inherit;
    text-rendering: auto;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}
.achievement__item span {
    font-size: 40px;
    color: #4c57d6;
}
.fa-user-o:before {
    background-image: url('${path}/assets/img/hero-img.png');
}
.achieve-counter {
    font-size: 32px;
    font-weight: bold;
    text-transform: uppercase;
    color: #0f394c;
}
.team .container h2 {
    text-align: center;
}

.img-fluid1 {
	width: 40px;
	height: 40px;
}


.team .container .achievement__item h2{
	margin-bottom:  0px;
}

.table td {
    border-top: 0px solid #ebedf2;
}
.icon-box {
    padding: 30px;
    position: relative;
    overflow: hidden;
    border-radius: 10px;
    margin: 10px 10px 40px 10px;
    background: #fff;
    box-shadow: 0 10px 29px 0 rgba(68, 88, 144, 0.1);
    transition: all 0.3s ease-in-out;
}
</style>
</head>
<body>
<section id="team" class="team" style="margin-bottom: 200px;">
      <div class="container">
          <div style="text-align: right;">
	          <a href="#info1"><h2 style="text-align: left;">수익 조회</h2></a>
	          <hr style="margin-top: 30px; margin-bottom: 30px;">
          </div>
          <div class="row">
			<div class="col-lg-3 col-md-3 col-sm-6">
			<div class="achievement__item">
			<img src="${path}/assets/img/icon/won.png" alt="" class="img-fluid1">
			<h2 class="achieve-counter"><fmt:formatNumber value="${list[1]}" pattern="#,###"/>원</h2>
			<p>이번달 결제 금액</p>
			</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-6">
			<div class="achievement__item">
			<img src="${path}/assets/img/icon/won.png" alt="" class="img-fluid1">
			<h2 class="achieve-counter"><fmt:formatNumber value="${list[0]}" pattern="#,###"/>원</h2>
			<p>지난달 결제 금액</p>
			</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-6">
			<div class="achievement__item">
			<img src="${path}/assets/img/icon/Money.png" alt="" class="img-fluid1">
			<h2 class="achieve-counter"><fmt:formatNumber value="${list[2]}" pattern="#,###"/>원</h2>
			<p>누적 금액</p>
			</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-6">
			<div class="achievement__item">
			<img src="${path}/assets/img/icon/rev3.png" alt="" class="img-fluid1">
			<h2 class="achieve-counter"><fmt:formatNumber value="${(list[1]-pricelist[0]) / pricelist[0] * 100}" pattern="#.##" />%</h2>
			<p>전월대비 상승률</p>
			</div>
			</div>
		  </div>
      	  <div class="row" style="height: 400px;">
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card" style="height: 100%">
                  <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                    <h4 class="card-title">
					<select name= "column" style="border: none; width: 30%; outline: none;">
							<option value="">2020년</option>
					</select>
					</h4>
                    <canvas id="chart-barChart" style="height: 204px; display: block; width: 408px;" width="408" height="204" class="chartjs-render-monitor"></canvas>
                    <script type="text/javascript">
                	var randomColorFactor = function(){
                		return Math.round(Math.random()*255);
                	}
                	//rgb :
                	var randomColor = function(opacity){
                		return "rgba(" + randomColorFactor() + ","
                					+ randomColorFactor() + ","
                					+ randomColorFactor() + ","
                					+ (opacity || ".8") + ")";
                	};
                	var color = randomColor(1)
                	var config = {
                		type : 'bar',
                		data: {
                			datasets : [{
                				data:[<c:forEach items="${map}" var="m">"${m.value}",</c:forEach>],
                				backgroundColor:[<c:forEach items="${map}" var="m">randomColor(1),</c:forEach>],
                			}],
                			labels:[<c:forEach items="${map}" var="m">"${m.key}월",</c:forEach>]
                			},
                		options:{
                			responsive:true,
                			legend: {display: false},
                			title:{display:true, text: '2020년 월별 총 결제금액'},
                			scales:{
                				yAxes:[{
                					ticks:{
                						beginAtZero:true
                					}
                				}]
                			}
                		}
                	};
                	window.onload = function(){
                		var ctx = document.getElementById("chart-barChart").getContext("2d");
                		new Chart(ctx,config);
                	}
                </script>
                  </div>
                </div>
              </div>
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card"  style="height: 100%">
                  <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                     <div style="width: 100%">
	                     <label class="badge badge-info">튜터 랭킹</label>
                     </div>
                     <table class="table table-hover">
                      <tbody>
                      <c:forEach items="${tutor}" var="t">
                        <tr>
                          <td><c:if test="${t.rank==1}"><img src="${path}/assets/img/icon/icons8-medal-first-place-30.png"></c:if>
                          <c:if test="${t.rank==2}"><img src="${path}/assets/img/icon/icons8-medal-second-place-30.png"></c:if>
                          <c:if test="${t.rank==3}"><img src="${path}/assets/img/icon/icons8-medal-third-place-30.png"></c:if></td>
                          <td>${t.userid}</td>
                          <td><fmt:formatNumber value="${t.totalprice}" pattern="#,###"/>원</td>
                          <td><a href="../tutee/classlist.shop?userid=${t.userid}&state=1"><label class="badge badge-info">수강목록보기</label></a></td>
                        </tr>
                       </c:forEach>
                      </tbody>
                    </table>
                    <hr>
                    <div style="width: 100%">
	                    <label class="badge badge-warning">튜티 랭킹</label>
                    </div>
                     <table class="table table-hover">
                      <tbody>
                        <c:forEach items="${tutee}" var="t">
                        <tr>
                          <td><c:if test="${t.rank==1}"><img src="${path}/assets/img/icon/icons8-medal-first-place-30.png"></c:if>
                          <c:if test="${t.rank==2}"><img src="${path}/assets/img/icon/icons8-medal-second-place-30.png"></c:if>
                          <c:if test="${t.rank==3}"><img src="${path}/assets/img/icon/icons8-medal-third-place-30.png"></c:if></td>
                          <td>${t.userid}</td>
                          <td><fmt:formatNumber value="${t.totalprice}" pattern="#,###"/>원</td>
                          <td><a href="../tutee/classlist.shop?userid=${t.userid}&state=1"><label class="badge badge-warning">수강목록보기</label></a></td>
                        </tr>
                       </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
         </div>

</section>
</body>
</html>