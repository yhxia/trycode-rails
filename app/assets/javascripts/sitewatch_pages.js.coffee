# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # bind keypress
  $(document).bind 'keypress', (e) =>
    if e.keyCode==13
      $('#sitewatch-searchbox button').click()
  # set seach box focus
  $('#sitewatch-searchbox input').focus();
  # event when searchbox button pressed
  $('#sitewatch-searchbox button').click ->
    root = "https://sitewatch.apple.com/watches/sucabcarve/search?utf8=✓&search_text="
    searchSrc = ""
    inputText = $('#sitewatch-searchbox input').val()

    if inputText.length>0
      searchSrc = inputText
    else 
      searchSrc = $('#sitewatch-searchbox input').attr("placeholder")

    alert "success!"
    $('iframe').attr "src", root+searchSrc
