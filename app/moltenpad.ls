app = angular.module \moltenpad, [\angularLocalStorage]
app.directive \textInput ->
  restrict: \E
  scope:
    v: \=for
    placeholder: \@
    actionItemId: \@for
  templateUrl: 'partials/checkbox.html'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \checkbox ->
  restrict: \E
  scope:
    v: \=for
    label: \@
    actionItemId: \@for
  templateUrl: 'partials/checkbox.html'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \progressBar ->
  restrict: \E
  templateUrl: 'partials/progress_bar.html'

app.controller \moltenCtrl, ($rootScope, storage) !->
  storage.bind $rootScope, 'actions'
  $rootScope.actions ||= {}

  $rootScope.registerAction = (id) ->
    varName = id.replace "actions.", ""
    $rootScope.actions <<< { "#{varName}": void } unless $rootScope.actions[varName]

  <- $rootScope.$watch \actions _, true
  completed = [k for k, v of $rootScope.actions when v and v != ""].length
  $rootScope.percentage = completed / Object.keys($rootScope.actions).length * 100
