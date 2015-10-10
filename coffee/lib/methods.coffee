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

  # method for setting users roles
  setRoles: (obj) ->
    # check for admin permissions
    if Roles.userIsInRole this.userId, ['admin']
      # loop over the obj
      for id, settings of obj
        # parse settings into a role readable format
        rs = []
        if settings.admin then rs.push('admin')
        if settings.editor then rs.push('editor')

        # set the role
        Roles.setUserRoles id, rs
    else
      # if the user is not authorised raise an error
      Meteor.call('notAuthorisedError')

  # convinient error method
  notAuthorisedError : ->
    throw new Meteor.Error("not-authorized");
}