React = require 'react'
classnames = require 'classnames'

Reflux = require 'reflux'
favoritesStore = require '../stores/favorites-store'

module.exports = React.createClass
  displayName: 'FavoritesButton'
  mixins: [Reflux.connect(favoritesStore, 'favorited')]

  onClick: ->
    favoritesStore.toggleFavorite()

  render: ->
    disabledCondition = !@props.user?
    title = if disabledCondition
      "Sign in to add to favorites"
    else
      if @state.favorited then 'Unfavorite' else 'Favorite'

    favoriteBtnClasses = classnames
      'favorite-button': true
      favorited: @state.favorited is true

    <button ref="favoriteBtn" className={favoriteBtnClasses} type="button" title={title} onClick={@onClick} disabled={disabledCondition}>
      <i className="fa fa-heart#{unless @state.favorited then '-o' else ''} fa-2x"></i>
    </button>