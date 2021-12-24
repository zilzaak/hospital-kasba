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
<link href="<c:url value="/static/theme/font-awesome470.css" /> " rel="stylesheet">
  <script src="<c:url value="/static/theme/jquery340.js" />" > </script>
<script src="<c:url value="/static/theme/popper114.js" />"></script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script>


var module=angular.module("rapp",[]);

module.controller("rcon",function($scope,$http){

  $scope.st={
		"name":"","email":"","password":"","age":"","gender":""
		
	     }
  
  $scope.clear=function(){
	 $scope.st.name="" ; 
	 $scope.st.email="";
	 $scope.st.password="";
	 $scope.st.age="" ; 
	 $scope.st.gender=""; 
  }
  
  
	$scope.reg=function(){
		var num = $scope.st.age;
			var err="no";
		if(isNaN(num)){
			err="yes";
		}
	if($scope.st.name=="" || $scope.st.age==""){
		err="yes";
	}
		
		if(err=="no"){
			$http({
				method:"POST",
				url:"${pageContext.request.contextPath}/regstudent",
				data: angular.toJson($scope.st),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
		            $scope.d=response.data;
		            alert($scope.d.name);
		            $scope.clear();
		                    
				        })
				        
				        }
		else{
			alert("error fill up form");
		}
		
	                }
	
})


</script>
</head>
<body id="slog" style="background-color:skyblue;" ng-controller="rcon" ng-app="rapp">
<br/>
<h1 style="margin-left:530px;">Patient Login</h1>
<br/>
<bold style="color:red;margin-left:500px;background-color:white;">${loginsms}</bold>

 <div  style="margin-left:350px;margin-right:350px;background-color:darkcyan;border:8px solid;border-radius:10px;">
 <form action="${pageContext.request.contextPath}/loginstudent" method="post" class="form-group;">

<div   style="margin-left:50px;width:200px;margin-right:50px; margin-top:50px">
<input style="margin-left:100px;" type="text" class="form-control" placeholder="name"  name="name"/> </div>

<div   style="margin-left:50px;width:200px;margin-right:50px; margin-top:50px">
<input  style="margin-left:100px;" type="password" class="form-control" placeholder="password" name="password"/> </div>
<br/>
   <div style="margin-bottom:50px;">
<button class="btn btn-primary btn-md" style="margin-left:200px" type="submit" style="margin-top:50px;" >submit</button>
  </div>
</form>

  </div>
   <br/>
   
<div align="center">
<P style="color:black"><big>not registered yet?</big></h1>
 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal">register now</button>
 </div>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="border-radius:10px;width:300px;">
   <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body">
         
 <div  style="border:2px solid;">
  <div  style="height:45px;margin-top:20px;margin-left:20px;" >
<input  placeholder="name" class="form-control"   ng-model="st.name"  style="width:200px;"> </div>
  <div  style="height:45px;margin-top:20px;margin-left:20px;" >
<input  placeholder="age" class="form-control"   ng-model="st.age"  style="width:200px;"> </div>
 
  <div  style="height:45px;margin-top:20px;margin-left:20px;" >
  
<select  placeholder="gender" class="form-control"   ng-model="st.gender"  style="width:200px;"> 
<option value="male">male</option>
<option value="female">female</option>
<option value="third gender">third gender</option>
</select>

</div>

<div   style="height:45px;margin-top:20px;margin-left:20px;">
<input  placeholder="email" class="form-control"  ng-model="st.email" style="width:200px;" /> </div>

<div  style="height:45px;margin-top:20px;margin-left:20px;">
<input type="password" placeholder="password" class="form-control"  ng-model="st.password" style="width:200px;"/> </div>

 <br/>
   
 <div  style="height:45px;margin-left:20px;">
 <button  class="btn btn-success btn-sm" ng-click="reg();">submit</button>

</div>
</div>
   </div>
    <div class="modal-footer" style="background-color:gray;">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   </div>
 </div>
</div>
</div>
</body>
</html>