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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>
<style>


table th{
background-color:black;
color:white;
}

table td{
background-color:skyblue;
}

</style>
<script>
var test="";
var c = 1;
$(document).ready(function(){
	
	$('input[type="checkbox"]').change(function() {
		  if ($(this).is(":checked")) {
			  if(c<2){
				  test=$(this).val();  
				  c=c+2;
			  }else{
				  
				  test=test+","+$(this).val();   
			  }
		 
		    return;
		  }
		});
	
})
var pr = ${pro};
var count;
var mod=angular.module("pressapp",[]);

mod.controller("presscon",function($scope,$http,$window){
	$scope.prescrip= pr;
	$scope.ages=["১ দিন","২দিন","৩দিন","৪দিন","৫দিন","৬দিন","৭দিন","৮দিন","১০দিন","১১দিন","১২দিন","১৫দিন","২০দিন","২২দিন","২৪দিন","২৫দিন","২৬দিন","২৭দিন","১মাস","৩৫দিন",
	"৪০দিন","১.৫মাস","২মাস","২.৫মাস","৩মাস","৫মাস","৬মাস","৭মাস","৮মাস","৯মাস","১০মাস","১১মাস","১বছর","২বছর","২.৫বছর","৩বছর","৩.৫বছর","৪বছর","৪.৫বছর",
	"৫বছর","৬বছর","৭বছর","৮বছর","৯বছর","১০বছর","১১বছর","১২বছর","১৩বছর","১৪বছর","১৫বছর","১৬বছর","১৭বছর","১৮বছর","১৯বছর","২০বছর","২১বছর","২২বছর","২৩বছর","২৪বছর","২৫বছর",
	"২৬বছর","২৭বছর","২৮বছর","২৯বছর","৩০বছর","৩১বছর","৩২বছর","৩৩বছর","৩৪বছর","৩৫বছর","৩৭বছর","৩৯বছর","৪১বছর","৪৩বছর","৪৫বছর",
	"৪৬বছর","৪৭বছর","৪৮বছর","৪৯বছর","৫০বছর","৫২বছর","৫৫বছর","৬০বছর","৬৩বছর","৬৪বছর",
	"৬৫বছর"
	]
	
	
$scope.tsokal=[];
$scope.tdupur=[];
$scope.trat=[];



$scope.numbers=["১","১.৫","পৌনে ২","২","২.৫","পৌনে ৩","৩","৩.৫","পৌনে ৪","৪","৫","৬"];
$scope.dose=["1/2 টি করে ২ বেলা","১টি করে ২ বেলা","দিনে ১ টি"];

$scope.injamount=["মিঃগ্রাঃ প্রতিবার","মিঃলিঃ প্রতিবার ","সেঃগ্রাঃ প্রতিবার"];
$scope.injnumber=[];
$scope.injunit=[];
$scope.futa=[];
$scope.bela=[];
$scope.drfuta=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
$scope.drbela=["1","2","2","3","4","5","6"];

$scope.inserttab=function(i){
	
$scope.prescrip.druglist[i].rules=$scope.tsokal[i]+"-"+$scope.tdupur[i]+"-"+$scope.trat[i];
	
                           }
                           
$scope.days=["--","চলবে","২ দিন","5দিন","7দিন","১০দিন","১২দিন","১৩দিন","১৫দিন","১৭দিন","২০দিন","২৫দিন","১মাস","৩৫দিন","৪০দিন","৪৫দিন","৫০দিন","২মাস","৩মাস","৪মাস","৫মাস"];

	
	
$scope.add=function(){
	
var arr = {
"drugtype":"","drugname":"","rules":"","days":"","consult":"","instruction":""
       
            };


}	
	
$scope.typeselect=function(i){
	
	if($scope.prescrip.druglist[i].drugtype=='ফাইল'){
		return 'ফাইল'
	}
	if($scope.prescrip.druglist[i].drugtype=='ইঞ্জেকশান'){
		return 'ইঞ্জেকশান'
	}
	if($scope.prescrip.druglist[i].drugtype=='ড্রপ'){
		return 'ড্রপ'
	}
	if($scope.prescrip.druglist[i].drugtype=='মলম'){
		return 'মলম'
	}
	if($scope.prescrip.druglist[i].drugtype=='ট্যাবলেট'){
		return 'ট্যাবলেট';
	}
if($scope.prescrip.druglist[i].drugtype=='সেলাইন'){
		return 'সেলাইন';
	}
	
	if($scope.prescrip.druglist[i].drugtype=='ডৌজ'){
		return 'ডৌজ';
	}
	
}

$scope.add=function(i){
var arr = {
		
"drugtype":"","drugname":"","rules":"","days":"","consult":"","instruction":""
}

if($scope.prescrip.druglist.length<15){

$scope.prescrip.druglist.splice(i,0,arr);

}

}
	
$scope.remove=function(i){
var length= $scope.prescrip.druglist.length;
if(length>2){
$scope.prescrip.druglist.splice(i, 1); 
   }

	}

$scope.medicines=[];
     $scope.res=function(i){
     count=i;
     var q = $scope.prescrip.druglist[i].drugname;
	$http({
			method:"POST",
			url:"${pageContext.request.contextPath}/pres/medilike" ,
			data: q,
			headers: {"Content-Type":"text/plain","responseType":"application/json"}}).
			then(function(response){
		
    $scope.medicines[i]=response.data; 
	                             
			         });  
			         
		}	         
 	$scope.sel=function(nam){
 		$scope.prescrip.druglist[count].drugname=nam;
 		$scope.medicines[count]=null;	
 		
           	}		
 	
 	$scope.insertinj=function(i){
 		
 		$scope.prescrip.druglist[i].rules=$scope.injnumber[i]+" "+$scope.injunit[i];	
 		alert($scope.prescrip.druglist[i].rules);
 			
 		}	
 	
 	$scope.insertdrop=function(i){
 		
 		$scope.prescrip.druglist[i].rules=$scope.futa[i]+"*"+$scope.bela[i];	
 		alert($scope.prescrip.druglist[i].rules);
 			
 		}		
 	
    $scope.sub=function(){
    	$scope.prescrip.test=test;
      $http({
   			method:"POST",
   			url:"${pageContext.request.contextPath}/pres/postpress" ,
   			data: angular.toJson($scope.prescrip),
   			headers: {"Content-Type":"application/json"}}).
   			then(function(response){
   				alert("successfully posted the prescription")
   				$window.location.reload();
        
   			});  
   			         
   		}		
		         

})
</script>

