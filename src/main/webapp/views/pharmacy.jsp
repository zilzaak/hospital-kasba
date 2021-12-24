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
var remainexist="0";
var med = <%= session.getAttribute("pharma")%>

var selldrugfs = <%= session.getAttribute("selldrug")%>

var module = angular.module("pharapp",[]);

module.controller("pharcon",function($scope,$http){
	
	$scope.selldrug=selldrugfs;
	$scope.pharma=med;
	$scope.companies=["Reneta","Beximco","Aristo Pharma","Radiant","Incepta","ACI","Opsonin","Square"];
	$scope.type=["tablet","File","cream","Veccine","Dose","Canola","Seline","Drop","Antibiotic"];	
	$scope.power=["ml","mg","ccg","cl","cc"];
	
	
	$scope.rem=function(r){
		
		if(r=='type'){
			$scope.search.name="";	$scope.search.company="";
		}
	if(r=='name'){
		$scope.search.type="";	$scope.search.company="";
		}
	if(r=='company'){
		$scope.search.name="";	$scope.search.type="";
	}
	
	}
	
$scope.add=function(){
	
	var arr1 = {
				
			"type":"","name":"" ,"company":"","power":"","totalunit":"","unitprice":"","dimension":"","date":"","totalprice":""
	        }
	
	if( $scope.pharma.medicines.length<20){
		$scope.pharma.medicines.push(arr1);
	}
	else{
		alert("ca not add more than 20 items for every insertion");
	}

	     }
	     
	     
	     
	
$scope.addsell=function(){
	
	var arr1 = {
				
			"type":"","name":"" ,"company":"","power":"","totalunit":"","unitprice":"","dimension":"","totalprice":""
	        }
	
	if($scope.selldrug.invoices.length<20){
		$scope.selldrug.invoices.push(arr1);
	}
	else{
		alert("ca not add more than 20 items for every insertion");
	}

	     }




                     
                     
                     
$scope.remove=function(){
	if($scope.pharma.medicines.length>2){
		var length = $scope.pharma.medicines.length;
		 $scope.pharma.medicines.splice(length-1,1);
	}
	else{
	alert("can not remove record")	
	}
	     }   
	     
	     
	     
$scope.removesell=function(){
	if($scope.selldrug.invoices.length>2){
		var length = $scope.selldrug.invoices.length;
		$scope.selldrug.invoices.splice(length-1,1);
	}
	else{
	alert("can not remove record")	
	}
	     }   	     
	     
	     
	     
	     
	 


$scope.postexistpharm=function(ex){
	
	var answer = window.confirm(ex);
	
	if(answer){
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pharmacy/postexistpharma",
			data: angular.toJson($scope.pharma),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){

	alert(response.data.msg);
				
			})	
		
	}else{
		
	}
	
	
}
	     
	     
	     


$scope.submitinfo=function(){
	
		var err="no";
		angular.forEach($scope.pharma.medicines,function(v,i){
			$scope.pharma.medicines[i].date=$scope.dt;
			$scope.pharma.medicines[i].totalprice=v.unitprice*v.totalunit;
			
			if(  v.company=="" || v.type=="" || v.name=="" || v.power=="" || v.date==null ){
			
			err="yes";	
			}	
			
		})
	
	
		
		if(err=="no"){
	
			$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pharmacy/postpharma",
			data: angular.toJson($scope.pharma),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
$scope.res=response.data;
if($scope.res.msg!='success'){
	
$scope.postexistpharm($scope.res.msg);

	
}else{
	
	alert("successfully added")
	
}


				
			})	
	}	
	else{
		alert("blank data field is invalid");
	}

	
	
}











