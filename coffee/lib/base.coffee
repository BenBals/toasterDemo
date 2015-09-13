# getting the root so we can make global variables from coffeescript
root = exports ? this
root.root = root

# the collection that stores all the articles
root.Articles = new (Mongo.Collection)('articles')

# easier way to access lodash
_ = lodash

# preset for empty article
root.blankArticle = {
  text: ""
  title: ""
  imgSource: ""
  description: ""
  publishDate: Date.now()
}

root.parseUnixTimeToString = (n) ->
  date = new Date(n+3600)
  toTwoDigits = (n) ->
    if n < 10
      '0' + String(n)
    else String(n)
  return date.getUTCFullYear() + "-" + toTwoDigits(date.getUTCMonth() + 1) + "-" + date.getUTCDate()