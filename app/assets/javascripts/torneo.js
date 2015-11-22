var torneoApp = angular.module('torneoApp', []);

torneoApp.controller('TorneoController', function ($scope, $http){

  $http.get('ultimo_torneo_finalizado.json').success(function(data) {
    $scope.ultimo_torneo_finalizado = data.detail;
    $scope.inscripciones = data.inscripciones;
    $scope.minimalData = {
        teams : data.teams,
        results: data.results
      }
  });

  $http.get('ultimo_torneo_creado.json').success(function(data) {
    $scope.ultimo_torneo_creado = data;
  });

});


