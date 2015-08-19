React = require 'react'
classnames = require 'classnames'

Reflux = require 'reflux'
favoritesStore = require '../stores/favorites-store'

module.exports = React.createClass
  displayName: 'FavoritesButton'
  mixins: [Reflux.connect(favoritesStore, 'favorites')]

  getInitialState: ->
    favorited: favoritesStore.favorited

  onClick: ->
    @setState({favorited: !@state.favorited}, ->
      favoritesStore.toggleFavorite()
    )

  render: ->
    disabledCondition = if @props.user? then false else true
    favoriteBtnClasses = classnames
      'favorite-button': true
      favorited: @state.favorited is true

    <button ref="favoriteBtn" className={favoriteBtnClasses} type="button" onClick={@onClick} disabled={disabledCondition}>
      <i className="fa fa-heart#{unless @state.favorited then '-o' else ''} fa-2x"></i>
    </button>