# telling the template whether a user is authorised
Template.Editor.helpers isEditorOrAdmin: ->
  Roles.userIsInRole Meteor.user(), ['admin', 'editor']

Template.Editor.events {
  # making the new article happen when the button is clicked
  'click #newArticle': ->
    # telling the server to create a new article
    Meteor.call "newArticle", (err, res)->
      # check for errors
      if err
        console.log err.reason
        alert err.message
      # go to the edit page for the new article
      Router.go('/edit/' + res)
  # making the remove happen when the button is clicked
  'click .remove': ->
    # making a popup and asking the user if they really want this
    if window.confirm 'Willst du den Artikel wirklich löschen?'
      # if so tell the db to remove the article
      Meteor.call 'removeArticle', $(event.target).data("id"), (err, res) ->
        # check if the is a error and if there is notify the user
        if err
          console.log err.reason
          alert err.message
        # if everything was successful go to the edit overview
        Router.go('editor')
}