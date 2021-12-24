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
<script src="<c:url value="/static/theme/angular-route1.8.2.js" />"> </script>

<script type="text/javascript">

var rp = <%= session.getAttribute("lr")%>
var module=angular.module("adminapp",["ngRoute"]);

module.controller("admincon",function($scope,$http,$timeout){
	
$scope.emp={"name":"","age":"","designation":"","contact":"","gender":"","permanantaddress":"","nid":""}

$scope.cab={"name":"","age":"","phone":"","gender":"","address":"","bedno":"","admit":"","enddate":"","duration":""}

$scope.bed=["1","2","3","4","5"];
	
$scope.addemployee=function(){
	var blank="no";
	var con="no";
	var age="no";
	var agesms=" "; var contactsms=" "; var blanksms=" ";
	
	if($scope.emp.name=="" || $scope.emp.gender==""  || $scope.emp.designation=="" || $scope.emp.permanantaddress==""){
		
		blank="yes";
		agesms="blank field";
	}


	if(isNaN($scope.emp.contact)){
		document.getElementById("contact").style.color="red";
		con="yes"
		contactsms="contact must be number,";
	}
	
	if(isNaN($scope.emp.age)){
		document.getElementById("age").style.color="red";
		age="yes";
		agesms="age must be number,"
	}
	if(blank=="no" && con=="no" && age=="no"){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/admin/addemployee",
			data: angular.toJson($scope.emp),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				$scope.emp.name=""; 
				$scope.emp.contact=""; 
				$scope.emp.gender=""; 
				$scope.emp.designation="";
				$scope.emp.permanantaddress=""; 
				$scope.emp.age="";$scope.emp.nid="";
				alert("successfully added employee");
				
			})	
		}
	
	
if(blank=="yes" || con=="yes" || age=="yes"){
	alert(contactsms+" "+agesms+" "+blanksms);
	
}
	            }

$scope.allinfo=function(v){
	var r=v;
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/admin/getbydesignation",
		data: r,
		headers: {"Content-Type":"text/plain"}}).
		then(function(response){
  $scope.empls=response.data;
  if($scope.empls.length<1){
	  alert("empty record");
  }
  document.getElementById("empl").style.display="block";
  document.getElementById("admit").style.display="none";
  document.getElementById("cabrecord").style.display="none";
$('#result').append( $('#empl') );
	
		})	
}



$scope.sbytwodate=function(){
	
var twodate=[$scope.date1,$scope.date2];

$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/admin/cabinbytwodate",
		data:angular.toJson(twodate),
		headers: {"Content-Type":"application/json"} }).
		then(function(response){
			
			$scope.cabinbydate=response.data;
			if($scope.cabinbydate.length<1){
				alert("no record found,search another option")
			}
			else{
			document.getElementById("cabintab1").style.display="none";	
			document.getElementById("cabintab2").style.display="block";		
			}
		
		   })
		   
		   
	      }













$scope.cabinrecord=function(){
	
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/admin/allcabin",
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
		$scope.allcabin=response.data;
		
		})	
	
	document.getElementById("empl").style.display="none";
	document.getElementById("cabrecord").style.display="block";
	document.getElementById("admit").style.display="none";
			$('#result').append( $('#cabrecord') );	
			
			
}











$scope.addcabin=function(){
	
	var phonesms=" ";var agesms=" ";var bednosms=" "; var blanksms=" ";
	var blank="no"; var err="no";
	if($scope.cab.name=="" || $scope.cab.gender=="" || $scope.cab.address==""){
		var blank="yes";
		blanksms="blank field";
	}
	
	if(isNaN($scope.cab.bedno)){
		err="yes";
		bednosms="bed no must be number, ";
	}
	
	if(isNaN($scope.cab.phone)){
		err="yes"; 
		phonesms="phone must be number, ";
	}
	if(isNaN($scope.cab.age)){
		err="yes";
		agesms="age must be number ";
	}
	
	
	if(blank=="no" && err=="no"){
	
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/admin/addadmit",
			data: angular.toJson($scope.cab),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
			$scope.ca=response.data;
			alert($scope.ca.address);
			})			
		
	     	}
	

	if(blank=="yes" || err=="yes"){
		alert(agesms+" "+phonesms+" "+bednosms+" "+blanksms);
	}
	
}


$scope.emptycabin=function(){
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/admin/emptycabin",
		data: angular.toJson($scope.bed),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
		$scope.cabs=response.data;
		if($scope.cabs.length<1){
			alert("empty list found,all date are empty now");
		}
		else{
			document.getElementById("emptycab").click();
		}
		})	
     }



})

function appadmit(){
		
document.getElementById("empl").style.display="none";
document.getElementById("cabrecord").style.display="none";
document.getElementById("admit").style.display="block";
$('#result').append( $('#admit') );	


	
                  }
                  
  function cabindisplay(){
	  document.getElementById("cabintab1").style.display="block";
	  document.getElementById("cabintab2").style.display="none";
  }                
                  
                  

</script>

<style type="text/css">

#dropdown {

  display: block;
  background-color:darkseagreen;
           }

