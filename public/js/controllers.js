'use strict';

function NewMovieCtrl( $scope, $http ){
  $scope.movieName="";
  $scope.searchMovieByName=function(){
    $http.get("/getMovie/"+$scope.movieName).
    success(function(movie){
    	$scope.movie = movie;
    })
  }
};
NewMovieCtrl.$inject = ["$scope","$http"];

function MoviesCtrl( $scope, $http ){
  $scope.movies;
  $http.get("/movies/").
   success(function( movies ){
    	$scope.movies = movies;
   });
};
MoviesCtrl.$inject = ["$scope","$http"];
