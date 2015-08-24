Reflux = require 'reflux'

appActions = require '../actions/app-actions'

module.exports = Reflux.createStore
  listenables: appActions

  onRouteChange: (routerState) ->
    # Fires whenever the route changes. Might be useful?
