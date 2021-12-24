<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
         <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet"> 
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
   <script src="<c:url value="/static/theme/popper114.js" />" > </script>

 <link href="<c:url value="/static/theme/test.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/tabstyle.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/test.js" />" > </script>
<script src="<c:url value="/static/theme/imgslider.js" />" > </script>
<link href="<c:url value="/static/theme/stylefont.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/cyclepl.js" />" > </script>
<script src="<c:url value="/static/theme/tabjs.js" />" > </script>

</head>
 <body>
 
<script type="text/javascript">

			

</script>

<div class="container" style="background-color:LightCyan;">
<nav class="navbar">
	<div class="container-fluid" >
<div class="navbar-header" colo>
<a href="#"><i class="fa  fa-twitter fa-3x"></i> HOSPITAL twitter</a>
</div>
	<li class="active" ><a href="https://www.facebook.com/"><i class="fa  fa-facebook-official fa-3x"></i>Follow US facebook</a></li>
  <li class="active" ><a href="${pageContext.request.contextPath}/choice?operation=contacts"><i class="fa  fa-phone fa-3x"></i>Contact</a></li>
  <li class="active" ><a href=""><i class="fa fa-envelope-o fa-3x"></i>WebMail</a></li>

</div>
</nav>
</div>
<div id="heading" align="center">
<div align="center" style="background-color:maroon;">

<h1><p style="color:white;"> <img class="plogo" src="<c:url value="static/theme/logohos4.jpg" />"/></p></h1>
<h1> <p style="color:white;">HOSPITAL MANAGEMENT SYSTEM</p></h1>
</div>

<div  id="tab" class="row">
<div class="col"><button   class="tablinks"  onClick="openCity(event, 'find')"><span class="btn btn-info ">FIND A DOCTOR</span></button></div>
<div class="col">  <button  class="tablinks" onClick="openCity(event, 'contact')"><span class="btn btn-info ">DOCTOR PORTAL</span></button></div>
<div class="col">  <button  class="tablinks"  onClick="openCity(event, 'about')"><span class="btn btn-info ">ADMIN</span></button></div>
<div class="col"> <button   class="tablinks"  onClick="openCity(event, 'technician')"><span class="btn btn-info ">LAB SECTION</span></button></div>
<div class="col">  <button  class="tablinks" onClick="openCity(event, 'job')"><span class="btn btn-info ">MEDICINE</span></button></div>
</div>
<!-- Tab content -->

<div id="find" class="tabcontent" align="center" >

   <a href="${pageContext.request.contextPath}/choice?operation=studentlogin" class="btn btn-primary btn-lg">Patient section</a>

</div>


<div id="contact" class="tabcontent" align="center">

   <a href="${pageContext.request.contextPath}/choice?operation=doctorlogin" class="btn btn-primary btn-lg">Doctor panel</a>

</div>


<div id="about" class="tabcontent" align="center" >
  
  <ul class="form-group">
  <form action="${pageContext.request.contextPath}/admin/login" modelAttribute="ad" method="post">
 <li class="form-control">
 <input type="text" name="username" value="admin" placeholder="username" />
 </li> 
 <li class="form-control">
 <input type="password" name="password" value="admin" placeholder="password" />
 </li> 
<input type="submit"/>
</form>
  </ul>

 </div>
 

<div id="technician" class="tabcontent" align="center" >

   <a href="${pageContext.request.contextPath}/choice?operation=labsection" class="btn btn-primary btn-lg">Lab section</a>

</div>

<div id="job" class="tabcontent" align="center" >

  <a href="${pageContext.request.contextPath}/pharmacy/pharma" class="btn btn-primary btn-lg">pharmacy</a>

</div>





<div class="continer">
	<div id="slider_image1"  align="center">
	<img class="img5" src="<c:url value="/static/theme/hos1.jpg" />"/>
	<img class="img5" src="<c:url value="/static/theme/hos2.jpg" />"/>
	<img class="img5" src="<c:url value="/static/theme/hos3.jpg" />"/>
	<img class="img5" src="<c:url value="/static/theme/hos4.jpg" />"/>
	