$scope.submitsell=function(){
	var err="no";
	angular.forEach($scope.selldrug.invoices,function(v,i){
$scope.selldrug.invoices[i].totalprice=v.unitprice*v.totalunit;
		
		if(  v.company=="" || v.type=="" || v.name=="" || v.power=="" || $scope.selldrug.date==null ){
		
		err="yes";	
		}	
		
	})


	
if(err=="no"){

		$http({
		method:"POST",
		url:"${pageContext.request.contextPath}/pharmacy/selldrug",
		data: angular.toJson($scope.selldrug),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
$scope.selres=response.data;
alert($scope.selres.msg);
			
		})	
}	
else{
	alert("blank data field is invalid");
}



}












   

$scope.reset=function(v){
	
	if(v=='pharma'){
		angular.forEach($scope.pharma.medicines,function(v,i){
			
			$scope.pharma.medicines[i].type="";
			$scope.pharma.medicines[i].name="";
			$scope.pharma.medicines[i].company="";
			$scope.pharma.medicines[i].totalunit="";
			$scope.pharma.medicines[i].unitprice="";
			$scope.pharma.medicines[i].power="";
			    
		})
		
	}
	
	if(v=='selldrug'){
		angular.forEach($scope.selldrug.invoices,function(v,i){
			
			$scope.selldrug.invoices[i].type="";
			$scope.selldrug.invoices[i].name="";     $scope.selldrug.invoices[i].power="";
			$scope.selldrug.invoices[i].totalunit="";
			$scope.selldrug.invoices[i].unitprice=""; $scope.selldrug.invoices[i].company="";
			$scope.selldrug.invoices[i].totalprice="";
			    
		})
		
	}
		
			
	
}



$scope.perform=function(x){
	if(x=="insert"){
		document.getElementById("insert").style.display="block";
		document.getElementById("records").style.display="none";
		document.getElementById("search").style.display="none";
		document.getElementById("invoice").style.display="none";
	}
	if(x=="records"){
		document.getElementById("insert").style.display="none";
		document.getElementById("invoice").style.display="none";
		document.getElementById("records").style.display="block";
		document.getElementById("search").style.display="none";	
		
	}
	if(x=="search"){
		
		document.getElementById("insert").style.display="none";
		document.getElementById("records").style.display="none";
		document.getElementById("invoice").style.display="none";
		document.getElementById("search").style.display="block";	
		
	}
	
if(x=="invoice"){
	document.getElementById("invoice").style.display="block";
		document.getElementById("insert").style.display="none";
		document.getElementById("records").style.display="none";
		document.getElementById("search").style.display="none";	
		
	}
	
	
	
}

$scope.initial=function(){
	
	document.getElementById("insert").style.display="block";
	document.getElementById("records").style.display="none";
	document.getElementById("search").style.display="none";
	document.getElementById("invoice").style.display="none";
}

;
	
$scope.checktype=function(i){
	
	if($scope.pharma.medicines[i].type=='tablet'){
		return 'ok';
	}
	else{
		return 'no';
	}
	
	
}


$scope.updatetype=function(i){
	
	if($scope.selldrug.invoices[i].type=='tablet'){
		return 'ok';
	}
	else{
		return 'no';
	}
	
	
}


$scope.checkpow=function(i){
	
	if($scope.pharma.medicines[i].type=='tablet' || $scope.pharma.medicines[i].type=='Dose' || $scope.pharma.medicines[i].type=='Veccine' || $scope.pharma.medicines[i].type=='File' || $scope.pharma.medicines[i].type=='Antibiotic' || $scope.pharma.medicines[i].type=='Drop'){
		return 'ok';
	}
	
}

$scope.checkpowsell=function(i){
	
	if($scope.selldrug.invoices[i].type=='tablet' || $scope.selldrug.invoices[i].type=='Dose' || $scope.selldrug.invoices[i].type=='Veccine' || $scope.selldrug.invoices[i].type=='File' || $scope.selldrug.invoices[i].type=='Antibiotic' || $scope.selldrug.invoices[i].type=='Drop'){
		return 'ok';
	}
	
}

$scope.okchn=function(i,l){
	
	$scope.pharma.medicines[i].power=$scope.pharma.medicines[i].power+l;
	
}




