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
var rp = <%= session.getAttribute("lr")%>
var module=angular.module("laba",[]);

module.controller("labc",function($scope,$http){
	$scope.lbr=rp;
	 
$scope.add=function(){
	var x={"testname":"", "testmaker":$scope.lbr.labuser,"patientname":"","age":"","gender":"","result":"",
			"date":"", "stringdate":$scope.lbr.mt[0].date,"contact":""
	                }
	$scope.lbr.mt.push(x);
}

$scope.remove=function(){
	
	var length= $scope.lbr.mt.length;
	if(length>2){
		$scope.lbr.mt.splice(length-1,1);
	}
	else{
		alert("can not remove more row");
	}
	
}

$scope.clear=function(){
	angular.forEach($scope.lbr.mt,function(v,i){
		
		$scope.lbr.mt[i].testname=""; $scope.lbr.mt[i].patientname=""; $scope.lbr.mt[i].age="";
		$scope.lbr.mt[i].gender="";$scope.lbr.mt[i].result="";$scope.lbr.mt[i].stringdate="";
		$scope.lbr.mt[i].contact="";
	})	
}

$scope.insert=function(){
		var er="no";
	
angular.forEach($scope.lbr.mt,function(v,i){
	
if(v.testname=="" || v.patientname=="" || v.age=="" || v.result=="" || v.gender=="" ){
	er="yes";
}
	
})

if(er!="yes"){

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/insert",
		data:angular.toJson($scope.lbr),
		headers: {"Content-Type":"application/json"} }).
		then(function(response){
		
		alert("successfully inserted record");
		$scope.clear();
		   })
	
	}
if(er=="yes"){
	alert("there exist blank field");
	
}

}

$scope.allrecord=function(){
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/allrecord",
		data:rp.labuser,
		headers: {"Content-Type":"text/plain"} }).
		then(function(response){
$scope.records=response.data;
if($scope.records.length<1){
	alert("no record found");
}
else{
	document.getElementById("allrecord").click();
}
		   })
  
	
}


$scope.sbyname=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/sbyname",
		data:$scope.name,
		headers: {"Content-Type":"text/plain"} }).
		then(function(response){
$scope.recbyname=response.data;
		         })
	
}

$scope.agehover=function(x){
if(x=='between'){
	document.getElementById("between").style.background="skyblue";
	document.getElementById("after").style.background="ghostwhite";
	document.getElementById("less").style.background="ghostwhite";
}

if(x=='less'){
	document.getElementById("less").style.background="skyblue";
	document.getElementById("after").style.background="ghostwhite";
	document.getElementById("between").style.background="ghostwhite";
}

if(x=='after'){
	document.getElementById("after").style.background="skyblue";
	document.getElementById("between").style.background="ghostwhite";
	document.getElementById("less").style.background="ghostwhite";
}

}



$scope.agebetween=function(){
	$scope.agehover('between');
	
	var x=[$scope.age1,$scope.age2];
	
	
	if($scope.age1==null || $scope.age2==null){
		alert("blank field");
	}
	else{
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/lab/agebetween",
			data:angular.toJson(x),
			headers: {"Content-Type":"application/json"} }).
			then(function(response){
				$scope.age1==""; $scope.age2=="";
	$scope.recbyage=response.data;
			         })	
		
	}

		         
		         
	
                     }

$scope.agelargerthan=function(){

	$scope.agehover('after');
	
	if($scope.agelarger==null){
		alert("blank field");
	}
	else{
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/lab/agelargerthan",
			data:angular.toJson($scope.agelarger),
			headers: {"Content-Type":"application/json"} }).
			then(function(response){
				
				$scope.agelarger="";
				$scope.recbyage=response.data;
			         })
	}

		         
	                    }
	                           

$scope.agelessthan=function(){

	$scope.agehover('less');
	if($scope.ageless==null){

	alert("blank field");
	}
	
	else{
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/lab/agelessthan",
			data:angular.toJson($scope.ageless),
			headers: {"Content-Type":"application/json"} }).
			then(function(response){
				$scope.ageless="";
				$scope.recbyage=response.data;
			         })
		
	}

		         
		         
                      }


$scope.sbydateafter=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/sbydateafter",
		data:angular.toJson($scope.afterdate),
		headers: {"Content-Type":"application/json"} }).
		then(function(response){
$scope.recbydate=response.data;
		   })
		
             }



