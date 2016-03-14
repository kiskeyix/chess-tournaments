# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
    $('#home_team_name').autocomplete
        source:'/teams.json'
        focus: (event, ui) ->
          $( "#home_team_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          return false
        select: (event, ui) ->
          $( "#home_team_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          $( "#home_team_id" ).val( ui.item.id )
          return false
        search: ( event, ui ) ->
          $( "#home_team_name" ).closest("div").removeClass("has-success").addClass("has-error").prop('title','Team does not exist')
    $('#guest_team_name').autocomplete
        source:'/teams.json'
        focus: (event, ui) ->
          $( "#guest_team_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          return false
        select: (event, ui) ->
          $( "#guest_team_name" ).val( ui.item.name  ).closest("div").removeClass("has-error").addClass("has-success").prop('title','')
          $( "#guest_team_id" ).val( ui.item.id )
          return false
        search: ( event, ui ) ->
          $( "#guest_team_name" ).closest("div").removeClass("has-success").addClass("has-error").prop('title','Team does not exist')