$scope.updatepower=function(i,l){
	
	$scope.selldrug.invoices[i].power=$scope.selldrug.invoices[i].power+l;
	
}








$scope.medirecord=function(){
	
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/pharmacy/storingrecord",
		//data: angular.toJson($scope.pharm),
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
$scope.allmedi=response.data;
			
		})	
	
}








$scope.edit=function(i){
	
	$scope.rec=$scope.allmedi[i];
	
	document.getElementById("trigermedi").click();
	
	
	
}



$scope.allstock=function(){
	
	remainexist="1";
	$http({
		method:"GET",
		url:"${pageContext.request.contextPath}/pharmacy/allstock",
		headers: {"Content-Type":"application/json"}}).
		then(function(response){
			$scope.remainstock=response.data;
			
		})	
		
document.getElementById("xname").style.display="none";	
document.getElementById("xtype").style.display="none";
document.getElementById("xcompany").style.display="none";
	
}





$scope.updat=function(x){
	
		$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pharmacy/updat",
			data: angular.toJson(x),
			headers: {"Content-Type":"application/json"}}).
			then(function(response){
	alert("successfully updated information");
				
			})	
		
	}
	
    
        $scope.smedicine;

	$scope.clearfilter=function(f){
		
		if(f=='name'){
			$scope.filterstock.type="";$scope.filterstock.company="";
		}
	if(f=='type'){
		$scope.filterstock.name="";$scope.filterstock.company="";
		}
	if(f=='company'){
		$scope.filterstock.type="";
		$scope.filterstock.name="";
	}
		
	}



	 	
})
	
	
	$(document).ready(function(){
		
		$("#tabadd").onclick(function(){
			$("#tabadd").css("background-color","gray")
		})
		
			$("#tabadd").mouseleave(function(){
			$("#tabadd").css("background-color","skyblue")
		})
		
			$("#tabsearch").mouseenter(function(){
			$("#tabsearch").css("background-color","gray")
		})
		
			$("#tabsearch").mouseleave(function(){
			$("#tabsearch").css("background-color","skyblue")
		})
		
			$("#tabrecord").mouseenter(function(){
			$("#tabrecord").css("background-color","gray")
		})
		
			$("#tabrecord").mouseleave(function(){
			$("#tabrecord").css("background-color","skyblue")
		})
	})





function appdiv(x){

	if(remainexist=="0"){
		
		document.getElementById("filtercondition").click();
	}
	
	if(x=='xname'){
		

		document.getElementById("xname").style.display="block";	
		document.getElementById("xtype").style.display="none";
		document.getElementById("xcompany").style.display="none";
	}
	
	if(x=='xtype'){
	

		document.getElementById("xtype").style.display="block";
		document.getElementById("xcompany").style.display="none";
		document.getElementById("xname").style.display="none";
	}
	
	if(x=='xcompany'){
		

		document.getElementById("xcompany").style.display="block";
		document.getElementById("xtype").style.display="none";
		document.getElementById("xname").style.display="none";	
	}
	
}
	   


</script>

<style>
body{
box-sizing:border-box;
}

#insert #tb th,td{
font-size:0.85em;
word-break:break-all;

                }

#insert #tb {
background-color:lightblue;
margin-top:15px;

             }

button{
width:150px;
}
</style>

</head>
<body ng-controller="pharcon" ng-app="pharapp" ng-init="initial();">

<div align="center" style="margin-left:80px;margin-right:80px;margin-top:25px;border:2px solid green;height:40px;" class="row">
<div class="col" id="tabadd" style="border-right:2px solid green;background-color:skyblue;" ng-click="perform('insert');">
<h><b>store drug</b></h></div>
<div class="col" id="tabrecord" style="border-right:2px solid green;background-color:skyblue;" ng-click="perform('records');">
<h><b>storing records</b></h></div>
<div class="col" id="tabsearch" style="background-color:skyblue;border-right:2px solid green;"  ng-click="perform('search');">
<h><b>present stock</b></h></div>
<div class="col" id="tabsearch" style="background-color:skyblue;"  ng-click="perform('invoice');">
<h><b>make invoice</b></h></div>
</div>





