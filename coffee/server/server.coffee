# stuff to only do on the server

# publish the public articles
Meteor.publish 'publishedArticles', ->
  Articles.find()

# publish all articles if the user is authorised
if Roles.userIsInRole this.userId, ['admin', 'editor']
  Meteor.publish 'articles', ->
    Articles.find()