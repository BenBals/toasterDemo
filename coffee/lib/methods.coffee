# defining the methods
Meteor.methods {
  # update the article with the mongo obj and id form the user
  updateArticle: (id, obj) ->
    # security check
    if Roles.userIsInRole Meteor.user(), ['admin', 'editor']
      Articles.update(id, obj)
    else
      Meteor.call('notAuthorisedError')
  # creating a new article from a blank preset
  newArticle: ->
    # staff only
    if Roles.userIsInRole Meteor.user(), ['admin', 'editor']
        id = Articles.insert(blankArticle)
        return id
    else
      Meteor.call('notAuthorisedError')
  # remove the given article
  removeArticle: (id) ->
    # vip
    if Roles.userIsInRole Meteor.user(), ['admin', 'editor']
      id = Articles.remove(id)
      return id
    else
      Meteor.call('notAuthorisedError')
  # convinient error method
  notAuthorisedError : ->
    throw new Meteor.Error("not-authorized");
}