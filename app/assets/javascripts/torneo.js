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

torneoApp.controller('InscripcionController', function ($scope, $http){
    var inscripcionController = this;
    inscripcionController.inscribir = function() {
      var dataObj = {
          inscripcion: {
            torneo_id: $('#id_torneo').val(),            
          },
          hearthstone_form: {
              battletag: $scope.hearthstone_form.battletag
          },
          gamer: {
            correo: $scope.gamer.correo
          }
      };

      $http.post('/inscripciones.json',dataObj).success(function(data) {
          alert(data);
          //$scope.countries = data;
        }).error(function (data, status, headers, config) {
          alert("error");
        });
      //inscripcionController.todos.push({text:inscripcionController.todoText, done:false});
      //inscripcionController.todoText = '';
    };

});

    var contador = 1;
    function goBack() {
      window.history.back()
    } 
    function main(){
      $('#menu-icon').click(function(){
        if(contador == 1){ 
          $('nav').animate({
            left: '0'
          });
          contador = 0;
        } else {
          contador = 1;
          $('nav').animate({
            left: '-100%'
          });
        }
     
      });
     
    };
    $(document).ready(main);