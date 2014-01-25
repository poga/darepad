app = angular.module \leve1up, [\angularLocalStorage]
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
  template: '<div class="ui huge checkbox"><input id="{{actionItemId}}" type="checkbox" ng-model="v" /><label for="{{actionItemId}}">{{label}}</label></div>'
  controller: ($scope, $rootScope) ->
    $rootScope.registerAction $scope.actionItemId

app.directive \progressBar ->
  restrict: \E
  template: """
  <div class="ui successful progress">
    <div class="bar" style="width:{{percentage}}%"></div>
  </div>
  """

app.controller \leve1upCtrl, ($rootScope, storage) !->
  storage.bind $rootScope, 'actions'
  $rootScope.actions ||= {}

  $rootScope.registerAction = (id) ->
    varName = id.replace "actions.", ""
    $rootScope.actions <<< { "#{varName}": void } if not $rootScope.actions[varName]

  $rootScope.$watch \actions ->
    max = 0
    completed = 0
    for k, v of $rootScope.actions
      max += 1
      completed += 1 if v and v != "" and v != false
    $rootScope.percentage = completed / max * 100
  , true
