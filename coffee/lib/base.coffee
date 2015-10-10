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

# utils
root.utils = {
  # generating 'or lists' for the search
  generateSearchFindObj: (str) ->
    orList = _.map str.split(' '), (n) ->
      {
        title: root.utils.generateSearchRegex n
      }

    return {
      $or: orList
    }
  # generate the search regex
  generateSearchRegex: (str) ->
    new RegExp str, 'i'

  # search the articles for query
  search: (query) ->
    if query == undefined
      return Articles.find()
    Articles.find root.utils.generateSearchFindObj(query)
  # managing localStorage
  loadLocalStorage: (id) ->
    JSON.parse localStorage[id]
  saveLocalStorage: (id, obj) ->
    localStorage[id] = JSON.stringify obj
  removeFromLocalStorage: (id) ->
    localStorage.removeItem id
}