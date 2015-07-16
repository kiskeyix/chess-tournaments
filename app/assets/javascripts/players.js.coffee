# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
    $('#players_name').autocomplete
        source:'/players.json'
        focus: (event, ui) ->
          $( "#players_name" ).val( ui.item.name  )
          return false
        select: (event, ui) ->
            $( "#players_name" ).val( ui.item.name  )
            $( "#players_id" ).val( ui.item.id )
            return false
