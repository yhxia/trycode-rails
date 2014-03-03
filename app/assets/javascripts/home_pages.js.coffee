# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # keybind
  $(document).bind 'keypress', (e) =>
    if e.keyCode==13
      $('#home-searchbox button').click()
  # set search box focus
  $('#home-searchbox input').focus();
  # event when button pressed
  $('#home-searchbox button').click ->
    alert $('#home-searchbox input').val()