</head>

<body ng-app="pressapp" ng-controller="presscon">
<input type="hidden" name="x" value="${dr.name}"/>

<div class="container" id="givep" style="display:block;border:1px solid black;margin:50px;margin-top:20px;" align="center">

<table style="font-size:0.75em;margin-left:70px;width:600px;margin-top:15px" border="1">
<th>রোগীর নাম</th> 
<th>রোগীর বয়স</th>
<th>সেক্স</th>
<th>উপদেশ</th>
<th>তারিখ</th>
<tr>
<td><input type="text" ng-model="prescrip.name"/></td>
<td> <input type="text" style="width:100px;" ng-model="prescrip.age" />
</td>
<td><select  ng-model="prescrip.sex">
<option value="পুরুষ">পুরুষ</option>
<option value="মহিলা">মহিলা</option> 
<option value="৩য় লিংগ">৩য় লিংগ</option>
</select></td>
<td><textarea   style="font-size:0.85em;"  cols="20" rows="3" ng-model="prescrip.advice"></textarea></td>
<td><input type="date" ng-model="prescrip.date"/></td>
</tr>
</table>
 
<div style="font-size:0.75em;margin-top:15px;"> 
<input type="checkbox" value="রক্ত পরিক্ষা"><b>রক্ত পরিক্ষা</b></input>
<input type="checkbox" value="মূত্র পরিক্ষা"><b>মূত্র পরিক্ষা</b></input>
<input type="checkbox" value="এক্সরে পরিক্ষা"><b>এক্সরে পরিক্ষা</b></input>
<input type="checkbox" value="ঈসিজি পরিক্ষা"><b>ঈসিজি পরিক্ষা</b></input>
<input type="checkbox" value="লিভার  পরিক্ষা"><b>লিভার  পরিক্ষা</b></input>
<input type="checkbox" value="হরমোন পরিক্ষা"><b>হরমোন পরিক্ষা</b></input>
<input type="checkbox" value="pregnency পরিক্ষা"><b>pregnency পরিক্ষা</b></input> 
<input type="checkbox" value="সিমেন পরিক্ষা"><b>সিমেন পরিক্ষা</b></input>
<input type="checkbox" value="উল্ট্রসনোপরিক্ষা পরিক্ষা"><b>উল্ট্রসনোপরিক্ষা পরিক্ষা</b></input>
<input type="checkbox" value="প্রয়োজন নাই "><b>প্রয়োজন নাই</b></input>
</div>



<table style="font-size:0.78em;margin-left:30px;margin-top:15px;width:500px;" border="1" >

<tr>
<th>ঔষধের ধরণ    </th>
<th>ঔষধের নাম</th>
<th>নিয়ম</th>
<th>সময়কাল</th>
<th>শর্ত</th>
<th>বাড়তি নির্দেশনা</th>
<th>যোগ করুন</th>
<th>মুছুন</th>
</tr>


<tr ng-repeat="p in prescrip.druglist">


<td><select   ng-model="p.drugtype" >
<option value="ফাইল">ফাইল</option> 
<option value="ট্যাবলেট">ট্যাবলেট</option> 
<option value="ইঞ্জেকশান">ইঞ্জেকশান</option> 
<option value="ডৌজ">ডৌজ</option>
<option value="সেলাইন">সেলাইন</option> 
<option value="মলম">মলম</option> 
<option value="ড্রপ">ড্রপ</option> 
</select></td>

<td ><input  style="width:100px;" ng-model="p.drugname" ng-keyup="res($index)"/>
<ul ng-repeat="z  in medicines[$index]" >
<p ng-click="sel(z.name);" style="color:green;">{{z.name}}</p>
</ul>