</div>
</div>



<div class="container" style="background-color:LightCyan;">
<nav class="navbar navbar-expand-sm navbar-light bg-faded">
<div class="collapse navbar-collapse" id="nav-content">   
<ul class="navbar-nav">
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-toggle="dropdown" id="Preview" href="#" role="button" aria-haspopup="true" aria-expanded="false">
<span class="btn btn-success">PHARMACY</span>
</a>
<div class="dropdown-menu" aria-labelledby="Preview" style="background-color:burlywood;" >
<a class="dropdown-item" href="#">Order medicine</a>
<a class="dropdown-item" href="#">call a pharmacist</a>
<a class="dropdown-item" href="#"> pharmacy portal</a>
</div>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-toggle="dropdown" id="Preview" href="#" role="button" aria-haspopup="true" aria-expanded="false">
<span class="btn btn-success">REGISTRATION</span>
</a>
<div class="dropdown-menu" aria-labelledby="Preview" style="background-color:burlywood;">
<a class="dropdown-item"  href="${pageContext.request.contextPath}/choice?operation=studentreg">patient registration</a>
<a class="dropdown-item" href="${pageContext.request.contextPath}/choice?operation=doctorreg">doctor registration</a>
</div>
</li>

<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-toggle="dropdown" id="Preview" href="#" role="button" aria-haspopup="true" aria-expanded="false">
<span class="btn btn-success">SEARCH</span>
</a>
<div class="dropdown-menu" aria-labelledby="Preview" style="background-color:burlywood;">
<a class="dropdown-item"  href="${pageContext.request.contextPath}/choice?operation=blood">search blood</a>
<a class="dropdown-item"  href="${pageContext.request.contextPath}/choice?operation=blood">donate blood</a>
<a class="dropdown-item"  href="${pageContext.request.contextPath}/choice?operation=blood">shell blood</a>
<a class="dropdown-item" href="${pageContext.request.contextPath}/choice?operation=doctorlogin">search a Patient</a>
<a class="dropdown-item" href="${pageContext.request.contextPath}/choice?operation=studentlogin">Search a Doctor</a>
</div>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-toggle="dropdown" id="Preview" href="#" role="button" aria-haspopup="true" aria-expanded="false">
<span class="btn btn-success">RECORD</span>
</a>
<div class="dropdown-menu" aria-labelledby="Preview" style="background-color:burlywood;">
<a class="dropdown-item" href="#">record of a patient</a>
<a class="dropdown-item" href="#">record of appointment date</a>
<a class="dropdown-item" href="#">record of conversation</a>
</div>
</li>

<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-toggle="dropdown" id="Preview" href="#" role="button" aria-haspopup="true" aria-expanded="false">
<span class="btn btn-success">LATEST NEWS</span>
</a>
<div class="dropdown-menu" aria-labelledby="Preview" style="background-color:burlywood;">
<a class="dropdown-item" href="#">latest news</a>
<a class="dropdown-item" href="#">upcoming service</a>
<a class="dropdown-item" href="#">about new invention</a>
<a class="dropdown-item" href="#">latest  medical technology</a>
</div>
</li>
</ul>
</div>
</nav>
</div>
<div align="center">


<div class="wrapper" align="center" style="margin-top:150px;">
	<div id="slider_image">
	<img class="img4"  src="<c:url value="/static/theme/hd1.jpg" />"/>
	<img class="img3"   src="<c:url value="/tatic/theme/ncamp5.jpg" />"/>
	<img  class="img2"   src="<c:url value="/static/theme/ncamp6.jpg" />"/>
	<img class="img1" src="<c:url value="/static/theme/hd5.jpg" />"/>
	
	</div>
</div>
</div>

</body>
</html>