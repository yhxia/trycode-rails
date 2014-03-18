# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # bind keypress
  $(document).bind 'keypress', (e) =>
    if e.keyCode==13
      $('#sitewatch-searchbox button').click()

  # set seach box focus
  # $('#sitewatch-searchbox input').focus();

  # event when searchbox button pressed
  $('#sitewatch-searchbox button').click ->
    if $('#sitewatch-searchbox input').val()!=""
      window.open("/sitewatch?q="+$('#sitewatch-searchbox input').val(),"_self")
    else
      window.open("/sitewatch?q="+$('#sitewatch-searchbox input').attr('placeholder'),"_self")

  $('#filter-value').hide()

  $('#filter-condition ul li a').click ->
    # alert($(this).text().trim())
    $('#filter-condition a:first').html($(this).text()+"<span class=\"caret\"></span>")

    # alert($(this).next().val())
    $('#filter-value').show()

    # json_value = jQuery.parseJSON($(this).next().val())
    # json_value.each(function(index)){
    #   $('#filter-value ul').append()
    # }
    # alert(json_value.length)

    # $('#filter-value ul').append()