<div align="center" style="margin-left:80px;margin-right:80px;margin-top:10px;border:2px solid green;" id="invoice">
<div style="margin-top:5px;">

<b>Date::</b> <input type="date" ng-model="selldrug.date" />
<b>deliver to:</b> <input type="text" ng-model="selldrug.deliverto"/>
<b>address:</b> <input type="text" ng-model="selldrug.address"/>
<b>contact:</b> <input type="text" ng-model="selldrug.phone"/>
<br/>
</div>


   <table border="2px;" id="tb" >
   <tr>
   <th>index</th>
   <th>Catagory</th>
   <th>Name</th>
   <th>power/volume</th>
   <th>total unit</th>
   <th>unit price</th>
   <th>items per unit</th>
   <th>company</th>
    </tr>
 
   <tr ng-repeat="x in selldrug.invoices">
   <td text-align="center;">{{$index+1}}</td>
   <td><select ng-options="c for c in type"  ng-model="x.type">
   </select></td>
   <td><input placeholder="name" ng-model="x.name" /></td>
   <td >
    <input style="width:70px;"  placeholder="power" ng-model="x.power" />
    <div ng-if="checkpowsell($index)=='ok'">
    <select ng-options="c for c in power" ng-model="k" ng-change="updatepower($index,k);">
    </select>
  
   </div>
   
   </td> 
   
 <td><input style="width:60px;" placeholder="total unit" ng-model="x.totalunit" /></td>   
   <td><input style="width:60px;" placeholder="total unit" ng-model="x.unitprice" /></td> 
   <td>
   <div ng-if="updatetype($index)=='ok'">
    <input style="width:70px;" placeholder="(m*n)items" ng-model="x.dimension" />
   </div>
   <div ng-if="updatetype($index)=='no'">
   ----
   </div>
  </td> 
    <td><select  ng-options="c for c in companies" ng-model="x.company"></select></td>  
   </tr>

   </table>
 <div style="margin-left:-30px;margin-top:20px;">
<table style="margin-top:10px;margin-bottom:15px;">

<td><button class="btn btn-sm btn-info" ng-click="submitsell()">submit</button></td>
<td><button class="btn btn-sm btn-info" ng-click="addsell()">add more drug</button></td>
<td><button class="btn btn-sm btn-info " ng-click="removesell('selldrug')">remove drug</button></td>
</tr>
</table>
</div>

</div>








<div align="center" style="margin-left:80px;margin-right:80px;margin-top:10px;border:2px solid green;" id="insert">

<div style="margin-top:5px;"><b>Date::</b> <input type="date" ng-model="dt" /></div>


   <table border="2px;" id="tb" >
   <tr>
   <th style="width:70;">pharmacy name</th>
   <th>index</th>
   <th>Catagory</th>
   <th>Name</th>
   <th>power/volume</th>
   <th>total unit</th>
   <th>unit price</th>
   <th>items per unit</th>
   <th>company</th>
    </tr>
 
   <tr ng-repeat="x in pharma.medicines">
   
   <td ng-if="$index==0"><input   type="text" ng-model="pharma.pharmacyname" /></td>
   <td ng-if="$index>0" style="border:none;"><input type="hidden" ng-model="pharma.pharmacyname" /></td>
   <td text-align="center;">{{$index+1}}</td>
   <td><select ng-options="c for c in type"  ng-model="x.type">
   </select></td>
   
   <td><input placeholder="name" ng-model="x.name" /></td>
   
   <td >
   
    <input style="width:70px;"  placeholder="power" ng-model="x.power" />
    <div ng-if="checkpow($index)=='ok'">
    <select ng-options="c for c in power" ng-model="k" ng-change="okchn($index,k);">
    </select>
  
   </div>
   
   </td> 
   

      
   
   
   <td ><input style="width:60px;" placeholder="total unit" ng-model="x.totalunit" /></td>   
   <td><input style="width:60px;" placeholder="total unit" ng-model="x.unitprice" /></td> 
   
   <td>
   <div ng-if="checktype($index)=='ok'">
    <input style="width:70px;" placeholder="(m*n)items" ng-model="x.dimension" />
   </div>
   <div ng-if="checktype($index)=='no'">
   ----
   </div>
  </td> 
    <td><select  ng-options="c for c in companies" ng-model="x.company"></select></td>  
   </tr>

   </table>
   
   <div style="margin-left:-30px;margin-top:20px;">
