# taking the raw data and inserting the needed brs and stuff
Template.Article.helpers processToHtml: (raw) ->
  processToHtml raw
Template.ArticleCard.helpers processToHtml: (raw) ->
  processToHtml raw

Template.Article.events {
  'click .backButton': ->
    # go to the last page
    history.back()

  'scroll': ->
    alert 'scrolled'
}

Template.Article.onCreated ->
  # scroll to the top on the new article
  $(document).scrollTop(0)