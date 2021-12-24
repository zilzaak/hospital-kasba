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
<link href="<c:url value="/static/theme/jquery-ui.css" /> " rel="stylesheet"> 
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/jquery-ui.js" />" > </script> 
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>

<script type="text/javascript">


	
var module = angular.module("search",[]);
module.controller("searchcontrol",function($scope,$http){

	$scope.day=["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24",
		"25","26","27","28","29","30","31"];
	$scope.month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	$scope.year=[];
	$scope.startday=function(){
		var i; 
		for(i=2010;i<3001;i++){
			$scope.year.push(i);
		}
		
	}
	
	$scope.dt="";
	$scope.typeit = function(r){
		$http({
				method:"POST",
				url:"${pageContext.request.contextPath}/appoint/drbydis",
				data: r,
				//data:angular.toJson(d),
				headers: {"Content-Type":"text/plain","responseType":"application/json"}}).
				then(function(response){
				  $scope.drlist=response.data;
				 
				   })	
				   }	
	
$scope.knockdr=function(i){
$scope.dr=$scope.drlist[i];
document.getElementById("appmodel").click();	
}


	$scope.setday=function(){
		
	$scope.dt=$scope.d+"/"+$scope.m+"/"+$scope.y;

		
	}
	
$scope.appdate=function(){
	
	var pname = document.getElementById("pname").value;
	var sid = document.getElementById("sid").value;
	var r = {
	"chsid":sid, "chdid":$scope.dr.did, "prname":pname, "dname":$scope.dr.name, "stringdate":$scope.dt,
	"sirialno":"","pdfname":"",
	"chsmg":""
			}	

	
if($scope.dt.length==10){
	
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/appoint/chooseapp",
			data:angular.toJson(r),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
			  $scope.appoint=response.data;
			  
			   if($scope.appoint.chsmg=="successfull"){
                	alert("successfull,check your email");
                	
                }
                else{
                	 alert($scope.appoint.chsmg);
                	
                }
			  
			       })		
		}
                 	else {
		alert("select appointment date");
	                   } 
	     }
		     
		     
	$scope.records=function(){
		var sid = document.getElementById("sid").value;
		
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/appoint/myapprecord",
			data:angular.toJson(sid),
			headers: {"Content-Type":"application/json"} }).
			then(function(response){
			$scope.records=response.data;
			
			   })
			   }	      
	
})




</script>


</head>

<body ng-app="search"  ng-controller="searchcontrol" style="border-top:4px solid;border-left:4px solid;border-right:4px solid;" ng-init="startday()">

    <div style="margin-left:100px;">
     <a href="${pageContext.request.contextPath}/logout?log=patient&id=${sid}"><h3 style="color:black">LOG OUT</h3></a>
     </div>
     
     <div class="row">
   
     <div class="col" style="margin-left:100px;margin-top:20px;border:2px solid;">
     <br/>
      <h>search doctor</h>
      <input  ng-model="disname" ng-keyup="typeit(disname)" placeholder="type desease name"/><br/><br/>
	  <table style="margin-left:140px;margin-bottom:20px;" >
	  
	 <tr ng-repeat="x in drlist" >
	 <td id="t1">{{x.name}}</td>
	 <td ng-click="knockdr($index);" style="color:blue;">{{x.expertint}}</td>
	 </tr>
	 
	 </table>	
     </div>	  
    <div class="col" style="margin-top:20px;border:2px solid;margin-right:100px;text-align:center;" >
    <br/>
    <button ng-click="records();" class="btn btn-success btn-md">appointment history</button>
    
    <div style="margin-left:180px;margin-top:30px;margin-bottom:50px;">
     <table border="2">
    <tr ng-repeat="x in records">
    <td>{{x.dname}}</td>
    <td>{{x.stringdate}}</td>
    <td>{{x.prname}}</td>
    <td><a href="${pageContext.request.contextPath}/appoint/downloadapp/{{x.pdfname}}">download</a></td>
    <td></td>
    </tr>
    </table>
    </div>
   
     </div>
	 	
     </div>
	

<button  id="appmodel" style="display:none;" class="btn btn-info btn-sm" data-toggle="modal" data-target="#opendr"></button>

<div id="opendr" class="modal fade" role="dialog">
  <div class="modal-dialog">

      <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body"">
      <table align="center" border="1">
      <tr><td><img style="height:100px;width:100px;" ng-src="/static/images/{{dr.filename}}"></td></tr>
      <tr><td>degree:{{dr.degree}}</td></tr>
      <tr><td>contact:{{dr.drphone}}</td></tr>
      <tr><td>time:{{dr.schedule}}</td></tr>
      <tr><td>days:{{dr.day}}</td></tr>
       <tr><td>expert in:{{dr.expertint}}</td></tr>
      </table>
      <p><b>select appointment date of {{dr.name}}</b></p><br/>
<input type="text" id="sid" value="${sid}" style="display:none;"/>
<input type="text"  id="pname"   value="${username}" style="display:none;" />

 <b>day:</b><select placeholder="day" ng-options="c for c in day" ng-model="d"  ng-change="setday()"></select>
 <b>month:</b><select ng-options="c for c in month" ng-model="m" ng-change="setday()"></select>
 <b>year:</b><select ng-options="c for c in year" ng-model="y" ng-change="setday()"></select>
 
<button class="btn btn-success" ng-click="appdate();">submit</button>
 </div>
 <div class="modal-footer" style="background-color:gray;">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
	

</body>
</html>