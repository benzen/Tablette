'use strict';

function SearchMovieCtrl($scope, $http){
  $scope.movieName="";
  $scope.searchMovieByName=function(){
    $http.get("/movie/search/"+$scope.movieName).
    success(function(movies){
      $scope.movies = movies;
    });
  };
};
SearchMovieCtrl.$inject = ["$scope","$http", "$location"];

function AddMovieCtrl( $scope, $http, $location, $routeParams ){
  
  $scope.locations=["dvd", "disque-dur"];
  $scope.movie = null;
  $http.get("/movie/"+$routeParams.movie_id).success(function(movie){
    $scope.movie = movie;
  })
  
  $scope.addToList=function(){
    var movie = $scope.movie;
    $http.post("/movies/new", $scope.movie).success(function(){
      $location.path( "#/movies#" + movie.name );
    });
  }
};
AddMovieCtrl.$inject = ["$scope","$http", "$location", "$routeParams"];

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