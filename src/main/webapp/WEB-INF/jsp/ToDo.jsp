<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <title> ToDo List</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
  </head>
  <body class="bg-dark" ng-app="myApp" ng-controller="todoCtrl">
    <div class="container">
    <!-- Header -->
      <div class="row">
        <div class="col-md-12 mx-auto">
         <div class="mt-5 p-4 card bg-primary text-white">
            <h3>To Do List</h3>
            
            <div class="row mx-auto"> 
            <div class="col-md-8">
            	<input type="text" id="textValue" class="form-control " ng-model="todoInput" />
            </div>
            <div class="col-md-4">
            	<input type="submit" value="Add New" class="form-control" ng-click="todoAdd()" >
            </div>
            
            </div> 
          </div> 
        </div>
      </div>
       <!-- Body -->
      <div class="row mt-1">
        <div class="col-md-12 mx-auto">
           <div class="row mx-auto">
           
            <!-- Left -->
            <div class="col-md-6 card bg-primary text-white ">
            <div  class="card-body">
              <h5 class="card-title">Pending<span class="badge badge-pill bg-dark align-text-bottom">{{todoListPending.length}}</span></h5>
              <div ng-repeat="x in todoListPending" class="pl-4">
    			<input type="checkbox" ng-model="x.done"> 
    			<span ng-bind="x.todoText" ></span>
			  </div>
            </div>
				<div class="row card-footer">
				<button ng-click="remove()" class="form-control col-md-5 mr-1">Remove</button>
				<button ng-click="complete()" class="form-control col-md-5 ">Complete</button>
				</div>
            </div>
            
             <!-- Right -->
            <div class="col-md-6 card bg-primary text-white">
             <div  class="card-body">
              <h5 class="card-title">Completed<span class="badge badge-pill bg-dark align-text-bottom">{{todoListCompleted.length}}</span></h5>
              <div ng-repeat="x in todoListCompleted" class="pl-4">
    			<span ng-bind="x.todoText" ></span>
			  </div>
               
            </div>
            </div>
            </div>
        </div>
      </div>
    </div>
    <script>
 
     
    
    
    
    var app = angular.module('myApp', []); 
    app.controller('todoCtrl', function($scope,$http) {
    	//get From DB and store
        getAllTasks();
    	
        $scope.todoAdd = function() {
        	if($scope.todoInput!=""){
        		var newtask={todoText:$scope.todoInput, done:false};
        		createNewtask(newtask);
	            $scope.todoInput = "";
	            //save to back end
        	}
        };

        $scope.remove = function() {
            var oldList = $scope.todoListPending;
            var toDelete=oldList.filter(checkDone);
            $scope.todoListPending = oldList.filter(checkNotDone);
            if(toDelete.length!=0)
            	deleteSelected(toDelete);
                 
             
        };
        
        $scope.complete = function() {
        	var oldList = $scope.todoListPending;
            $scope.todoListCompleted = $scope.todoListCompleted.concat(oldList.filter(checkDone));
            $scope.todoListPending = oldList.filter(checkNotDone);
            var justCompleted=oldList.filter(checkDone);
            if(justCompleted.length!=0)
            	updateCompleted(justCompleted);
        };
        
        
        function checkDone(list) {
            return list.done;
        }
        function checkNotDone(list) {
            return !(list.done);
        }
        
        
        function getAllTasks(){
        	 $http({
        	        method : "GET",
        	        url : "fromDb",
        	        headers: {'Accept': 'application/json'}
        	    }).then(function mySuccess(response) {
        	    	//console.log(response.data) ;
        	    	 $scope.todoListCompleted = response.data.filter(checkDone);
        	         $scope.todoListPending = response.data.filter(checkNotDone);
        	         
        	         console.log($scope.todoListCompleted);
        	         console.log($scope.todoListPending);
        	    }, function myError(response) {
        	    	console.log(response.statusText) ;
        	    });
             
          }
        
        function createNewtask(newtask){
       	 $http({
       	        method : "POST",
       	        url : "fromDb",
       	        data:newtask,
       	        headers: {'Content-Type': 'application/json'}
       	    }).then(function mySuccess(response) {
       	    	//console.log(response.data) ;
       	    	 $scope.todoListPending.push(response.data);
       	    }, function myError(response) {
       	    	console.log(response.statusText) ;
       	    });
            
         }
        
        function updateCompleted(completed){
          	 $http({
          	        method : "PUT",
          	        url : "fromDb",
          	        data:completed,
          	        headers: {'Content-Type': 'application/json'}
          	    }).then(function mySuccess(response) {
          	    	console.log(response.statusText) ;
          	    }, function myError(response) {
          	    	console.log(response.statusText) ;
          	    });
               
            }
        
        function deleteSelected(selected){
         	 $http({
         	        method : "DELETE",
         	        url : "fromDb",
         	        data:selected,
         	        headers: {'Content-Type': 'application/json'}
         	    }).then(function mySuccess(response) {
         	    	console.log(response.statusText) ;
         	    }, function myError(response) {
         	    	console.log(response.statusText) ;
         	    });
              
           }
         
    });
    </script>
  </body>
</html>