<table style="margin-top:10px;margin-bottom:15px;">

<td><button class="btn btn-sm btn-info" ng-click="submitinfo()">submit</button></td>
<td><button class="btn btn-sm btn-info" ng-click="add()">add more drug</button></td>
<td><button class="btn btn-sm btn-info " ng-click="remove()">remove drug</button></td>
<td><button class="btn btn-sm btn-info" ng-click="reset('pharma');">clear</button></td>
</tr>
</table>
</div>
</div>





<div id="records" align="center" style="margin-left:80px;margin-right:80px;margin-top:10px;background-color:antiquewhite;margin-bottom:20px;
border:2px solid black;">
<div class="row">
<div class="col-sm-2" style="background-color:skyblue;border:2px solid black;margin-left:16px;height:200px;margin-top:20px;">
<br/>
<button class="btn  btn-sm btn-default" ng-click="medirecord();">all drugs</button>
</div>
<div class="col-sm-2">

</div>

<div class="col" style="margin-right:100px;">
<br/>
<b>filter by name</b><input ng-model="search.name" type="text" ng-click="rem('name');" >
<b>filter by Catagory</b><input ng-model="search.type" type="text" ng-click="rem('type');" >
<b>filter by Company</b><input ng-model="search.company" type="text" ng-click="rem('company');" >

<table style="margin-top:20px;background-color:white;margin-bottom:30px;font-size:0.85em;" border="2">
<tr ng-repeat="x in allmedi">
<th ng-if="$index==0">index</th>
<th ng-if="$index==0">drug tye</th>
<th ng-if="$index==0">drug name</th>
<th ng-if="$index==0">power</th>
<th ng-if="$index==0">company</th>
<th ng-if="$index==0">total unit</th>
<th ng-if="$index==0">unitprice</th>
<th ng-if="$index==0">items per unit</th>
<th ng-if="$index==0">total price</th>
<th ng-if="$index==0">date</th>
<th ng-if="$index==0">edit</th>
</tr>
<tr ng-repeat="x in allmedi | filter : search">
<td><b>{{$index}}</b></td>
<td><b>{{x.type}}</b></td>
<td><b>{{x.name}}</b></td>
<td><b>{{x.power}}</b></td>
<td><b>{{x.company}}</b></td>
<td><b>{{x.totalunit}}</b></td>
<td><b>{{x.unitprice}}</b></td>
<td><b>{{x.dimension}}</b></td>
<td><b>{{x.totalprice}}</b></td>
<td><b>{{x.date}}</b></td>
<td><button ng-click="edit($index);">edit</button></td>
</tr>
</table>

</div>

</div>

</div>





<div  id="search" style="width:1120px;margin-left:80px;margin-top:10px;background-color:azure;border:2px solid black;">
<div class="row">
<div class="col-md-3" style="height:400px;border-right:2px solid black">
<div class="dropdown">
  <button class="btn btn-default dropdown-toggle" style="margin-top:7px;margin-left:10px;" data-toggle="dropdown" data-hover="dropdown">
   filter by<span class="caret"></span>
  </button>
  <ul class="dropdown-menu">
    <li><a href="#" onclick="appdiv('xname');"> search by name</a></li>
    <li><a href="#" onclick="appdiv('xcompany');">search by company</a></li>
    <li><a href="#" onclick="appdiv('xtype');">search by type</a></li>
   </ul>
