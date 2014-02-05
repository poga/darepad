CryptoJS = require 'crypto-js'

update-action = (scope, name, value) ->
  s = scope.$parent
  while s isnt void
    if s.hasOwnProperty \actions
      s.actions[name] = value
      break
    else
      s = s.$parent

app = angular.module \moltenpad, [\angularLocalStorage]
app.directive \mpTextInput ->
  restrict: \E
  scope:
    placeholder: \@
  templateUrl: 'partials/checkbox.html'
  controller: ($scope) ->
    $scope.actionId = CryptoJS.MD5($scope.placeholder).toString(CryptoJS.enc.Hex)
    update-action $scope.actionId, void
    $scope.$watch \v ->
      update-action $scope, $scope.actionId, it

app.directive \mpAction ->
  restrict: \E
  scope:
    label: \@
    link: \@
  templateUrl: 'partials/action.html'
  controller: ($scope) ->
    $scope.actionId = CryptoJS.MD5($scope.label).toString(CryptoJS.enc.Hex)
    update-action $scope.actionId, void
    $scope.$watch \v ->
      update-action $scope, $scope.actionId, it

app.directive \mpProgressBar ->
  restrict: \E
  templateUrl: 'partials/progress_bar.html'

app.controller \moltenCtrl, ($scope, storage) !->
  storage.bind $scope, 'actions'
  $scope.actions ||= {}

  $scope.registerAction = (id) ->
    varName = id.replace "actions.", ""
    $scope.actions <<< { "#{varName}": void } unless $scope.actions[varName]

  <- $scope.$watch \actions _, true
  completed = [k for k, v of $scope.actions when v and v != ""].length
  $scope.percentage = completed / Object.keys($scope.actions).length * 100
