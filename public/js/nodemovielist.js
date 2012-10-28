'use strict';


// Declare app level module which depends on filters, and services
angular.module('nodemovielist', [ 'nodemovielist.filters',
                                  'nodemovielist.services',
                                  'nodemovielist.directives' ]).
  config(['$routeProvider', '$locationProvider', function( $routeProvider, $locationProvider ) {
    $routeProvider.when( "/",{templateUrl:"/partials/home.html"});
    $routeProvider.when( "/movie/search",{templateUrl:"/partials/searchMovie.html", controller:"SearchMovieCtrl"});
    $routeProvider.when( "/movie/add/:movie_id",{templateUrl:"/partials/addMovie.html", controller:"AddMovieCtrl"});
    $routeProvider.when( "/movie/:movie_id/edit", { templateUrl: "/partials/editMovie.html", controller: "EditMovieCtrl" } );
    $routeProvider.when( "/movies",{templateUrl:"/partials/movies.html", controller:"MoviesCtrl"});
    $routeProvider.otherwise( { redirectTo: '/' } );
  }]);