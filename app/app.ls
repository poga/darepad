CryptoJS = require 'crypto-js'

angular.module \MPDirectives []
.directive \mpTextInput ->
  restrict: \E
  scope: true
  templateUrl: 'partials/checkbox.html'
  controller: ($scope, $attrs) ->
    $scope{placeholder} = $attrs
    $scope.actionId = CryptoJS.MD5($scope.placeholder).toString(CryptoJS.enc.Hex)
    $scope.actions[$scope.actionId] = false if $scope.actions[$scope.actionId] == void

.directive \mpAction ->
  restrict: \E
  scope: true
  templateUrl: 'partials/action.html'
  controller: ($scope, $attrs) ->
    $scope{label, link} = $attrs
    $scope.actionId = CryptoJS.MD5($scope.label).toString(CryptoJS.enc.Hex)
    $scope.actions[$scope.actionId] = false if $scope.actions[$scope.actionId] == void

.directive \mpProgressBar ->
  restrict: \E
  templateUrl: 'partials/progress_bar.html'

app = angular.module \moltenpad, [\angularLocalStorage, \MPDirectives]
app.controller \moltenCtrl, ($scope, storage) !->
  storage.bind $scope, 'actions'
  $scope.actions ||= {}

  <- $scope.$watch \actions, _, true
  completed = [k for k, v of $scope.actions when v and v != ""].length
  console.log completed, Object.keys($scope.actions)
  $scope.percentage = completed / Object.keys($scope.actions).length * 100
  console.log $scope.percentage
