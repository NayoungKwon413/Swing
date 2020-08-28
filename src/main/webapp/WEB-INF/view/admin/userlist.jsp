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
    outline: none;
}
.checkwork input[type="submit"]{
    border: none;
    /* background-color: aquamarine; */
    /* position: absolute; */
    top: 0;
    right: -2px;
    bottom: 0;
    border: 0;
    background: none;
    font-size: 16px;
    padding: 5px 20px;
    background: #c2baba;
    color: #fff;
    transition: 0.3s;
    border-radius: 4px 4px 4px 4px;
    outline: none;
}
.checkwork input[type="submit"]:hover{
	opacity: 0.8;
}

span{
margin: 0px 10px;
color: #706c6c;
font-size: 14px;
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
    
	function allchkbox(allchk){
      	$(".idchks").prop("checked",allchk.checked)
    }

	function reasonPop(id){
			window.open('reason.shop?id='+id+"&type=remove",'','width=500,height=400,menubar=no,status=no,toolbar=no');
	}
</script>
<section id="team" class="team">
      <div class="container">
          <div style="text-align: right;">
          <a href="#info1"><h2>회원 목록</h2></a>
          <span>전체 회원 ${usercount}명</span>
          <span>튜터 ${tutorcnt}명</span>
          <span>튜티 ${tuteecnt}명</span>
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
           <div class="checkwork" style="width: calc(60% - 15px); text-align: right;">
	           <input type="submit" value="선택탈퇴">
	           <input type="submit" value="선택메일">
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
                          <th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${list}" var="user">
                        <tr>
                          <td><c:if test="${user.file!=null && !user.file.equals('')}">
                          <img style="width:64px; height: 64px; border-radius: 30px 30px 30px 30px;"src="http://${server}:${port}${path}/user/save/${user.userid}_${user.file}">
                          </c:if></td>
                          <td>${user.userid}</td>
                          <td>${user.name}</td>
                          <c:if test="${user.kbn=='1'}">
                          <td><label class="badge badge-warning">튜티</label><br><a href="../tutee/classlist.shop?userid=${user.userid}&state=1" class="text-danger">수강목록보기</a></td>
                          <td></td>
                          </c:if>
                          <c:if test="${user.kbn=='2'}">
                          <td></td>
                          <td><label class="badge badge-info">튜터</label><br><a href="mytutor.shop?id=${user.userid}" class="text-info">수강목록보기</a></td>
                          </c:if>
                          <td>${user.email}</td>
                          <td><button type="button" onclick="location.href='../user/update.shop?id=${user.userid}'">수정</button></td>
                          <td><button type="button" onclick="reasonPop('${user.userid}')">탈퇴</button></td>
                          <td><input type="checkbox" name="idchks" class="idchks" value="${user.userid}"></td>
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