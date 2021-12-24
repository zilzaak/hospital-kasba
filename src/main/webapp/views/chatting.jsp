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

var module = angular.module("chatapp",[]);
module.controller("chatcon",function($scope,$http){
	
	$scope.activedr=function(){
		
		$http({
			method:"GET",
			url:"${pageContext.request.contextPath}/chat/activedr",
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
				     $scope.drs=response.data;
	                             
			        })	
			}	
	

$scope.chatwithdr=function(i){
	 var patientid = document.getElementById("patientid").value;
  	$scope.dr=$scope.drs[i];
		$scope.aid=$scope.dr.person;
		
	var r= {"sid":patientid ,"aid":$scope.aid,"studsms":"","pssms":"","date":""};

	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/chat/chatwithdr",
		data: angular.toJson(r),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			$scope.pmsg=response.data;
			
			 })	
	
	document.getElementById("btnp").click();
	
}

$scope.psend=function(){
	var pid = document.getElementById("patientid").value;
     
	var sms = document.getElementById("idms").value;
	
var r = {"sid":pid, "aid":$scope.aid, "studsms":sms,"pssms":"","date":"","stringdate":""};

if(sms==""){
	alert("empty message, write text")
}
else{
$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/chat/psend",
     data: angular.toJson(r),
	headers: {"Content-Type":"application/json"}}).
	then(function(response){
		document.getElementById("idms").value="";
		$scope.pmsg=response.data;
                       
	        })
	        
}     
	        }
	        
$scope.refresh=function(){
	var pid = document.getElementById("patientid").value;
   var r = {"sid":pid, "aid":$scope.aid, "studsms":"","pssms":"","date":"","stringdate":""}; 
$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/chat/refreshp",
    data: angular.toJson(r),
	headers: {"Content-Type":"application/json"}}).
	then(function(response){
		document.getElementById("idms").value="";
    $scope.pmsg=response.data;
      })
	  }        
	        
	        

$scope.messages=function(){
	var sid = document.getElementById("patientid").value;
     $http({
		method:"POST",
		url:"${pageContext.request.contextPath}/chat/chatrecord",
	    data: angular.toJson(sid),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			
		$scope.msgs=response.data;
		if($scope.msgs.length==0){
			alert("no message record is available");
		}
		
     })
	                  }
	                  
	                  
	$scope.mchat=function(x){
		$scope.activedr();
		
		angular.forEach($scope.drs,function(v,i){
		if(x.aid==v.person){
             $scope.chatwithdr(i);
		}	
		
		})
	
	}    
	
	
	$scope.unread=function(){
		var sid = document.getElementById("patientid").value;
     
		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/chat/unreadp",
		data: angular.toJson(sid),
		headers: {"Content-Type":"application/json"}}).
	    then(function(response){
	    	
	    $scope.unr=response.data;
			if($scope.unr.length<1){
				alert("there is no unread message")
			}	
	 })		
	
	            }
	
	
	
	
	$scope.prescription=function(){
		var sid = document.getElementById("patientid").value;
		var pn = document.getElementById("patientname").value;
	     $http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pres/patientcopy",
			data: pn,
			headers: {"Content-Type":"text/plain","responseType":"application/json"}}).
			then(function(response){
				
			$scope.prescriptions=response.data;
			if($scope.prescriptions.length==0){
				alert("no prescription is available");
			}
			
	     })
		                  }	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	                  
	
});	
	

</script>
<style>
div.modal-body{
  background-color: lightblue;
  height:200px;
   overflow-y: scroll;
}
</style>



</head>

<body ng-controller="chatcon" ng-app="chatapp" style="background-color:black;" >
<input type="hidden" id="patientid"  value="${sid}"/>
<input type="hidden" id="patientname"  value="${pname}"/>

<div class="container" style="margin-top:100px;">
<div  class="row" style="background-color:lightblue;border-radius:7px;border">
<div class="col" style="margin-top:30px;">
<button ng-click="activedr();" style="margin-left:30px;" class="btn btn-sm btn-success">doctors</button><br/>
<table>
<tr ng-repeat="x in drs">
<td> {{x.name}}</td>
<td ng-if="x.active_status=='active' " style="color:green;">{{x.active_status}}</td>
<td ng-if="x.active_status=='inactive' " style="color:gray;">not active</td>
<td ng-click="chatwithdr($index);" style="color:blue;"><b>chat</b></td>
</tr>
</table>

</div>

<div class="col" style="margin-top:30px;">
<button ng-click="unread();" class="btn btn-sm btn-success">unread</button><br/>
<table border="2">
<tr ng-repeat="u in unr" >
<td>{{u.ldid}}</td>
<td>{{u.ldname}}</td>
<td>chat</td>
</tr>
</table>
</div>

<div class="col" style="margin-top:30px;margin-bottom:30px;">
<button ng-click="messages();" class="btn btn-sm btn-success">messages</button><br/>
<table>
<tr ng-repeat="x in msgs">
<td ng-click="mchat(x);" style="color:blue;">chat</td>
<td>{{x.ldname}}</td>
<td style="color:red;">{{x.ldid}}</td>
</tr>
</table>
</div>




<div class="col" style="margin-top:30px;">
<button ng-click="prescription();" class="btn btn-sm btn-success">prescription</button><br/>
<br/>
<table border="2">
<tr ng-repeat="pr in prescriptions" >
<td ng-if="$index==0">patient</td>
<td ng-if="$index==0">doctor</td>
<td ng-if="$index==0">date</td>
<td ng-if="$index==0">download</td>
</tr>
<tr ng-repeat="pr in prescriptions" >
<td>{{pr.drname}}</td>
<td>{{pr.name}}</td>
<td>{{pr.date}}</td>
<td><a href="${pageContext.request.contextPath}/pres/downloadpres/{{pr.presid}}">download</a></td>
</tr>
</table>
<br/>
</div>











</div>
</div>


<button  id="btnp" style="display:none;" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModalp"></button>
<div id="myModalp" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="border-radius:10px;width:400px;">
   <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
      <b>dr name:{{dr.name}}</b>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
      <div class="modal-body">
         
     <div class="row" ng-repeat="x in pmsg">
     <div class="col" >
      <b style="background-color:dodgerblue;color:white;font-size:0.80em;">{{x.studsms}}</b>
      <p style="font-size:0.50em;">{{x.stringdate}}</p>
      </div>
      <div class="col" >
      <b style="background-color:lightgray;font-size:0.80em;">{{x.pssms}}</b>
      <p style="font-size:0.50em;">{{x.stringdate}}</p>
     </div>
     </div>      
       
</div>
    <div class="modal-footer" style="background-color:gray;">
    <input type="text"   id="idms" />
    <button class="btn btn-success btn-sm" ng-click="psend();">send</button>
    <button class="btn btn-info btn-sm" ng-click="refresh();">refresh</button>
   </div>
   </div>
</div>
</div>
</body>
</html>