$scope.sbydatebefore=function(){

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/sbydatebefore",
		data:angular.toJson($scope.beforedate),
		headers: {"Content-Type":"application/json"} }).
		then(function(response){
			$scope.recbydate=response.data;
		   })
                          }

$scope.sbydatebetween=function(){
	

	
	var twodate=[$scope.date1,$scope.date2];
$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/lab/sbydatebetween",
		data:angular.toJson(twodate),
		headers: {"Content-Type":"application/json"} }).
		then(function(response){
			$scope.recbydate=response.data;
			if($scope.recbydate.length<1){
				alert("no record found")
			}
		
		   })
	      }

	
})


function appdiv(x,y,z,a){
	
document.getElementById(x).style.display="block";
document.getElementById(y).style.display="none";
document.getElementById(z).style.display="none";	
document.getElementById(a).style.display="none";
	}
	
</script>
<style>
table th{
color:white;
font-size:0.70em;
background-color: black;
}

table td{
font-size:0.70em;
color:black;
background-color:white;
}

button{
width:110px;
}
</style>
</head>
<body ng-controller="labc" ng-app="laba">
    <%
if(session.getAttribute("labuser")==null && session.getAttribute("labpassword")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
}
%>
<div align="center" style="margin-top:30px;">

<div class="row" style="margin-left:30px;margin-right:30px;">

<div class="col-md-2" style="height:400px;background-color:skyblue;border:2px solid black;">
<button ng-click="allrecord();" class="btn btn-md btn-info" style="margin-top:20px;">all record</button><br/>
<button onclick="appdiv('add','name','age','date');" class="btn btn-md btn-info" style="margin-top:20px;">add record</button>
<br/>
<div class="dropdown">
  <button class="btn btn-md dropdown-toggle" style="margin-top:7px;margin-left:10px;" data-toggle="dropdown">
   search<span class="caret"></span>
  </button>
  <ul class="dropdown-menu" style="list-style-type:none;">
    <li><a href="#" onclick="appdiv('name','age','date','add');">by name</a></li>
    <li><a href="#" onclick="appdiv('age','name','date','add');">by age</a></li>
    <li><a href="#" onclick="appdiv('date','name','age','add');">by date</a></li>
    </ul>
</div>
</div>

<div class="col-md-10" style="background-color:darkcyan;border:2px solid black;">
<div  class="row" style="display:none;background-color:azure;" id="age">
<div class="row" style="font-size:0.70em;">
<div class="col" style="margin-top:15px;" id="between">
<b>from age </b> <input  style="width:60px;" type="number" ng-model="age1"/><b>to age </b><input style="width:60px;" type="number" ng-model="age2"/>
<br/><span><button  ng-click="agebetween();">search</button></span>
</div>
<div class="col" style="margin-top:15px;" id="after">
<b>age after</b><input style="width:60px;" type="number" ng-model="agelarger"/>
<span><button  ng-click="agelargerthan();">search</button></span>
</div>
<div class="col" style="margin-top:15px;" id="less">
<b>age less than</b><input style="width:60px;" type="number" ng-model="ageless"/>
<span><button  ng-click="agelessthan();">search</button></span>
</div>
</div>
<div  align="center">
<table border="2" style="margin-bottom:15px;">
<tr ng-repeat="x in recbyage">
<th ng-if="$index==0">no</th>
<th  ng-if="$index==0">patient name</th>
<th  ng-if="$index==0">gender</th>
<th  ng-if="$index==0">age</th>
<th  ng-if="$index==0">test</th>
<th  ng-if="$index==0">result</th>
<th  ng-if="$index==0">date</th>
<th  ng-if="$index==0">contact</th>
</tr>
  <tr ng-repeat="x in recbyage">
  <td>{{$index}}</td>
  <td>{{x.patientname}}</td>
  <td>{{x.gender}}<</td>
  <td>{{x.age}}</td>
  <td>{{x.testname}}</td>
  <td>{{x.result}}</td>
  <td>{{x.stringdate}}</td>
    <td>{{x.contact}}</td>
  </tr>
 </table>
 <br/>
</div>
</div>

<div  class="row" style="height:400px;display:none;background-color:ghostwhite;" id="date">
<div>
<br/>
<ul style="list-style-type:none;font-size:0.70em">
<li><b>before </b> <input type="date" ng-model="beforedate"/><button ng-click="sbydatebefore();" style="margin-left:50px;" >search</button></li>
<li><b>after </b> <input type="date" ng-model="afterdate"/> <button ng-click="sbydateafter();" style="margin-left:50px;" >search</button></li>
<li><b>between </b> <input type="date" ng-model="date1"/>
<b>and</b> <input type="date" ng-model="date2"/><button ng-click="sbydatebetween();">search</button></li>
</ul>

