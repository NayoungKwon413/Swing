<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 장소 및 시간 지정</title>
<link href="${path}/assets/css/apply.css" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<style type="text/css">
.table .table-hover input[type="text"],input[type="date"] {
   width: 150px;
}
.table .table-hover input[type="time"]{
   width: 120px;
}
.table th{
   background-color: #e3e1e1;
   text-align: center;
   vertical-align:middle;
   width:100px;
}
.table td{
   border-bottom: 1px solid #e3e1e1;
}
.table .section{
   border-bottom: 2px solid #999999;
}
.table{
border-top : 2px solid #999999;
font-size: 14px;
}
</style>
<script type="text/javascript">
function input(f,n){
  if (f.checked) {
     for(i=2; i<=n; i++){
        $('#place'+i).val($('#place1').val());
        $('#starttime'+i).val($('#starttime1').val());
        $('#endtime'+i).val($('#endtime1').val());
     }
  } 
  else{
     for(i=2; i<=n; i++){
        $('#place'+i).val($('').val());
        $('#starttime'+i).val($('').val());
        $('#endtime'+i).val($('').val());
     }
   }
}
function timechange(i){
  	date = new Date('2020-01-01 ' +$('#starttime'+i).val());
  	date.setHours(date.getHours()+ ${c.time});
   	$('#endtime'+i).val(date.getHours()+":"+date.getMinutes());
}
function goPopup(i){
	var pop = window.open("../popup/jusoPopup.shop?num="+i,"pop","width=570, height=420, scrollbars=yes, resizable=yes");
}
function jusoCallBack(num,roadFullAddr){
	$('#place'+num).val(roadFullAddr)
	self.close();
}
</script>
</head>
<body>
<section>
   <div class="container">
   <form:form method="post" modelAttribute="classinfoList" action="registerClassinfo.shop?classid=${c.classid}" enctype="multipart/form-data" id="classRegisterForm" name="classRegisterForm">
      <div class="tutor_cont">
         <div class="title_box">
            <h1>수업 등록
               <c:if test="${c.type==1}">(원데이)</c:if>
               <c:if test="${c.type==2}">(다회차)</c:if></h1>
         </div>
         <div class="class_title">
            ${c.subject}
         </div>
         <div class="apply">
            <div class="profile_box">
               <div class="profile" style="background-image:url('${path}/assets/img/${tutorimg}')"></div>
               <p class="triangle-border top gray" style="margin-top:50px">
                  곧 수업이 등록됩니다!<br>
                  <span>장소,날짜,시간</span>을 선책해주세요.
               </p>
            </div>
            <div class="sh_box class_price">
               <div class="head">
                  수업의 장소와 날짜 및 시간을 설정해주세요.
               </div>
               <div class="regions" id="regions">
                  <div class="region" id="region">
                     <div class="option">
                        <div class="top">
                           <div class="text">
                              수업 : ${newclassno} 차수
                              <form:hidden path="classinfos[0].classid" value="${c.classid}" />
                           </div>
                            <div style="text-align:right">
                              <c:if test="${c.type==2}">
                              <input type="checkbox" name="checkbox" id="checkbox" onchange="input(this,${c.totaltime})"> 장소,시작시간,끝나는시간이 모두 같습니다.
                              </c:if>
                           </div>
                        </div>
                     </div>
                     <c:if test="${c.type==1}">
                     <form:hidden path="classinfos[0].classid" value="${c.classid}" />
                     <form:hidden path="classinfos[0].classno" value="${newclassno}" />
                     <form:hidden path="classinfos[0].classseq" value="${1}" />
                     <div class="option">
                        <div class="top">
                           <div class="text">
                 <div id="callBackDiv">           
                              장소: <form:input path="classinfos[0].place" id="place0" value="" style="width:500px;" placeholder="클릭 후 주소 검색" readonly="true" onclick="goPopup(0)"/>          
                 </div>
                           </div>
                        </div>
                     </div>
                     <div class="option">
                        <div class="top">
                           <div class="text">
                              날짜:   <form:input type="date" path="classinfos[0].date" id="date0" />
                           </div>
                        </div>
                     </div>
                     <div class="option">
                        <div class="top">
                           <div class="text">
                              시간: <form:input type="time" path="classinfos[0].starttime" id="starttime0" onchange="timechange(0)"/>
                              ~ <form:input type="time" path="classinfos[0].endtime" id="endtime0" readonly="true"/>                              
                           </div>
                        </div>
                     </div>
                     </c:if>
                     <c:if test="${c.type==2}">
                     <div class="option">
                            <table class="table table-hover">
                           <c:forEach var="i" begin="1" end="${c.totaltime}">
                              <form:hidden path="classinfos[${i}].classid" value="${c.classid}" />
                              <form:hidden path="classinfos[${i}].classno" value="${newclassno}" />
                              <form:hidden path="classinfos[${i}].classseq" value="${i}" />
                              <tr><th rowspan="2" class="section">${i}회차</th>          
                                  <td style="border-bottom:0px;" colspan="2"><div id="callBackDiv">           
                              		장소: <form:input path="classinfos[${i}].place" id="place${i}" value="" style="width:500px;" placeholder="클릭 후 주소 검색" readonly="true" onclick="goPopup(${i})"/>   
                					</div></td></tr>
                			  <tr><td class="section">날짜 : <form:input type="date" path="classinfos[${i}].date" id="date${i}"/></td>
                              	  <td class="section">시간 : <form:input type="time" path="classinfos[${i}].starttime" id="starttime${i}" onchange="timechange(${i})" />
                              	  ~<form:input type="time" path="classinfos[${i}].endtime" id="endtime${i}" readonly="true" /></td>
                              </tr>
                		  </c:forEach>
                        </table>
                     </div>
                     </c:if>
                  </div>
               </div>
            </div>
         </div>
         <div id="registerButton" class="next button" onclick="javascript:document.classRegisterForm.submit()">등록</div>
      </div>
   </form:form>
   </div>
</section>
</body>
</html>