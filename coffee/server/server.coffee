# stuff to only do on the server

# publish the articles
Meteor.publish 'articles', ->
  # all articles for admins or editors
  if Roles.userIsInRole this.userId, ['admin', 'editor']
    Articles.find {},
    {
      sort: {
        publishDate: -1
      }
    }
  # public articles for normal users
  else
    Articles.find {
      publishDate: {
        $lt: Date.now()
      },
      title: {$ne: ""}
      description: {$ne: ""}
      text: {$ne: ""}
      imgSource: {$ne: ""}
    },
    {
      sort: {
        publishDate: -1
      }
    }

# publish all userData to the admins and their own to all others
Meteor.publish 'userData', ->
  if Roles.userIsInRole this.userId, ['admin']
    return Meteor.users.find {}
  else
    return Meteor.users.find {_id: this.userId}