#dropdown-content {
  display: none;
  background-color: #f9f9f9;
  z-index: 1;
}

#dropdown:hover #dropdown-content {display: block;}
#dropdown:hover #dropbtn {background-color: skyblue;}
#dropdown:hover #dropdown-content a{
color:green; 
background-color:ghostwhite;
}

table th{
word-break:break-all;
font-size:0.85em;
background-color:black;
color:white;
text-align:center;
}

table td{

word-break:break-all;
font-size:0.85em;
}



</style>

</head>
<body style="margin:50px;border:1px solid black;" ng-app="adminapp" ng-controller="admincon">

<h style="margin-left:35%;background-color:aliceblue;"><b>admin panel</b></h>
<div class="row" style="margin-left:3px;border:1px solid black;margin-top:7px;margin-right:10px;margin-bottom:7px;">
<div id="dropdown" class="col-md-1">
<div  style="height:50px;background-color:skyblue;border-right:1px solid black;" class="row">
<br/>
<h id="dropbtn"><b>employees</b></h>
</div>
   
  <hr style="color:2px red;">
  <div id="dropdown-content" style="margin-top:7px;">
    <a href="#" ng-click="allinfo('doctor');">doctors</a><br/>
    <a href="#" ng-click="allinfo('nurse');">nurses</a><br/>
    <a href="#" ng-click="allinfo('guard');">guards</a><br/>
    <a href="#" ng-click="allinfo('labratorist');">labratorists</a><br/>
    <a href="#" ng-click="allinfo('cleaner');">cleaner</a><br/>
    <a href="#" ng-click="allinfo('receptionist');">receptionist</a><br/>
  </div>
</div>
<div id="dropdown" class="col-md-1">

<div text-align="center" style="height:50px;background-color:skyblue;border-right:1px solid black;" class="row" >
<br/>
  <h id="dropbtn"><b>tasks</b></h>
  </div>
<hr>
  <div id="dropdown-content" style="margin-top:7px;">
   <a href="#"   data-toggle="modal" data-target="#myModal">add employee</a><br/>
   </div>
</div>

<div id="dropdown" class="col-md-2">
<div  style="height:50px;background-color:skyblue;" class="row">
<br/>
  <h id="dropbtn"><b>cabin info</b></h>
  </div>
<hr>
  <div id="dropdown-content" style="margin-top:7px;">
    <a href="#" ng-click="cabinrecord();">records</a><br/>
    <a href="#" onclick="appadmit();">admit a patient</a><br/>
   <a href="#"  ng-click="emptycabin();">empty cabins</a><br/>
  </div>
</div>


<div  class="col-md-8" id="result" style="border-left:1px solid black;">

</div>

</div>




<div id="empl" style="display:none;">
<table  border="1" style="margin-top:20px;margin-bottom:20px;">

<tr ng-repeat="x in empls"> 
<th ng-if="$index==0"><b>designation</b></th>
<th ng-if="$index==0"><b>name</b></th>
<th ng-if="$index==0"><b>age</b></th>
<th ng-if="$index==0"><b>NID</b></th>
<th ng-if="$index==0"><b>contact</b></th>
<th ng-if="$index==0"><b>address</b></th>
</tr>

<tr ng-repeat="x in empls"> 
<td>{{x.designation}}</td>
<td>{{x.name}}</td>
<td>{{x.age}}</td>
<td>{{x.nid}}</td>
<td>{{x.contact}}</td>
<td>{{x.permanantaddress}}</td>
</tr>
</table>

</div>





<div align="center"  id="admit" style="display:none;margin-bottom:10px;">
<table style="background-color:skyblue;margin-top:10px;margin-bottom:5px;" border="1">
<tr><td><input ng-model="cab.name" placeholder="name" /></td></tr>
<tr><td><input ng-model="cab.age" placeholder="age"/></td></tr>
<tr><td><select ng-model="cab.gender">
<option value="male">male</option>
<option value="female">female</option>
<option value="third gender">third gender</option>
</select><b>(gender)</b></td> </tr>
<tr><td><input ng-model="cab.phone" placeholder="phone"/></td></tr>
<tr><td><input ng-model="cab.address" placeholder="address"/></td></tr>
<tr><td><select  ng-model="cab.bedno" ng-options="c for c in bed">
</select><b>(bed no)</b></td> </tr>
<tr><td><b>from</b><input type="date" ng-model="cab.admit"/></td></tr>
<tr><td><b>to</b><input type="date" ng-model="cab.enddate"/></td></tr>
</table>
<button class="btn btn-success btn-sm" ng-click="addcabin();">add</button>
<br/>
</div>





<div align="center"  id="cabrecord" style="display:none;margin-bottom:10px;">
<h5 style="color:maroon;">cabin record's</h5>
<div style="font-size:0.8em;background-color:antiquewhite;margin-top:5px;margin-bottom:5px;">
<b>filter by name:</b><input type="text" ng-model="cabsearch.name"  onclick="cabindisplay();"/> <b>filter by bedno </b> <input type="text" ng-model="cabsearch.bedno" onclick="cabindisplay();"/><br/>
<b>filter by phone:</b><input type="text" ng-model="cabsearch.phone" onclick="cabindisplay();"/> <b>filter by address</b><input type="text" ng-model="cabsearch.address" onclick="cabindisplay();"/> <br/>
<b>filterby two date</b> <input type="date" ng-model="date1" placeholder="1st date"/>  
<input type="date" ng-model="date2" placeholder="2nd date" ng-change="sbytwodate();" />