<div align="center">
<table style="margin-top:15px;">
<tr ng-repeat="x in recbydate">
<th ng-if="$index==0">patient name</th>
<th ng-if="$index==0">gender</th>
<th ng-if="$index==0">age</th>
<th ng-if="$index==0">testname</th>
<th ng-if="$index==0">result</th>
<th ng-if="$index==0">date</th>
<th ng-if="$index==0">contact</th>
</tr>
<tr ng-repeat="x in recbydate">
<td>{{x.patientname}}</td>
<td>{{x.gender}}</td>
<td>{{x.age}}</td>
<td>{{x.testname}}</td>
<td>{{x.result}}</td>
<td>{{x.stringdate}}</td>
<td>{{x.contact}}</td>
</tr>
</table>
<br/>
</div>
</div>
</div>
<div  class="row"style="height:400px;display:none;background-color:aliceblue;" id="name">
<br/>
<b>type name</b><input ng-model="name" />
<span style="margin-left:20px;"><button ng-click="sbyname();" class="btn btn-success btn-sm">search</button></span>
<div align="center" style="margin-top:15px;">
<table >
<tr ng-repeat="x in recbyname">
<th ng-if="$index==0">no</th>
<th ng-if="$index==0">name</th>
<th ng-if="$index==0">gender</th>
<th ng-if="$index==0">age</th>
<th ng-if="$index==0">testname</th>
<th ng-if="$index==0">result</th>
<th ng-if="$index==0">date</th>
<th ng-if="$index==0">contact</th>
</tr>
<tr ng-repeat="x in recbyname">
<td>{{$index}}</td>
<td>{{x.patientname}}</td>
<td>{{x.gender}}</td>
<td>{{x.age}}</td>
<td>{{x.testname}}</td>
<td>{{x.result}}</td>
<td>{{x.stringdate}}</td>
<td>{{x.contact}}</td>
</tr>
</table>
<br/>
</div>

</div>

<div class="row" style="height:400px;background-color:steelblue;" id="add">
<div align="center">
<h1>add record</h1><br/>
<table style="background-color:black;margin-left:150px;" border="2">
<tr ng-repeat="x in lbr.mt">
<th  ng-if="$index==1">patient name</th>
<th  ng-if="$index==1">age</th>
<th  ng-if="$index==1">gender</th>
<th  ng-if="$index==1">testname</th>
<th  ng-if="$index==1">result</th>
<th  ng-if="$index==1">contact</th>
</tr>
<tr ng-repeat="x in lbr.mt">
<td><input  ng-model="x.patientname" /></td>
<td><input style="width:60px;" type="number" ng-model="x.age" /></td>
<td><select ng-model="x.gender" >
<option value="male">male</option> <option value="female">female</option>
<option value="third gender">third gender</option>
</select></td>
<td><input ng-model="x.testname" /></td>
<td><input ng-model="x.result" /></td>
<td><input ng-model="x.contact" /></td>
</tr>
</table>
<br/>
<span style="margin-left:90px;"><button class="btn btn-sm btn-default" ng-click="add();">add more</button></span> 

<span  style="margin-left:80px;"><button class="btn btn-sm btn-default" ng-click="remove();">remove item</button>
</span>

<span style="margin-left:70px;"><button class="btn btn-sm btn-default" ng-click="insert();">submit</button ></span>

</div>
</div>
</div>
</div>
</div>


<button style="display:none;" id="allrecord" class="btn btn-info " data-toggle="modal" data-target="#myModal"></button>
 <div id="myModal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body">

 <table style="margin-left:35px;" border="1">
         <tr> 
      <th>no</th>
     <th>name</th>
      <th>gender</th>
    <th>age</th>
    <th>testname</th>
    <th>result</th>
   <th>date</th>
  <th>contact</th>

    </tr>
 <tr ng-repeat="x in records" style="color:white;">
   <td>{{$index+1}}</td>
   <td>{{x.patientname}}</td>
   <td>{{x.gender}}</td>
   <td>{{x.age}}</td>
   <td>{{x.testname}}</td>
   <td>{{x.result}}</td>
   <td>{{x.stringdate}}</td>
      <td>{{x.contact}}</td>
   </tr>
   </table>
     </div>
     <div class="modal-footer" style="background-color:gray;">
    
     </div>
     </div>
     </div>
     </div>
</body>
</html>