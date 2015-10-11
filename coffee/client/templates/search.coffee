Template.Search.events {
  'keyup #searchBox': (e) ->

    # get the query string
    query = $(e.target).val()

    # update the query on the session
    Session.set('searchQuery', query)

  'click .backButton': ->
    # go to the last page
    history.back()
}

Template.Search.onRendered ->
  $('#searchBox').focus()
  $(document).scrollTop(0)
