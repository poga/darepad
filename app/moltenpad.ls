app = angular.module \moltenpad, [\angularLocalStorage]
app.directive \textInput ->
  restrict: \E
  scope:
    v: \=for
    placeholder: \@
    actionItemId: \@for
  template: '<div class="ui large input"><input type="text" ng-model="v" placeholder="{{placeholder}}"/></input>'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \checkbox ->
  restrict: \E
  scope:
    v: \=for
    label: \@
    actionItemId: \@for
  template: '<div class="ui large checkbox"><input id="{{actionItemId}}" type="checkbox" ng-model="v" /><label for="{{actionItemId}}">{{label}}</label></div>'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \progressBar ->
  restrict: \E
  template: """
  <div class="ui successful progress">
    <div class="bar" style="width:{{percentage}}%"></div>
  </div>
  """

app.controller \moltenCtrl, ($rootScope, storage) !->
  storage.bind $rootScope, 'actions'
  $rootScope.actions ||= {}

  $rootScope.registerAction = (id) ->
    varName = id.replace "actions.", ""
    $rootScope.actions <<< { "#{varName}": void } if not $rootScope.actions[varName]

  $rootScope.$watch \actions ->
    completed = [k for k, v of $rootScope.actions when v and v != ""].length
    $rootScope.percentage = completed / Object.keys($rootScope.actions).length * 100
  , true
