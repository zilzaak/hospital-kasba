<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page  isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="<c:url value="/static/theme/fontawesome470.css" /> " rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>
<style>

</style>

<script>
$(document).ready(function(){
	
$("#profile").click(function(){
$("#divpro").css("display","block");
$("#divchat").css("display","none");
$("#divapp").css("display","none");

	
})	

$("#chat").click(function(){

	$("#divpro").css("display","none");
	$("#divchat").css("display","block");
	$("#divchat").css("background-color","lightsteelblue");
	$("#divapp").css("display","none");
	
})	
$("#appoint").click(function(){

	$("#divpro").css("display","none");
	$("#divchat").css("display","none");
	$("#divapp").css("display","block");
	$("#divapp").css("background-color","cadetblue");
	
})	
	
})
</script>

<script>
var odr=<%=session.getAttribute("drr") %> ;
var m = angular.module("app",[]);
m.controller("con",function($scope,$http){

$scope.dr=odr;
	
	$scope.activepatient=function(){
var did = document.getElementById("did").value;

		 $http({
		method:"POST",
			url:"${pageContext.request.contextPath}/dchat/activepatient",
			 data: angular.toJson(did),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
			 $scope.patients=response.data;
			 if($scope.patients.length<1){
				 alert("no patient available");
			 }
	                         
			    })
			    
     }	
	
	$scope.chatwithpr=function(i){
		var did = document.getElementById("did").value;
		$scope.pr=$scope.patients[i];
		var pid = $scope.patients[i].person;
	var r={"sid":pid,"aid":did,"studsms":"","pssms":"","date":"","stringdate":""}
	 $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/dchat/chatwithpr",
				 data: angular.toJson(r),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				 $scope.dmsgs=response.data;
				 if($scope.dmsgs.length<1){
			alert("no message record available");
				 }
				 document.getElementById("btnp").click();	 
				 
		    })
		}
	
	

	
	$scope.dsend=function(){
		var did = document.getElementById("did").value;
     	var sms = document.getElementById("md").value;
		var r = {"sid":$scope.pr.person, "aid":did, "studsms":"","pssms":sms,"date":"","stringdate":""};

	if(sms==""){
		alert("empty message, write text")
	}
	else{
	$http({
	  method:"POST",
		url:"${pageContext.request.contextPath}/dchat/dsend",
	    data: angular.toJson(r),
	headers: {"Content-Type":"application/json"}}).
	then(function(response){
	document.getElementById("md").value="";
	$scope.dmsgs=response.data;
	                   
       })
	}     
		        }	
	
	$scope.unread=function(){
		var did = document.getElementById("did").value;
		
		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/dchat/unreadd",
		data: angular.toJson(did),
		headers: {"Content-Type":"application/json"}}).
	    then(function(response){
	       $scope.unr=response.data;
	if($scope.unr.length<1){
		alert("no message available");
	                       }

	                           })		
	
    }
	
	
	
	
$scope.d=["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26",
	"27","28","29","30","31"];	
	$scope.m=[];
	$scope.y=[];
		
$scope.appoint=function(){


	var did = document.getElementById("did").value;
	var r = {"chsid":"","chdid":did, "stringdate":"","prname":"","dname":"","serialno":""
			
	}
	
  $http({
	method:"POST",
  url:"${pageContext.request.contextPath}/appoint/appinadate",
  data: angular.toJson(r),
  headers: {"Content-Type":"application/json"}}).
		then(function(response){
			
	   $scope.applist=response.data;
		if($scope.applist.length<1){
			alert("no appointment available in this date")
			document.getElementById("appointtable").style.display="none";
		}else{
			document.getElementById("appointtable").style.display="block";
		}
			
			 })	
			 
    		 
		
}


$scope.seenit=function(x){


        $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/dchat/seenit",
				data: angular.toJson(x),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				$scope.dmsgs=response.data; 
		            
				}) 
				
		$scope.pr={"name":x.lsname,"person":x.lsid,"designation":"patient","active_status":"active"}		
	document.getElementById("btnp").click();    

		   }


$scope.refresh=function(){
	var did = document.getElementById("did").value;
   var r = {"sid":$scope.pr.person, "aid":did, "studsms":"","pssms":"","date":"","stringdate":""}; 
$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/dchat/refreshd",
    data: angular.toJson(r),
	headers: {"Content-Type":"application/json"}}).
	then(function(response){
		document.getElementById("md").value="";
    $scope.dmsgs=response.data;
      
	})
      
	  }  
	  
	  
	  
	  
	  
$scope.allpres=function(f){
	
$http({
	method:"POST",
	url:"${pageContext.request.contextPath}/pres/drcopy",
    data:f,
	headers: {"Content-Type":"text/plain","responseType":"application/json"}}).
	then(function(response){
		
    $scope.prescriptions=response.data;
      
	}) 
      
	  }   
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  