</td>
<td>
<div ng-if="typeselect($index)=='ড্রপ'">
<b>ফোটা</b><select ng-options="c for c in drfuta" ng-model="futa[$index]"></select>
<b>বেলা</b><select ng-options="c for c in drbela" ng-model="bela[$index]" ng-change="insertdrop($index);"></select>
</div>
<div ng-if="typeselect($index)=='ট্যাবলেট'" style="font-size:0.7em;" >
<b>সকাল</b><select  ng-options="n for n in numbers" ng-model="tsokal[$index]" ng-change="inserttab($index);"></select> 
<b>দুপুর</b><select  ng-options="n for n in numbers" ng-model="tdupur[$index]" ng-change="inserttab($index);"></select> 
<b>রাত</b><select  ng-options="n for n in numbers" ng-model="trat[$index]" ng-change="inserttab($index);"></select>
</div>
<div ng-if="typeselect($index)=='ফাইল'" style="font-size:0.7em;" >
<b>সকাল</b><select  ng-options="n for n in numbers" ng-model="tsokal[$index]" ng-change="inserttab($index);"></select> 
<b>দুপুর</b><select  ng-options="n for n in numbers" ng-model="tdupur[$index]" ng-change="inserttab($index);"></select> 
<b>রাত</b><select  ng-options="n for n in numbers" ng-model="trat[$index]" ng-change="inserttab($index);"></select>
</div>

<div ng-if="typeselect($index)=='ডৌজ'" style="font-size:0.7em;"><select  ng-options="d for d in dose" ng-model="p.rules">
</select>
</div>
<div ng-if="typeselect($index)=='সেলাইন'" style="font-size:0.7em;"><select  ng-model="p.rules">
<option value="--">---</option>
<option value="পরিমান মত">পরিমান  মতো</option>
</select>
</div>
<div ng-if="typeselect($index)=='ইঞ্জেকশান'" style="font-size:0.7em;">
<input type="text" placeholder="amount" ng-model="injnumber[$index]"/> 
<select  ng-options="a for a in  injamount" ng-model="injunit[$index]" ng-change="insertinj($index);">
</select>
</div>
<div ng-if="typeselect($index)=='মলম'" style="font-size:0.7em;"><select  ng-model="p.rules">
<option value="---">---</option>
<option value="পরিমাম মতো "> পরিমাম মতো </option>
</select>
</div>
 </td>
<td><select ng-options="c for c in days" ng-model="p.days">

</select></td>
<td><select ng-model="p.consult">
<option value="---">---</option> 
<option value="খাওয়ার পরে">জেকুন সময় </option> 
<option value="খাওয়ার পরে ">খাওয়ার পরে</option> 
<option value="খাওয়ার  ১ ঘণ্টা পরে">খাওয়ার  ১ ঘণ্টা পরে</option>
<option value="খাওয়ার  ২ ঘণ্টা পরে">খাওয়ার  ২ ঘণ্টা পরে</option>
<option value="খাওয়ার  আগে">খাওয়ার  আগে</option>  
<option value="খাওয়ার  ১ ঘণ্টা  আগে">খাওয়ার  ১ ঘণ্টা  আগে</option>
<option value="খাওয়ার  ২ ঘণ্টা  আগে">খাওয়ার  ২ ঘণ্টা  আগে</option>
<option value="৪ ঘণ্টা পর পর">৪ ঘণ্টা পর পর</option> 
<option value="৬  ঘণ্টা পর পর">৬  ঘণ্টা পর পর</option>
<option value="৬  ঘণ্টা পর পর">  ৮ ঘণ্টা পর পর</option>
<option value="৬  ঘণ্টা পর পর">  ১০ঘণ্টা পর পর</option>     
<option value="১২ ঘণ্টা পর পর">১২ ঘণ্টা পর পর</option> 
<option value="১২ ঘণ্টা পর পর">১৮ ঘণ্টা পর পর</option> 
<option value="দিনে  ২ বার ইঞ্জেকশান">প্রতিদিন</option>
<option value="প্রতি ১ দিন বাদে">প্রতি ১ দিন বাদে</option> 
<option value="প্রতি ২ দিন বাদে">প্রতি ২ দিন বাদে</option>
<option value="প্রতি ২ দিন বাদে">প্রতি ৩দিন বাদে</option>

</select></td>
<td ><textarea style="font-size:0.75em;" columns="20" rows="3" ng-model="p.instruction"></textarea></td>
<td ng-click="add($index);" ><i class="fa fa-plus" style="font-size:18px;"></i></td>
<td ng-click="remove($index);" ><i class="fa fa-trash-o" style="font-size:18px;"></i></td>
</tr>

</table>

<div  align="center" style="margin-bottom:15px;margin-top:15px">
<button style="width:150px;" class="btn btn-success btn-sm" ng-click="sub();">submit</button>
</div>
</div>
<div id="out" style="display:none;">

</div>

</body>

</html>