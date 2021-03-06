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
      $location.path( "/#/movies" );
    });
  }
};
AddMovieCtrl.$inject = ["$scope","$http", "$location", "$routeParams"];

function MoviesCtrl( $scope, $moviesStream ){
  $scope.movies=[];
  var movieListBuffer = [];
  var chunkSize = 50;

  $moviesStream.addEventListener("movie",function(e){
    var movie = JSON.parse( e.data );
    movieListBuffer.push(movie);
    if(movieListBuffer.length > chunkSize){
      flushBuffer();
    }
    
  },true);

  $moviesStream.addEventListener("end", function(){
    $moviesStream.close();
    flushBuffer();
  },true);

  $moviesStream.addEventListener("error", function(){
    $moviesStream.close();
  },true);

  var flushBuffer = function(){
    $scope.$apply(function(){
      movieListBuffer.forEach(function(movie){
        $scope.movies.push(movie);
      });
      movieListBuffer = [];
    });
  }

};
MoviesCtrl.$inject = [ "$scope", "$moviesStream" ];

function EditMovieCtrl($scope, $http, $routeParams, $location){
  $scope.locations=["dvd", "disque-dur"];
  $scope.movie=null;
  var url = "/movies/"+$routeParams.movie_id;
  $http.get( url ).success(function(movie){
    $scope.movie= movie   
  });

  $scope.updateMovie=function(){
    $http.put("/movies/"+$routeParams.movie_id, $scope.movie).success(function(){
      $location.path("/#/movies");
    });
  };

}
EditMovieCtrl.$inject = ["$scope","$http", "$routeParams", "$location"];