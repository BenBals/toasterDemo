Template.Search.helpers {
  # all articles that match the current query
  matchingArticles: Session.get('currentSearch')
}

Template.Search.onRendered ->
  Session.set('currentSearch', Articles.find({}))

Template.Search.events {
  'keydown #searchBox': (e) ->

    # get the query string
    query = $(e.target).val()
    
    # return all articles that match the query
    console.log Template.instance()
}