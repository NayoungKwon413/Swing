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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
<link rel="stylesheet" href="style.css">
<style type="text/css">
.search{
    background: #fff;
    padding: 0px 10px;
    position: relative;
    border-radius: 4px;
    box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1);
    text-align: left;
    width: 40%;
    margin-bottom: 15px;
}
.search form input[type="text"] {
    border: 0;
    padding: 4px 8px;
    width: calc(100% - 70px);
    outline: none;
}
 .search form input[type="submit"] {
    position: absolute;
    top: 0;
    right: -2px;
    bottom: 0;
    border: 0;
    background: none;
    font-size: 16px;
    padding: 0 20px;
    background: #49b5e7;
    color: #fff;
    transition: 0.3s;
    border-radius: 0 4px 4px 0;
    box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
<script type="text/javascript">
	function listdo(page){
		f = document.sf;
		f.pageNum.value = page;
		f.submit();
	}
</script>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="#info1"><h2>회원 목록</h2></a>
          <a href="#info1" class="select">전체(${usercount})</a>&nbsp;|
          <a href="#info2">튜터(2)</a>&nbsp;|
          <a href="#info3">튜티(1)</a>
          <hr style="margin-top: 15px;">
          </div>
          <div class="row">
             <div class="search">
             <form action="userlist.shop" method="post" name="sf">
					<div class="item-center" >
					<input type="hidden" name="pageNum" value="1">
						<select name= "column" style="border: none; width: 120px; outline: none;">
							<option value="">선택하세요</option>
							<option value="userid">아이디</option>
							<option value="name">이름</option>
							<option value="email">이메일</option>
							<option value="userid,name">아이디+이름</option>
						</select>
						<script>document.sf.column.value="${param.column}";</script>
						<input type="text" name="find" value="${param.find}" style="width:250px;">
						<input type="submit" value="검색">
					</div>
		   </form>
           </div>
           <div style="width: calc(60% - 15px); text-align: right;">
              <a href="#info1" class="select">전체선택</a>&nbsp;|
                <a href="#info2">선택탈퇴</a>&nbsp;|
                <a href="#info3">선택메일전송</a>
           </div>
        </div>
		<c:if test="${usercount==0}">
		등록된 회원이 없습니다
		</c:if>
		<c:if test="${usercount>0}">
          <table class="table table-hover">
                      <thead>
                        <tr>
                          <th></th>
                          <th>아이디</th>
                          <th>이름</th>
                          <th colspan="2">회원유형</th>
                          <th>이메일</th>
                          <th colspan="2">회원관리</th>
                          <th><input class="checkbox" type="checkbox" onchange="allchkbox(this)"></th>
                          <script>
                          function allchkbox(allchk){
                          	$(".idchks").prop("checked",allchk.checked)
                          }
                          </script>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${list}" var="user">
                        <tr>
                          <td><c:if test="${user.file!=null}">
                          <img style="width:64px; height: 64px; border-radius: 30px 30px 30px 30px;"src="../user/save/${user.userid}_${user.file}">
                          </c:if></td>
                          <td>${user.userid}</td>
                          <td>${user.name}</td>
                          <c:if test="${user.kbn=='1'}">
                          <td><label class="badge badge-info">튜티</label><br><a href="../tutee/classlist.shop?userid=${user.userid}&state=1" class="text-info">수강목록보기</a></td>
                          <td></td>
                          </c:if>
                          <c:if test="${user.kbn=='2'}">
                          <td></td>
                          <td><label class="badge badge-warning">튜터</label><br><a href="classlist.shop?get=0&id=${user.userid}" class="text-danger">수강목록보기</a></td>
                          </c:if>
                          <td>${user.email}</td>
                          <td><a href="../user/update.shop?id=${user.userid}">수정</a></td>
                          <td><a href="reasonPop(${user.userid})">탈퇴</a></td>
                          <td><input class="checkbox" type="checkbox"></td>
                          <script>
							function reasonPop(id){
									window.open('reason.shop?id='+id+"&classid=",'','width=500,height=400,menubar=no,status=no,toolbar=no');
							}
						  </script>
                        </tr>
                     </c:forEach>
                      </tbody>
                    </table>
                    <div class="row">
	                     <div class="back-next">
		                     <c:if test="${pageNum<=1}"><img src="../assets/img/icon/back.png"></c:if> 
							 <c:if test="${pageNum>1}"><a href="javascript:listdo(${pageNum-1})"><img src="../assets/img/icon/back.png"></a></c:if> 
							 <c:forEach var="a" begin="${startpage}" end="${endpage}">
							 <c:if test="${pageNum==a}"><a>${a}</a></c:if>
							 <c:if test="${pageNum!=a}"><a href="javascript:listdo(${a})">${a}</a></c:if>
							 </c:forEach> 
							 <c:if test="${pageNum>=maxpage}"><img src="../assets/img/icon/next.png"></c:if> 
							 <c:if test="${pageNum<maxpage}"><a href="javascript:listdo(${pageNum+1})"><img src="../assets/img/icon/next.png"></a></c:if>
						</div>
					</div>
     </c:if>
     </div>
 </section>            
</body>
</html>