</div>

 <button class="btn btn-default" style="margin-top:7px;margin-left:10px;" id="filtercondition" ng-click="allstock();"> All records</button>
 
</div>
 
<div id="mother" class="col-md-9">





 <div id="xname" style="display:none;">
 <span><b >enter drug name</b></span>
<input  style="margin-left:15px;margin-top:15px;"  ng-model="filterstock.name" ng-click="clearfilter('name')" /><br/>

<table style="background-color:white;margin-left:185px;font-size:0.85em;margin-top:10px;" border="2">
<tr ng-repeat="x in remainstock">
<th style="background:black;color:white;" ng-if="$index==0">index</th>
<th style="background:black;color:white;" ng-if="$index==0">drug tye</th>
<th style="color:green;" ng-if="$index==0">drug name</th>
<th style="background:black;color:white;" ng-if="$index==0">power</th>
<th style="background:black;color:white;" ng-if="$index==0">total unit</th>
<th style="background:black;color:white;" ng-if="$index==0">unit price</th>
<th style="background:black;color:white;" ng-if="$index==0">total price</th>
<th style="background:black;color:white;" ng-if="$index==0">items per unit</th>
<th style="background:black;color:white;" ng-if="$index==0">company</th>
</tr>

<tr ng-repeat="x in remainstock | filter : filterstock">
<td><b>{{$index}}</b></td>
<td><b>{{x.type}}</b></td>
<td style="color:green;"><b>{{x.name}}</b></td>
<td><b>{{x.power}}</b></td>
<td><b>{{x.remainunit}}</b></td>
<td><b>{{x.unitprice}}</b></td>
<td><b>{{x.totalprice}}</b></td>
<td><b>{{x.dimension}}</b></td>
<td><b>{{x.company}}</b></td>
</tr>
</table>  
</div>





<div id="xtype" style="display:none;">
 <span><b >enter drug Type</b></span>
<select ng-options="c for c in type"  style="margin-left:15px;margin-top:15px;"  ng-model="filterstock.type" ng-click="clearfilter('type');"  ></select>
<table style="background-color:white;margin-left:185px;font-size:0.85em;margin-top:10px;" border="2">
<tr ng-repeat="x in remainstock">
<th style="background:black;color:white;" ng-if="$index==0">index</th>
<th style="color:green;"ng-if="$index==0">drug tye</th>
<th style="background:black;color:white;" ng-if="$index==0">drug name</th>
<th style="background:black;color:white;" ng-if="$index==0">power</th>
<th style="background:black;color:white;" ng-if="$index==0">total unit</th>
<th style="background:black;color:white;" ng-if="$index==0">unit price</th>
<th style="background:black;color:white;" ng-if="$index==0">total price</th>
<th style="background:black;color:white;" ng-if="$index==0">items per unit</th>
<th style="background:black;color:white;" ng-if="$index==0">company</th>
</tr>

<tr ng-repeat="x in remainstock | filter : filterstock">
<td><b>{{$index}}</b></td>
<td style="color:green;"><b>{{x.type}}</b></td>
<td><b>{{x.name}}</b></td>
<td><b>{{x.power}}</b></td>

<td><b>{{x.remainunit}}</b></td>
<td><b>{{x.unitprice}}</b></td>
<td><b>{{x.totalprice}}</b></td>
<td><b>{{x.dimension}}</b></td>
<td><b>{{x.company}}</b></td>
</tr>
</table>  



</div>




<div id="xcompany" style="display:none;">
 <span><b >select company</b></span> 