$scope.days=["sat","sun","mon","tue","wed","thu","fri"];
$scope.selected=["n","n","n","n","n","n","n"];


$scope.handle=function(i){
if($scope.selected[i]=="n"){
	$scope.selected[i]=$scope.days[i];	
	
}	
else{
	$scope.selected[i]="n";	
	
}

}



$scope.sby2date=function(){
	var did = document.getElementById("did").value;
	var tdt = [$scope.dt1,$scope.dt2];
	  $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/appoint/appbytwodate",
				data: angular.toJson(tdt),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				$scope.applist = response.data;
				document.getElementById("appointtable").style.display="block";   
				}) 
				
	}




$scope.sbyafterdate=function(){

  $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/appoint/appbyafter",
				data:  angular.toJson($scope.dt3) ,
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				$scope.applist = response.data;
				document.getElementById("appointtable").style.display="block";   
				}) 
				
	}




$scope.sbybeforedate=function(){
	var did = document.getElementById("did").value;

	  $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/appoint/appbybefore",
				data: angular.toJson($scope.dt4),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				$scope.applist = response.data;
				document.getElementById("appointtable").style.display="block";   
				}) 
				
	}
	
	
	
$scope.allapp=function(){

	var did = document.getElementById("did").value;
	  $http({
			method:"POST",
				url:"${pageContext.request.contextPath}/appoint/allappfordr",
				data: angular.toJson(did),
				headers: {"Content-Type":"application/json"}}).
				then(function(response){
				$scope.applist = response.data;
				document.getElementById("appointtable").style.display="block";   
				}) 
	
	
                   }	
	
	


$scope.update=function(){

	var x=" ";
	angular.forEach($scope.selected,function(d,i){
	
		if(d!="n" ){
			if(x==" "){
				x=d;
			}
			else{
			x=x+","+d;	
			}
                     }
          })
	
          
	 $scope.dr.day=x;

    
	
	$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/updatedoc",
		data: angular.toJson($scope.dr),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
		
           alert("successfully updated profile");                
		        })	

		        
		      
}


	
})

function validate(){
var f = document.getElementById("file");
if(f.files.length==0){
	alert("no file chosen");
	
	return false;
}
else{
	return true;
}

}



function selectappdate(){
	var x = document.getElementById("selid").value;
if(x=="one"){
	document.getElementById("app1").style.display="block";	document.getElementById("app2").style.display="none";
	document.getElementById("app3").style.display="none";	document.getElementById("app4").style.display="none";
}
if(x=="two"){
	document.getElementById("app1").style.display="none";	document.getElementById("app2").style.display="block";
	document.getElementById("app3").style.display="none";	document.getElementById("app4").style.display="none";
}
if(x=="three"){
	document.getElementById("app1").style.display="none";	document.getElementById("app2").style.display="none";
	document.getElementById("app3").style.display="block";	document.getElementById("app4").style.display="none";
}
if(x=="four"){
	document.getElementById("app1").style.display="none";	document.getElementById("app2").style.display="none";
	document.getElementById("app3").style.display="none";	document.getElementById("app4").style.display="block";
}

if(x=="zero"){
	document.getElementById("app1").style.display="none";	document.getElementById("app2").style.display="none";
	document.getElementById("app3").style.display="none";	document.getElementById("app4").style.display="none";
	document.getElementById("allappid").click();
}

}




function fileValidation() { 
    var fileInput =  
        document.getElementById('file'); 
      
    var filePath = fileInput.value; 
  
    // Allowing file type 
    var allowedExtensions =  
            /(\.jpg|\.jpeg|\.png|\.gif)$/i; 
      
    if (!allowedExtensions.exec(filePath)) { 
          alert('Invalid file type'); 
           fileInput.value = ''; 
                 return false; 
                                 }  
    else  
    { 
    	 return true; 
     } 
} 



</script>


<style>
div.modal-body{
  background-color: lightblue;
  height:200px;
   overflow-y: scroll;
}
#side ul li:hover{
background-color:white;
}

#side ul li{
height:40px;
align:center;
border-radius:5px;
margin-right:30px;
}
#side{
border-right:2px solid black;
width:200px;
background-color:skyblue;

}


</style>
</head>

<body ng-controller="con" ng-app="app">
<%
if(session.getAttribute("Dusername")==null && session.getAttribute("Dpassword")==null){
	response.sendRedirect("${pageContext.request.contextPath}");
}
%>
<input type="hidden"  id="did"  value="${aid}"/>
<input type="hidden"  id="dname" value="${Dusername}"/> <form action="${pageContext.request.contextPath}/logout" style="margin-left:30px;">
                                                        <input type="text" style="display:none;"  name="id" value="${aid}"/>
                                                        <input type="text"   style="display:none;"   name="log" value="doctor"/>
                                                        <button type="submit" class="btn btn-info">logout</button>
                                                         </form>
