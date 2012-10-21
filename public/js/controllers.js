'use strict';

function NewMovieCtrl( $scope, $http, $location ){
  $scope.movieName="";
  $scope.locations=["dvd", "disque-dur"];
  $scope.movie = null;
  $scope.searchMovieByName=function(){
    $http.get("/movie/search/"+$scope.movieName).
    success(function(movie){
      $scope.movie = movie;
    });
  };
  $scope.addToList=function(){
    var movie = $scope.movie;
    $http.post("/movies/new", $scope.movie).success(function(){
      $location.path( "/movies#" + movie.name );
    });
  }
};
NewMovieCtrl.$inject = ["$scope","$http", "$location"];

function MoviesCtrl( $scope, $http ){
  $scope.movies;
  $http.get("/movies/").
  success(function( movies ){
      $scope.movies = movies;
  });
};
MoviesCtrl.$inject = ["$scope","$http"];

function EditMovieCtrl($scope, $http, $routeParams, $location){
  $scope.locations=["dvd", "disque-dur"];
  $scope.movie={};
  var url = "/movie/"+$routeParams.movieName;
  $http.get( url ).success(function(movie){
    $scope.movie= movie   
  });

  $scope.updateMovie=function(){
    $http.put("/movies/update", $scope.movie).success(function(){
      $location.path("/movies#"+$routeParams.movieName);
    });
  };

}
EditMovieCtrl.$inject = ["$scope","$http", "$routeParams", "$location"];