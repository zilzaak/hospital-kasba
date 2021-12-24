<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css
" rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
<style>
*{
box-sizing:border-box;
}
#b{
background-image:url("/static/theme/green.jpg");
  background-repeat: no-repeat;
  background-size: 700px 300px;
}

</style>

<script type="text/javascript">
function createit() {
  var HTML_Width = $(".html-content").width()-10;
    var HTML_Height = $(".html-content").height();
    var top_left_margin = 15;
    var PDF_Width = HTML_Width + (top_left_margin * 2);
    var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
    var canvas_image_width = HTML_Width;
    var canvas_image_height = HTML_Height;

    var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

    html2canvas($(".html-content")[0]).then(function (canvas) {
        var imgData = canvas.toDataURL("image/jpeg", 1.0);
        var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
        pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);
        for (var i = 1; i <= totalPDFPages; i++) { 
            pdf.addPage(PDF_Width, PDF_Height);
            pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
        }
        var pi= $("#prid").val();
        var r= pi+$("#presname").val()+".pdf"; 
       pdf.save(r);
        $(".html-content").hide();
    });
}
</script>
</head>
<body>
<button class="btn btn-success" onclick="createit();" style="margin-left:20%;">download</button>
<input type="text" style="display:none;"  id="presname" value="${pres.presnam}"/>
<input type="text"  style="display:none;" id="prid" value="${pres.presid}"/>
<div  class="html-content" style="margin-left:20%;margin-right:20%;margin-top:15px;margin-bottom:15px;background-color:floralwhite;border:2px solid black;">

<div class="row" id="b"
style="background-color:powderblue;border:1px solid black;margin:5%;font-style:italic;margin-bottom:0px;">
<div class="col" style="color:maroon;font-size:1.1em;word-wrap:break-word;">
<ul  style="list-style:none;margin-left:10%;" >
<li style="color:black;"><b>date:- ${pres.date}</b></li>
<li><i class="fas fa-address-card"></i><b>The green hospital,shamoli,Dhaka,road no 12</b></li>
<li><i class="fas fa-phone"></i>
<b>Phone:014752155,013349752,0124623554</b></li>
<li><b>modern computersez hospital with all facilities</b></li>
<li><b>visit https://www.greenhospital.health.net</b></li>
</ul>
</div>
</div>
<div class="row" style="background-color:powderblue;border:1px solid black;margin:5%;font-style:italic;margin-top:0px;">
<div class="col" style="border-right:1px solid black;">
<ul style="list-style:none;">
<li><b>${dr.name}</b></li>
<li><b>${dr.degree}</b></li>
<li><b>${dr.expertint}</b></li>
</ul>
</div>

<div  class="col">
<ul style="list-style:none;">
<li><b>${dr.day}</b></li>
<li><b>${dr.schedule}</b></li>
</ul>
</div>
</div>

<div style="margin-left:5%;margin-right:5%;">
<img style="height:70px;margin-left:15%;"src="<c:url value="/static/theme/rx.png"/>">
<img style="margin-left:45%;height:70px;" src="<c:url value="/static/theme/stetho.jpg"/>">
</div>


<div style="
font-size:.80em;background-color:aliceblue;margin:5%;background-color:aliceblue;">
<table class="table table-borderless table-sm table-responsive" 
>
<tr>
<td><b>name:-${pres.name}</b></td>
<td><b>sex:-${pres.sex}</b></td>
<td><b>age:-${pres.age}</b></td>
</tr>

<tr>
<td><b>test:-${pres.test}</b></td>
</tr>

<tr>
<td><b>advice:-${pres.advice}</b></td>
</tr>
</table>
</div>



<div style="font-size:.80em;background-color:aliceblue;margin:5%;">
<table class="table table-borderless table-sm table-responsive"  >
<c:forEach items="${pres.druglist}" var="drug" varStatus="loop">
<tr>
<c:if test="${loop.index==0}">
<td>name</td>
<td>type</td>
<td>rules</td>
<td>days</td>
<td>condition</td>
<td>instruction</td>
</c:if>
</tr>
</c:forEach>
<c:forEach items="${pres.druglist}" var="drug">
<tr>
<td><b>${drug.drugname}</b></td>
<td><b>${drug.drugtype}</b></td>
<td><b>${drug.rules}</b></td>
<td><b>${drug.days}</b></td>
<td><b>${drug.consult}</b></td>
<td><b>${drug.instruction}</b></td>
</tr>
</c:forEach>

</table>
</div>
</div>

</body>
</html>