</div>
<table id="cabintab1">
<tr ng-repeat="c in allcabin">
<th ng-if="$index==0">name</th>
<th ng-if="$index==0">age</th>
<th ng-if="$index==0">phone</th>
<th ng-if="$index==0">bed no</th>
<th ng-if="$index==0">address</th>
<th ng-if="$index==0">duration</th>
<th ng-if="$index==0">leaving date</th>
</tr>
<tr ng-repeat="c in allcabin | filter : cabsearch">
<td>{{c.name}}</td>
<td>{{c.age}}</td>
<td>{{c.phone}}</td>
<td>{{c.bedno}}</td>
<td>{{c.address}}</td>
<td>{{c.duration}}day</td>
<td>{{c.enddate}}</td>
</tr>
</table>

<table id="cabintab2">
<tr ng-repeat="c in cabinbydate">
<th ng-if="$index==0">name</th>
<th ng-if="$index==0">age</th>
<th ng-if="$index==0">phone</th>
<th ng-if="$index==0">bed no</th>
<th ng-if="$index==0">address</th>
<th ng-if="$index==0">duration</th>
<th ng-if="$index==0">leaving date</th>
</tr>
<tr ng-repeat="c in cabinbydate">
<td>{{c.name}}</td>
<td>{{c.age}}</td>
<td>{{c.phone}}</td>
<td>{{c.bedno}}</td>
<td>{{c.address}}</td>
<td>{{c.duration}}day</td>
<td>{{c.enddate}}</td>
</tr>
</table>


</div>


<button  id="emptycab" data-toggle="modal" data-target="#emptycabmod" style="display:none;">empty</button>
<div  id="emptycabmod"  class="modal fade" role="dialog" >
        <div class="modal-dialog" >
        <div class="modal-content" style="border-radius:10px;width:600px;font-size:0.85em;">
        <div class="modal-header" style="color:maroon;border:1px solid black;">
        <b>available empty beds number</b>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
  <div class="modal-body" style="border:1px solid black;background-color:skyblue;">
<table  border="1">
<tr ng-repeat="x in cabs"> 
<th ng-if="$index==0"><b>name</b></th>
<th ng-if="$index==0"><b>age</b></th>
<th ng-if="$index==0"><b>phone</b></th>
<th ng-if="$index==0"><b>duration</b></th>
<th ng-if="$index==0"><b>bedno</b></th>
<th ng-if="$index==0"><b>end date</b></th>
<th ng-if="$index==0"><b>address</b></th>
</tr>
<tr ng-repeat="x in cabs"> 
<td>{{x.name}}</td>
<td>{{x.age}}</td>
<td>{{x.phone}}</td>
<td>{{x.duration}} days</td>
<td>{{x.bedno}}</td>
<td>{{x.enddate}}</td>
<td>{{x.address}}</td>
</tr>
</table>
</div>
   <div class="modal-footer" style="background-color:gray;border:1px solid black;">
  </div>
   </div>
  </div>
 </div>




<div id="myModal" class="modal fade" role="dialog" >
        <div class="modal-dialog" style="border-radius:10px;width:420px;">
        <div class="modal-content">
        <div class="modal-header" style="background-color:gray;border:1px solid black;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body" style="border:1px solid black;background-color:skyblue;">

<table align="center" >
<tr>
<td><input ng-model="emp.name" placeholder="name"  /></td>
</tr>
<tr>
<td><input ng-model="emp.age" placeholder="age" id="age" /></td>
</tr>
<tr>
<td><input ng-model="emp.nid" placeholder="NID NUMBER"  /></td>
</tr>

<tr>
<td><select ng-model="emp.designation" placeholder="designation" >
<option value="doctor">doctor</option>
<option value="nurse">nurse</option>
<option value="cleaner">cleaner</option>
<option value="guard">guard</option>
<option value="labratorist">labratorist</option>
<option value="receptionist">receptionist</option>
</select><b>(occupation)</b></td>
</tr>
<tr>
<td><select ng-model="emp.gender" placeholder="gender"  >
<option value="male">male</option>
<option value="female">female</option>
<option value="third gender">third gender</option>
</select><b>(gender)</b></td>
</tr>
<tr>
<td><input ng-model="emp.contact" placeholder="contact" id="contact" /></td>
</tr>
<tr>
<td><textarea style="font-size:0.70em;" rows="5" column="25" ng-model="emp.permanantaddress" placeholder="permanant address"></textarea></td>
</tr>
</table>

  </div>
   <div class="modal-footer" style="background-color:gray;border:1px solid black;">
   <button  class="btn btn-default" ng-click="addemployee();">submit</button>
    </div>
   </div>
  </div>
 </div>

</body>
</html>