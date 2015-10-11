# only show the articles that actully have all the needed data
Template.Home.helpers existingArticles: ->
  Articles.find {
    title: {$ne: ""}
    description: {$ne: ""}
    text: {$ne: ""}
    imgSource: {$ne: ""}
  }

Template.Home.events
  'click .searchButton': ->
    $('input#searchBox').toggle()

  'keyup #searchBox': (e) ->

    # get the query string
    query = $(e.target).val()

    # update the query on the session
    Session.set('searchQuery', query)

  'click .backButton': ->
    # go to the last page
    history.back()
