<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
         <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/font-awesome470.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>

<script>
var module=angular.module("labapp",[]);

module.controller("labcon",function($scope,$http){
	
	
	
	$scope.register=function(labuser,labpass){
	     
		var x =[labuser,labpass];
		
		     $http({
				method:"POST",
				url:"${pageContext.request.contextPath}/lab/register",
				data: angular.toJson(x),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
					var d=response.data;
				alert(d[0]);
				
                 })
               
	}
	
	
	
	
	
})



</script>


</head>
<body ng-controller="labcon" ng-app="labapp" >
<div align="center" style="margin-top:100px;">
<b style="color:red;">${sms}</b>
<div style="border:2px solid green;width:300px;">
<table  border="2" style="margin-bottom:30px;">

<form action="${pageContext.request.contextPath}/lab/login" method="post">
<tr ><input type="text" style="margin-top:20px;" name="user"  placeholder="username" /></tr>
<br/><br/>
<tr><input type="password" name="password" placeholder="password" /></tr>
<br/><br/>
<tr><button class="btn btn-md btn-info" type="submit" >login</button></tr>
</form>

</table>
</div>

</div>


<div align="center" style="margin-top:50px;">
<p><b>not registered yet?</b></p><button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal">register</button>
</div>

        <div id="myModal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:300px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body">
      <table border="2">
      <tr><td><input ng-model="labuser" placeholder="username"/></td></tr><br/>
      <tr><td><input ng-model="labpass" placeholder="password" /></td></tr><br/>
      </table>
     </div>
     <div class="modal-footer" style="background-color:gray;">
     <button  class="btn btn-default" ng-click="register(labuser,labpass)">submit</button>
     </div>
     </div>
     </div>
     </div>

</body>
</html>