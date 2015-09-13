# code that only runs on the client side

# making the articles avalible form the dev tools console
window.Articles = Articles

# getting the published articles
Meteor.subscribe 'publishedArticles'

# only show the articles that actully have all the needed data
Template.Home.helpers existingArticles: ->
  Articles.find {
    title: {$ne: ""}
    description: {$ne: ""}
    text: {$ne: ""}
    imgSource: {$ne: ""}
  }

# taking the raw data and inserting the needed brs and stuff
Template.Article.helpers processToHtml: (raw) ->
  if raw
    raw.split('\n').join('<br>').split('<script>').join('').split('</script>').join('')
  else raw

# telling the template whether a user is authorised
Template.Editor.helpers isEditorOrAdmin: ->
  Roles.userIsInRole Meteor.user(), ['adimn', 'editor']

Template.Edit.events({
  # making the save happen when the button is clicked
  'click .save': ->
    # getting all the data from the dom and creating a obj for mongo
    obj = {
      $set: {
        title: $('#title').val(),
        description: $('#description').val(),
        imgSource: $('#imgSource').val(),
        text: $('#text').val()
      }
    }

    # checking if all fields have content
    if obj.$set.title == "" or obj.$set.description == "" or obj.$set.imgSource == "" or obj.$set.text == ""
      alert("Du musst alle Felder ausfüllen!")
      return

    # if everything is right push the data to the db
    Meteor.call 'updateArticle', this._id, obj

  # making the remove happen when the button is clicked
  'click .remove': ->
    # making a popup and asking the user if they really want this
    if window.confirm 'Willst du den Artikel wirklich löschen?'
      # if so tell the db to remove the article
      Meteor.call 'removeArticle', this._id, (err, res) ->
        # check if the is a error and if there is notify the user
        if err
          console.log err.reason
          alert err.message
        # if everything was successful go to the edit overview
        Router.go('editor')
})

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
}

Template.Article.events {
  'click .backButton': ->
    # go to the last page
    history.back()
}

Template.Article.onCreated ->
  # scroll to the top on the new article
  $(document).scrollTop(0)