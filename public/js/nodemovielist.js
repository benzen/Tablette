'use strict';


// Declare app level module which depends on filters, and services
angular.module('nodemovielist', [ 'nodemovielist.filters',
                                  'nodemovielist.services',
                                  'nodemovielist.directives' ]).
  config(['$routeProvider', '$locationProvider', function( $routeProvider, $locationProvider ) {
    $routeProvider.when( "/",{templateUrl:"/partials/home.html"});
    $routeProvider.when( "/movie/add",{templateUrl:"/partials/addMovie.html", controller:"NewMovieCtrl"});
    $routeProvider.when( "/movie/:movieName/edit", { templateUrl: "/partials/editMovie.html", controller: "EditMovieCtrl" } );
    $routeProvider.when( "/movies",{templateUrl:"/partials/movies.html", controller:"MoviesCtrl"});
    $routeProvider.otherwise( { redirectTo: '/' } );
    $locationProvider.html5Mode(true);
  }]);