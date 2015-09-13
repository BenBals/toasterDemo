# the home or index or what ever you want to call it
Router.route '/', ->
  this.render('Home')

# go to the article with the given id
Router.route '/article/:_id', ->
  this.render 'Article', {
    data: ->
      Articles.findOne({_id: this.params._id})
  }

# open the editor
Router.route 'editor', ->
  this.render 'Editor', {
    data: ->
      {
        articles: Articles.find()
      }
  }

# go to the edit page for the given article
Router.route 'edit/:_id', ->
  # redirecting the user to the editor/login page when they are not authorised
  if Roles.userIsInRole Meteor.user(), ['admin', 'editor']
    this.render 'Edit', {
      data: ->
        Articles.findOne({_id: this.params._id})
    }
  else
    this.redirect('editor')

# mangage users route
Router.route 'manageUsers', ->
  this.render 'ManageUsers'
