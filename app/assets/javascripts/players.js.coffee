# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
    $('#players_name').autocomplete
        source:'/players.json'
        focus: (event, ui) ->
          $( "#players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          return false
        select: (event, ui) ->
          $( "#players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          $( "#players_id" ).val( ui.item.id )
          return false
        search: ( event, ui ) ->
          $( "#players_name" ).closest("div").removeClass("has-success").addClass("has-error").prop('title','Player does not exist')
    $('#white_players_name').autocomplete
        source:'/players.json'
        focus: (event, ui) ->
          $( "#white_players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          return false
        select: (event, ui) ->
          $( "#white_players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          $( "#game_white_player_id" ).val( ui.item.id )
          return false
        search: ( event, ui ) ->
          $( "#white_players_name" ).closest("div").removeClass("has-success").addClass("has-error").prop('title','Player does not exist')
    $('#black_players_name').autocomplete
        source:'/players.json'
        focus: (event, ui) ->
          $( "#black_players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          return false
        select: (event, ui) ->
          $( "#black_players_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          $( "#game_black_player_id" ).val( ui.item.id )
          return false
        search: ( event, ui ) ->
          $( "#black_players_name" ).closest("div").removeClass("has-success").addClass("has-error").prop('title','Player does not exist')
