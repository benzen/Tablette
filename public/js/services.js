'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('nodemovielist.services', []).
  value('version', '0.1').
  factory("$moviesStream", function(){
  	return new EventSource("/movies");
  });
