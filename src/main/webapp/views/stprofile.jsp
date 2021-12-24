<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/font-awesome470.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>

<script type="text/javascript">

var pts = <%= session.getAttribute("pt")%>
var module=angular.module("papp",[]);

module.controller("pcon",function($scope,$http){
	$scope.patients=pts;
	
	$scope.alld=function(){
	
		    $http({
				method:"GET",
				url:"${pageContext.request.contextPath}/appoint/doctorlist",
				//data: angular.toJson($scope.udr),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				 	$scope.drs=response.data;
					document.getElementById("modalid").click();
					
				        
				})
				     
		
		}
	
	
$scope.updatep=function(){
		
$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/updatepatient",
	data: angular.toJson($scope.patients),
	headers: {"Content-Type":"application/json"}}).
	then(function(response){
	 	
		$scope.patients=response.data;
	alert("updated successfully");
		
	        })	
	     	

	
}	
	
		
	
})

</script>
<style>

.menu{

background-color:darkcyan;
display:flex;
text-align:center;

}

.menu a{

 text-decoration:none;
padding:18px;
 color:white;
 
}


.menu a:hover{
background-color:antiquewhite;
color:maroon;
}

#bod{
 margin:10px;
 border:2px solid black;
}


.ro{
background-color:cadetblue;
display:flex;
justify-content:flex;
}
.ro a{
 text-decoration:none;
padding-left:35%;
float:right;
 color:white;
}


.ro a:hover{
 color:black;
  text-shadow: 2px 2px black;
}

</style>
</head>
<body>
<%
if(session.getAttribute("username")==null && session.getAttribute("password")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
	}

	  %>

	                        
<div id="bod" ng-app="papp" ng-controller="pcon" >
<div class="ro">
<a href="#"   data-toggle="modal" data-target="#editmodal">edit account</a>
<a  href="${pageContext.request.contextPath}/logout?log=patient&id=${sid}"><h3 style="color:black">LOG OUT</h3></a>
</div>

<!-- profile info -->

<table class="table"  style="margin-left:37%;border-radius:50%;
margin-top:5px;background-color:skyblue;text-align:center;width:24%;font-size:0.80em;">
<tr><td>name:{{patients.name}}</td></tr>
<tr><td>age:{{patients.age}}</td></tr>
<tr><td>gender:{{patients.gender}}</td></tr>
<tr><td>{{patients.email}}</td></tr>
</table>


<div class="menu">
<a href="#"  ng-click="alld();">all doctor</a>
<a href="${pageContext.request.contextPath}/chat/patientchat/${sid}">get prescription</a>
<a href="#" >blood bank</a>
<a href="${pageContext.request.contextPath}/appoint/myapp">manage appointment</a>
</div>



<!-- doctor list modal pop up -->
<button  style="display:none;"id="modalid" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal"></button>
<div id="myModal" class="modal fade" role="dialog" >
 <div class="modal-dialog" >
<div class="modal-content" style="width:450px;">
      <div class="modal-header" style="background-color:gray;">
      <button type="button" class="close" data-dismiss="modal">&times;</button>
      <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">

<div ng-repeat="x in drs" style="border:2px solid green;">
<ul style="list-style-type:none;margin-left:20px;margin-right:20px;margin-top:10px;border:2px solid;margin-bottom:10px;">
<img style="height:100px;width:100px;" ng-src="/static/images/{{x.filename}}">
<li  align="center">Name:{{x.name}} <span style="margin-left:15px;">Age:{{x.age}}</span></li>
<li  align="center">Degree:{{x.degree}} <span style="margin-left:15px;">Contact:{{x.drphone}}</span></li>
<li  align="center">Schedule:{{x.schedule}}</li>
<li  align="center">Expert in:{{x.expertint}}</li>
<li>Days:{{x.day}}</li>
</ul>
</div>
   

</div>
  <div class="modal-footer">
  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
 </div>
 </div>

</div>
</div>

















<div id="editmodal" class="modal fade" role="dialog" >
  <div class="modal-dialog" >

  <div class="modal-content" style="width:450px;">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
 <div class="modal-body">
<table>
<tr><td><input type="text" ng-model="patients.name"/></td></tr>
<tr><td><input type="text" ng-model="patients.age"/></td></tr>
<tr><td><select ng-model="patients.gender">
<option value="male">male</option><option value="female">female</option>
</select></td></tr>
<tr><td><input type="text" ng-model="patients.email"/></td></tr>
</table>
<button ng-click="updatep();" class="btn btn-primary">update</button>
</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
</div>
</div>

</div>


</body>
</html>