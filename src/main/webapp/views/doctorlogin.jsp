<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/font-awesome470.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>
<link href="<c:url value="/static/theme/get.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/get.css" /> " rel="stylesheet">
<script type="text/javascript">
var name,age,phone,degree,expertintt,day,schedule,pass;

var module= angular.module("dapp",[]);

module.controller("dcon",function($scope,$http){
	$scope.days=["sat","sun","mon","tue","wed","thu","fri"];
	$scope.selected=["n","n","n","n","n","n","n"];
	$scope.dr= { "name":"","age":"","degree":"","drphone":"",
			 "expertint":"","password":"","schedule":"",
			 "day":"",
			 	 }
	
	$scope.reset=function(){
	$scope.dr.name="";$scope.dr.age="";$scope.dr.degree="";$scope.dr.drphone="";$scope.dr.expertint="";$scope.dr.day="";
	$scope.dr.schedule="";$scope.dr.password="";
	
		
	}
	
	
	
	$scope.handle=function(i){
	if($scope.selected[i]=="n"){
		$scope.selected[i]=$scope.days[i];	
		
	}	
	else{
		$scope.selected[i]="n";	
		
	}
	
	}

	
	
$scope.keyname=function(){
	
	if($scope.dr.name==""){
	document.getElementById("name").style.background="red";	
	}
	else{
		document.getElementById("name").style.background="ghostwhite";	
	}
	
	}	
	
$scope.keyphone=function(){
	if($scope.dr.drphone=="" ||  isNaN($scope.dr.drphone)){

	document.getElementById("phone").style.background="red";	
	}
	else{
		document.getElementById("phone").style.background="ghostwhite";	
	}
}	


$scope.keyage=function(){
	if($scope.dr.age=="" ||  isNaN($scope.dr.age)){

		document.getElementById("age").style.background="red";	
		}	
	else{
		document.getElementById("age").style.background="ghostwhite";	
	}
	
}	


$scope.keydegree=function(){
	if($scope.dr.degree==""){

		document.getElementById("degree").style.background="red";	
		
		}	
	else{
		document.getElementById("degree").style.background="ghostwhite";	
	}
}	



$scope.keyexpertint=function(){
	if($scope.dr.expertint==""){

		document.getElementById("expertint").style.background="red";	
		
		}	
	else{
		document.getElementById("expertint").style.background="ghostwhite";	
	}
}	



	$scope.keyschedule=function(){
		if($scope.dr.schedule==""){

			document.getElementById("schedule").style.background="red";	
			
			}	
		else{
			document.getElementById("schedule").style.background="ghostwhite";	
		}
}	
	
	
	
	$scope.post=function(){
		
		var x="";
		angular.forEach($scope.selected,function(d,i){
		
			if(d!="n" ){
				if(x==""){
					x=d;
				}
				else{
				x=x+","+d;	
				}
				
			}
			
		})
		
		var err="no";
		$scope.dr.day=x;
		var msg="";
		
	if($scope.dr.name=="" || x=="" || $scope.dr.degree=="" || $scope.dr.age=="" || $scope.dr.drphone=="" || $scope.dr.schedule=="" || $scope.dr.password==""){
			err="yes";
			
		}
		
		if(isNaN($scope.dr.drphone)){
			err="yes";
			
			msg=msg+" "+"wrong phone number";
		}
		
if(isNaN($scope.dr.age)){
	err="yes";
			
			msg=msg+" "+"age shuld be a number";
		}
		
		
		if(err=="no"){
			
			$http({
				method:"POST",
				url:"${pageContext.request.contextPath}/newdocreg",
				data: angular.toJson($scope.dr),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
					$scope.reset();
		            alert(response.data.degree);

		                             
				        })	
		
		}
		else{
			alert("invalid form"+" "+msg);
		
                     
		}
		 

	}
	
})


 </script>

</head>
<body id="dlog" ng-controller="dcon" ng-app="dapp">
<div align="center">
<h1>login</h1>
</div>
<div align="center"><bold>${sms}</bold></div>
<div class="border border-success" style="margin-left:300px;margin-right:300px;bakground-color:green;">
<form class="container" action="${pageContext.request.contextPath}/logindoctor" method="post" >
 <div class="form-group">
    <label for="email">USER NAME:</label><br/>
   <i class="fa fa-user-circle fa-lg" aria-hidden="true"></i>
   <br/>
    <input type="text" class="form-control" id="email" name="name">
  </div>
  <div class="form-group">
    <label for="pwd">PASSWORD:</label><br/>
  <i class="fa fa-key fa-lg" aria-hidden="true">
  <br/>
  </i><input type="password" class="form-control" id="pwd" name="password">
  </div>
 <button type="submit" class="btn btn-default">Submit</button>
</form>
</div>
<br/>
<div align="center" style="background-color:darkseagreen; margin-left:290px;margin-right:290px;
border-radius:5px;">
<p style="color:red"><bold>not register yet?</bold></p>

 <button type="button" class="btn btn-info btn-md" data-toggle="modal" data-target="#myModal">register now</button>
 <br/><br/>
</div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="">

    <!-- Modal content-->
      <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
   
<table style="margin-left:50px;border:2px;">
<tr><td>select date</td></tr>
<tr>
<td  ng-repeat="z in days" >
<input type="checkbox" ng-click="handle($index);">{{z}} </input>
</td>
 </tr> 
</table>
  
 <table style="margin-left:50px;border:2px;">
<tr>
<td>
<input  id="name"  ng-model="dr.name"   placeholder="username"   ng-keyup="keyname();"/>
</td>
</tr>

<tr>
<td>
<input id="age"  ng-model="dr.age"   id="age" placeholder="age" ng-keyup="keyage();"/>
</td>
</tr>
<tr>
<td>
<input  id="degree" ng-model="dr.degree"   placeholder="degree"  ng-keyup="keydegree();"/> 
</td>
</tr>
<tr>
<td>
 <input  id="expertint" ng-model="dr.expertint"   placeholder="expert in" ng-keyup="keyexpertint();"/> 
</td>
</tr>
<tr>
<td>
<input id="pass" type="password" ng-model="dr.password"  placeholder="password" /> 
</td>
</tr>
<tr>
<td>
<input   id="phone"  ng-model="dr.drphone"    placeholder="phone" ng-keyup="keyphone();"/> 
</td>
</tr>
<tr>
<td>
<input   id="schedule"   ng-model="dr.schedule"   placeholder="schedule" ng-keyup="keyschedule();"/> 
</td>
</tr>
<tr>
<td>
<button type="submit" class="btn btn-success btn-sm" ng-click="post();">submit</button>
<button  class="btn btn-default btn-sm" ng-click="reset();">clear</button>
</td>
</tr>
</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

</body>
</html>