<button id="allappid" ng-click="allapp();" style="display:none;">appfordr</button>                                                         
                                                         
                                                         
<div class="row" style="margin-top:20px;margin-left:30px;border:2px solid;margin-right:30px;">
 <div class="cols-sm"  id="side">
 <ul style="list-style-type:none;">
 <li  style="margin-top:40px;border:2px solid green;" id="profile"><h>profile</h></li>
 <li style="margin-top:40px;border:2px solid green;" id="chat"><h>prescribe</h></li>
 <li style="margin-top:40px;border:2px solid green; margin-bottom:40px;" id="appoint"><h>appointment</h></li>
 </ul>
 </div>
 
<div class="col" align="center" style="width:700px;display:block;background-color:azure;" id="divpro">
 <br/> 
 <div class="row">
 <div class="col">
 <img style="width:100px;height:80px;" src="<c:url value="/static/images/{{dr.filename}}" />" />
 </div>
  <div class="col">
  <table border="2">
  <tr>
  <td><b>name: {{dr.name}}</b> <span style="padding-left:100px;"><b>age: {{dr.age}}</b></span> 
  <span style="padding-left:50px;"><b>contact: {{dr.drphone}}</b></span></td>
  </tr>
 <tr><td><b>degree: {{dr.schedule}}</b>  <span style="padding-left:50px;"><b>days: {{dr.day}}</b></span></td></tr>
          <tr>
     <td><b>expert field: {{dr.expertint}} </b></td> 
  </tr>
    </table>
 </div>
 </div>
<br/>

 <div class="row" style="margin-left:18px;">
 <div class="col" style="margin-left:100px;">
 <form action="${pageContext.request.contextPath}/drupload" method="post" enctype="multipart/form-data"
onsubmit="return validate();" onchange="return fileValidation();">
<input  type="file" name="file" id="file" />
<br/><br/>
<button style="margin-left:-170px;" type="submit" class="btn btn-sm btn-info">update you picture</button>
</form>
 </div>
 <div class="col">
 <br/><br/>
 <button id="btnupdate"  class="btn btn-info btn-sm" data-toggle="modal" data-target="#updatemodal">update profile</button>
 </div>
</div>
</div>


<div class="col" align="center" style="width:700px;display:none;background-color:azure;" id="divapp" >
<br/> 
<div class="row" style="background-color:lightgray;">
<div class="col">
<b style="color:maroon;">find patients appointment list </b><select onchange="selectappdate();" id="selid">
<option value="---"><b>----</b></option>
<option value="zero"><b>all appointment list</b></option>
<option value="one"><b>appointment in a date</b></option>
<option value="two"><b>appointment after a date</b></option>
<option value="three"><b>appointment before a date</b></option>
<option value="four"><b>appointment within two date</b></option>
</select>
</div>
<div class="col">


<div style="display:none;" id="app1">
<b>select a particular date</b><input style="font-size:0.70em;" type="date" ng-model="dt" /> 
<button  class="btn btn-info btn-sm" ng-click="appoint();">find</button>
</div>


<div style="display:none;" id="app2" >
<b>select the date</b><input style="font-size:0.70em;" type="date" ng-model="dt3" />

 <button   class="btn btn-info btn-sm" ng-click="sbyafterdate();">find</button>

</div>


<div style="display:none;" id="app3">
<b>choose the date</b><input style="font-size:0.70em;" type="date" ng-model="dt4" />  

<button   class="btn btn-info btn-sm" ng-click="sbybeforedate();">find</button>

</div>


<div style="display:none;" id="app4">
<b>choose from</b> <input style="font-size:0.70em;" type="date" ng-model="dt1" /> 
<b>to </b><input style="font-size:0.70em;" type="date" ng-model="dt2" />  
<button   class="btn btn-info btn-sm" ng-click="sby2date();">find</button>

</div>
</div>
</div>






<div>
<br/>
<b>search patient</b><input  type="text" placeholder="patient name" ng-model="nam"/><br/>
<table class="table" border="2" style="background-color:white;display:none;width:38%;" id="appointtable">
<tr>
<th>patient</th>
<th>serial no</th>
<th>date</th>
<th>doctor</th>
</tr>
<tr ng-repeat="x in applist | filter : nam" >
<td align="center">{{x.prname}}</td>
<td align="center">{{x.sirialno}}</td>
<td align="center">{{x.stringdate}}</td>
<td align="center">{{x.dname}}</td>
</tr>
</table>
</div>
</div>
 
 

 

 
<div class="col" align="center" style="width:700px;display:none;background-color:azure;" id="divchat">
<br/>
<div class="row">

