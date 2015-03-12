# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# initial example compile with http://js2.coffee/

listen = (el, event, handler) ->
  if el.addEventListener
    el.addEventListener event, handler
  else
    el.attachEvent 'on' + event, ->
      handler.call el

$ ->

  split = (val) ->
    val.split /,\s*/

  extractLast = (term) ->
    split(term).pop()

  $('#recipients').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).autocomplete('instance').menu.active
      event.preventDefault()
    return
  ).autocomplete
    source: (request, response) ->
      $.getJSON 'messages', { term: extractLast(request.term) }, response
      return
    search: ->
      # custom minLength
      term = extractLast(@value)
      if term.length < 2
        return false
      return
    focus: ->
      # prevent value inserted on focus
      false
    select: (event, ui) ->
      terms = split(@value)
      # remove the current input
      terms.pop()
      # add the selected item
      terms.push ui.item.value
      # add placeholder to get the comma-and-space at the end
      terms.push ''
      @value = terms.join(', ')
      false
  return
