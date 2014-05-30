CryptoJS = require 'crypto-js'

angular.module \DPDirectives []
.directive \dpTextInput ->
  restrict: \E
  scope: true
  templateUrl: 'partials/checkbox.html'
  controller: ($scope, $attrs) ->
    $scope{placeholder} = $attrs
    $scope.actionId = CryptoJS.MD5($scope.placeholder).toString(CryptoJS.enc.Hex)
    $scope.register $scope.actionId, ""

.directive \dpAction ->
  restrict: \E
  scope: true
  templateUrl: 'partials/action.html'
  controller: ($scope, $window, $attrs) ->
    $scope{label, link, popup} = $attrs
    $scope.actionId = CryptoJS.MD5($scope.label).toString(CryptoJS.enc.Hex)
    $scope.register $scope.actionId, false

    $scope.open = (link) ->
      $window.open link, \_blank, 'menubar=no,toolbar=no,location=no,directories=no,status=no'
      true

.directive \dpProgressBar ->
  restrict: \E
  templateUrl: 'partials/progress_bar.html'

.directive \dpReset ->
  restrict: \E
  templateUrl: 'partials/reset.html'
  controller: ($scope, $attrs) ->
    $scope{label} = $attrs

app = angular.module \darepad, [\angularLocalStorage, \DPDirectives]
app.controller \darepadCtrl, ($scope, storage) !->
  storage.bind $scope, 'actions'
  $scope.actions ||= {}

  $scope.register = (id, default-value) ->
    $scope.actions[id] = default-value if $scope.actions[id] == void

  $scope.reset = ->
    for k, v of $scope.actions
      $scope.actions[k] = void

  <- $scope.$watch \actions, _, true
  completed = [k for k, v of $scope.actions when v and v != ""].length
  #console.log completed, Object.keys($scope.actions)
  $scope.percentage = completed / Object.keys($scope.actions).length * 100
  #console.log $scope.percentage