<div class="col">

<h1 style="width:110px;" class="btn btn-sm btn-info" ng-click="activepatient();">messages</h1>
<table border="2" style="background-color:white;">
<tr ng-repeat="x in patients">
<td ng-if="$index==0"><b>id</b></td>
<td ng-if="$index==0"><b>name</b></td>
<td ng-if="$index==0"></td>
<td ng-if="$index==0"></td>
</tr>
<tr ng-repeat="x in patients">
<td></b>{{x.person}}</td>
<td>{{x.name}}</td>
<td ng-if="x.active_status=='active'" style="color:green;">{{x.active_status}}</td>
<td ng-if="x.active_status=='inactive'" style="color:gray;">not active</td>
<td ng-click="chatwithpr($index);" style="color:blue;">chat</td>
</tr>
</table>
</div>
<div class="col">
<h1 style="width:110px;" class="btn btn-sm btn-info" ng-click="allpres(dr.did);">records</h1>
<table border="1">
<tr ng-repeat="p in prescriptions">
<td ng-if="$index==0">name</td>
<td ng-if="$index==0">age</td>
<td ng-if="$index==0">date</td>
<td ng-if="$index==0">details</td>
</tr>
<tr ng-repeat="p in prescriptions">
<td>{{p.name}}</td>
<td>{{p.age}}</td>
<td>{{p.date}}</td>
<td><a href="${pageContext.request.contextPath}/pres/downloadpres/{{p.presid}}">details</a></td>
</tr>
</table>

</div>
<div class="col">
<h1  style="width:110px;" class="btn btn-sm btn-info" ng-click="unread();">unread</h1>
<table border="2" style="background-color:white;">
<tr ng-repeat="x in unr">
<td style="background-color:green;">new messaage</td>
<td>id:{{x.lsname}}</td>
<td ng-click="seenit(x);" style="color:blue;">chat</td>
</tr>
</table>
</div>
</div>
</div>
</div>

<button  id="btnp"  style="display:none;" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModalp"></button>
<div id="myModalp" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="border-radius:10px;width:400px;">
  
    <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
      <b>patient name: {{pr.name}}</b>
     <a href="${pageContext.request.contextPath}/pres/prescribe/{{pr.person}}/{{dr.did}}"> <b style="color:maroon;margin-left:10px;Background-color:green;">prescribe</b></a>
      <button type="button" class="close" data-dismiss="modal">&times;</button>
        <b class="modal-title">close</b>
        
      </div>
      <div class="modal-body">
         
       <div class="row" ng-repeat="x in dmsgs">
     <div class="col" >
      <b style="background-color:lightgray;font-size:0.80em;">{{x.studsms}}</b>
      <p style="font-size:0.55em;">{{x.stringdate}}</p>
      </div>
      <div class="col" >
      <b style="background-color:dodgerblue;color:white;font-size:0.80em;">{{x.pssms}}</b>
      <p style="font-size:0.55em;">{{x.stringdate}}</p>
     </div>
     </div>   
       
</div>
    <div class="modal-footer" style="background-color:gray;">
    <input type="text" id="md" /> 
<button class="btn btn-success btn-sm" ng-click="dsend();">send</button>
<button class="btn btn-success btn-sm" ng-click="refresh();">refresh</button>
   </div>
   </div>
</div>
</div>




<div id="updatemodal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="border-radius:10px; width:400px;" >
  
    <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
      <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
       <div style="margin-left:80px;margin-bottom:17px;">
  <table style="width:250px;">
<tr><td>select days</td></tr>
<tr>
<td ng-repeat="z in days" >
<input type="checkbox" ng-click="handle($index);">{{z}} </input>
</td>
</tr>
</table>

  <table>
       <tr>
          <td><input   placeholder="username" ng-model="dr.name"  /></td>
          </tr>
             <tr>
          <td><input placeholder="phone"    ng-model="dr.drphone" /></td>
          </tr>
           <tr>
          <td> <input placeholder="age"  ng-model="dr.age" /> </td>
          </tr>
           <tr>
          <td><input  placeholder="degree" ng-model="dr.degree" />  </td>
          </tr>
           <tr>
          <td><input     placeholder="schedule"    ng-model="dr.schedule" />  </td>
          </tr>
           <tr>
          <td> <input   placeholder="expertin" ng-model="dr.expertint" /> </td>
          </tr>
           <tr>
       </table>
       
         </div>
       <div class="modal-footer" style="background-color:gray;">
<button class="btn btn-success btn-sm" ng-click="update();">submit</button>
<br/><br/>
   </div>
   </div>
</div>
</div>

</body>
</html>