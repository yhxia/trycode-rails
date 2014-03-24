# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#hightlight-content #clear-cookie-btn').click ->
    $.cookie("highlights","")
    location.reload();

  labels_list = []
  now_date = new Date()
  # alert(now_date)
  month_ago_date = new Date()
  month_ago_date.setTime(now_date.getTime() - 29*24*60*60*1000)
  # alert(month_ago_date)

  for i in [0..29]
    each_date = new Date()
    each_date.setTime(month_ago_date.getTime() + i*24*60*60*1000)
    labels_list.push((each_date.getMonth()+1)+"-"+each_date.getDate())

  # alert(labels_list)

  lineChartData = {
    labels : labels_list,
    datasets : [
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,1)",
        pointColor : "rgba(151,187,205,1)",
        pointStrokeColor : "#fff",
        data : [4,4,16,14,38,25,13,13,24,56,103,32,69,70,0,420,106,130,202,133,44,123,67,62,10,4,2,6,1,4,6,3]
      }
    ]
  }

  myLine = new Chart($("#canvas")[0].getContext("2d")).Line(lineChartData);