<select ng-options="c for c in companies" style="margin-left:15px;margin-top:15px;"  ng-model="filterstock.company" ng-click="clearfilter('company');" ></select>
<table style="background-color:white;margin-left:185px;font-size:0.85em;margin-top:10px;" border="2">
<tr ng-repeat="x in remainstock">
<th style="background:black;color:white;" ng-if="$index==0">index</th>
<th style="background:black;color:white;" ng-if="$index==0">drug tye</th>
<th style="background:black;color:white;" ng-if="$index==0">drug name</th>
<th style="background:black;color:white;" ng-if="$index==0">power</th>
<th style="background:black;color:white;" ng-if="$index==0">total unit</th>
<th style="background:black;color:white;" ng-if="$index==0">unit price</th>
<th style="background:black;color:white;" ng-if="$index==0">total price</th>
<th style="background:black;color:white;" ng-if="$index==0">items per unit</th>
<th style="background:black;color:white;" style="color:green;"ng-if="$index==0">company</th>
</tr>

<tr ng-repeat="x in remainstock | filter : filterstock">
<td><b>{{$index}}</b></td>
<td><b>{{x.type}}</b></td>
<td><b>{{x.name}}</b></td>
<td><b>{{x.power}}</b></td>

<td><b>{{x.remainunit}}</b></td>
<td><b>{{x.unitprice}}</b></td>
<td><b>{{x.totalprice}}</b></td>
<td><b>{{x.dimension}}</b></td>
<td style="color:green;"><b>{{x.company}}</b></td>
</tr>
</table>  
</div> 
  
 
<table style="background-color:white;margin-left:185px;font-size:0.85em;margin-top:10px;" border="2">
<tr ng-repeat="x in remainstock">
<th  ng-if="$index==0">index</th>
<th ng-if="$index==0">drug tye</th>
<th ng-if="$index==0">drug name</th>
<th ng-if="$index==0">power</th>
<th ng-if="$index==0">total unit</th>
<th ng-if="$index==0">unit price</th>
<th ng-if="$index==0">total price</th>
<th ng-if="$index==0">items per unit</th>
<th ng-if="$index==0">company</th>
</tr>

<tr ng-repeat="x in remainstock">
<td><b>{{$index}}</b></td>
<td><b>{{x.type}}</b></td>
<td><b>{{x.name}}</b></td>
<td><b>{{x.power}}</b></td>

<td><b>{{x.remainunit}}</b></td>
<td><b>{{x.unitprice}}</b></td>
<td><b>{{x.totalprice}}</b></td>
<td><b>{{x.dimension}}</b></td>
<td><b>{{x.company}}</b></td>
</tr>
</table>  
 
 </div>
</div>


</div>














<button type="button" id="trigermedi" class="btn btn-info btn-sm" data-toggle="modal" style="display:none;" data-target="#btnmedi"></button>
 </div>
<!-- Modal -->
<div id="btnmedi" class="modal fade" role="dialog" >
  <div class="modal-dialog" style="border-radius:10px;width:400px;">
   <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="background-color:gray;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">close</h4>
      </div>
    <div class="modal-body">
     <table>
       <tr>
     <td><input  ng-model="rec.type" plcaeholder="catagory" /></td></tr>
     <tr><td><input   ng-model="rec.name" plcaeholder="name" /></td></tr>
      <tr><td><input  ng-model="rec.totalunit" plcaeholder="net unit" /></td></tr>
      <tr><td><b>(company)</b><select ng-model="rec.company" ng-options="c for c in companies"></select></td></tr>
      <tr><td><input  ng-model="rec.unitprice" plcaeholder="unit price" /></td></tr>
      <tr><td><input   ng-model="rec.totalprice" plcaeholder="total price" /></td></tr>
      <tr><td><input   ng-model="rec.dimension" plcaeholder="m*n items"/></td></tr>
      <tr><td><input  type="date" ng-model="rec.date" /></td></tr>
     
     </table>    
   </div>
    <div class="modal-footer" style="background-color:gray;">
    <button ng-click="updat(rec);" class="btn btn-default" >update</button>
   </div>
   </div>

 </div>
</div>

</body>
</html>