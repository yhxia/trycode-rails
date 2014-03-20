# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # parse params
  query = window.location.search.substring(1)
  raw_vars = query.split("&")
  params = {}
  for v in raw_vars
    [key, val] = v.split("=")
    params[key] = decodeURIComponent(val)
    #alert(params[key])

  # bind keypress
  $(document).bind 'keypress', (e) =>
    if e.keyCode==13
      $('#sitewatch-searchbox button').click()

  # set seach box focus
  # $('#sitewatch-searchbox input').focus();

  # event when searchbox button pressed
  $('#sitewatch-searchbox button').click ->
    if $('#sitewatch-searchbox input').val()!=""
      window.open("?q="+$('#sitewatch-searchbox input').val(),"_self")
    else
      window.open("?q="+$('#sitewatch-searchbox input').attr('placeholder'),"_self")

  $('#filter-value').hide()

  $('#filter-condition ul li a').click ->
    condition_name = $(this).text().trim()
    # alert(condition_name)
    $('#filter-condition a:first').html(condition_name+" <span class=\"caret\"></span>")
    $('#filter-value').show()
    condition_value_json = jQuery.parseJSON($(this).next().val())
    $('#filter-value ul:first').empty()
    $('#filter-value a:first').html(" <span class=\"caret\"></span>")

    for each_value in condition_value_json
      do (each_value) ->
        if query.length==0
          params_temp = {}
        else
          params_temp = params

        ####order####
        if condition_name=="Order"
          params_temp['o'] = each_value

        href_temp = "?"+jQuery.param(params_temp)
        $('#filter-value ul:first').append("<li><a href= \""+href_temp+"\">"+each_value+"</a></li>")

    $('#filter-value ul li a').click ->
      $('#filter-value a:first').html($(this).text()+" <span class=\"caret\"></span>")


  $('#condition').next().children("button").click ->
    button_text = $(this).next().text().trim()
    params_temp = params

    ####order####
    if button_text == "Order:"
      delete params_temp['o']

    window.open("?"+jQuery.param(params_temp),"_self")

  #####################################################################
  #for posts
  $('#userview-custom-bar button').click ->
    # alert($(this).next().children().first().val()) 
    post_obj = $(this).parent().children()
    uv_radar = post_obj.eq(1).children().first().val() #rdar
    uv_comment = post_obj.eq(2).children().first().val() #comment
    radios_obj = post_obj.eq(3).children()
    uv_unrelated = radios_obj.eq(0).children().eq(0).first().is(":checked")
    uv_positive = radios_obj.eq(1).children().eq(0).first().is(":checked")
    uv_neutral = radios_obj.eq(2).children().eq(0).first().is(":checked")
    uv_negative = radios_obj.eq(3).children().eq(0).first().is(":checked")

    params_add_report = {}
    params_add_report["uv_radar"] = uv_radar
    params_add_report["uv_comment"] = uv_comment
    params_add_report["uv_attitude"] = 0
    if uv_unrelated
      params_add_report["uv_attitude"] = 1
    else if uv_positive
      params_add_report["uv_attitude"] = 2
    else if uv_neutral
      params_add_report["uv_attitude"] = 3
    else if uv_negative
      params_add_report["uv_attitude"] = 4
    json_add_report = jQuery.param(params_add_report)
    alert(json_add_report)



