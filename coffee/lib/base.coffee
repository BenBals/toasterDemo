# getting the root so we can make global variables from coffeescript
root = exports ? this

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
}