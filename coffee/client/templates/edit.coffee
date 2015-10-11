Template.Edit.helpers {
  blub: (n) ->
    date = new Date(n+3600)
    toTwoDigits = (n) ->
      if n < 10
        '0' + String(n)
      else String(n)
    return date.getUTCFullYear() + "-" + toTwoDigits(date.getUTCMonth() + 1) + "-" + date.getUTCDate()
}

Template.Edit.events {
  # making the save happen when the button is clicked
  'click .save': ->
    # check for date
    if !$('#publishDate')[0].validity.valid
      $('#publishDate').val parseUnixTimeToString(Date.parse(parseUnixTimeToString(Date.now())))

    # getting all the data from the dom and creating a obj for mongo
    obj = {
      $set: {
        title: $('#title').val(),
        description: $('#description').val(),
        imgSource: $('#imgSource').val(),
        text: $('#text').val(),
        publishDate: Date.parse($('#publishDate').val())
      }
    }

    # checking if all fields have content
    if obj.$set.title == "" or obj.$set.description == "" or obj.$set.imgSource == "" or obj.$set.text == ""
      alert "Du musst alle Felder ausfüllen!"
      return

    # if everything is right push the data to the db
    Meteor.call 'updateArticle', this._id, obj

    # removing the saved state from local storage
    root.utils.removeFromLocalStorage 'text_' + this._id

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

      # removing the saved state from local storage
      root.utils.removeFromLocalStorage 'text_' + this._id

  'keyup #text': (e) ->
    newVal = $(e.target).val()
    oldVal = this.text
    if oldVal != newVal
      root.utils.saveLocalStorage 'text_' + this._id, newVal
    else
      root.utils.removeFromLocalStorage 'text_' + this._id

  'focus #text': ->
  # asking to recover stuff if there is stuff to recover
    if !Session.get 'notFirstTyping_' + this._id
      Session.set 'notFirstTyping_' + this._id, true
      savedText = root.utils.loadLocalStorage 'text_' + this._id
      if savedText
        if window.confirm 'Du hast ungespeicherte Vortschritte vom letzten Mal. Willst du sie laden.'
          $('#text').val(savedText)

}