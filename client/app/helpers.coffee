# Base class generated by Brunch
class exports.BrunchApplication
  constructor: ->
    $ =>
      @initialize this
      Backbone.history.start()

  initialize: ->
    null


# Select all content of an input field.
exports.selectAll = (input) ->
    input.setSelection(0, input.val().length)

# Change a string into its slug shape (only alphanumeric char and hyphens
# instead of spaces.
exports.slugify = require "./lib/slug"

# Transform a todolist path into its regular expression shape.
exports.getPathRegExp = (path) ->
    slashReg = new RegExp "/", "g"
    "^#{path.replace(slashReg, "\/")}"
