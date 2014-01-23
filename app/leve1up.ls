app = angular.module \leve1up, []
app.directive \textInput ($rootScope) ->
  return
    restrict: \E
    replace: true
    scope:
      v: \=for
      placeholder: \@
    template: '<div class="ui large input"><input type="text" ng-model="v" placeholder="{{placeholder}}"/></input>'
    link: (scope, elm, attrs) ->
      scope.completed = false
      $rootScope.maxProgress += 1
      $(elm).children(\input).on "change paste keyup", ->
        if $(this).val! != "" and not scope.completed
          $rootScope.$apply -> $rootScope.progress += 1
          scope.completed = true
        else if $(this).val! == ""
          $rootScope.$apply -> $rootScope.progress -= 1
          scope.completed = false

app.directive \checkbox ($rootScope) ->
  return
    restrict: \E
    replace: true
    scope:
      v: \=for
      label: \@
      id: \@for
    template: '<div class="ui huge checkbox"><input id="{{id}}" type="checkbox" ng-model="v" /><label for="{{id}}">{{label}}</label></div>'
    link: (scope, elm, attrs) ->
      $rootScope.maxProgress += 1
      elm.change ->
        if $(it.target).prop \checked
          $rootScope.progress += 1
        else
          $rootScope.progress -= 1

app.directive \progressBar ->
  return
    restrict: \E
    replace: true
    scope: true
    template: """
    <div class="ui successful progress">
      <div class="bar" style="width:{{percentage}}%"></div>
    </div>
    """

leve1upCtrl = ($rootScope) !->
  $rootScope.progress = 0
  $rootScope.maxProgress = 0

  $rootScope.$watch \progress ->
    $rootScope.percentage = $rootScope.progress / $rootScope.maxProgress * 100
