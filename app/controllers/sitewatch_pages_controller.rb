class SitewatchPagesController < ApplicationController
  def home
    @search_box_placeholder_text = "Apple"

    @breadcrumb_array = [["Userview","active"]] # set "" when not active

    @project_list = ["iOS","OS X","iPhone","Mac"].to_json

    @from_list = ["Feb 1st","Feb 2nd","Feb 24th","Mar 1st"].to_json

    @to_list = ["Feb 1st","Feb 2nd", "Feb 24th", "Mar 1st"].to_json

    @related_list = ["True", "False"].to_json

    @site_list = ["Yunyun", "Twitter"].to_json

    @attitude_list = ["Positive", "Neutral", "Negative"].to_json

    @saw_list = ["True", "False"].to_json

    @marked_list = ["True", "False"].to_json

    @order_list = ["Latest", "Related"].to_json

    @filter_list = 
    [
      ["Project", @project_list],
      ["From", @from_list],
      ["To", @to_list],
      ["Related", @related_list],
      ["Site", @site_list],
      ["Attitude", @attitude_list],
      ["Saw", @saw_list],
      ["Marked", @marked_list],
      ["Order", @order_list]
    ]

    @conditions_list = 
    [
      ["Project","iOS"],
      ["Project","iPhone"],
      ["From","Feb 10th"],
      ["To","Mar 7th"],
      ["Related","True"],
      ["Site","Yunyun"],
      ["Saw","False"],
      ["Marked","False"],
      ["Order","Latest"]
    ]

    # posts
    @posts1 = {
      :id => "posts1",
      :title => "Of a confirming statemen",
      :time => "10/27/13 07:55 AM PDT",
      :site => "OS X Mavericks",
      :author => "MrHoffman",
      :content => "In the absence of a confirming statement from the vendor (and unless you get lucky with somebody else around here that has this particular mult-function printer), you can install Mavericks on an external USB disk (either a fresh install, or clone your current boot disk and upgrade that), boot that external disk, and test.",
      :attitude => 1,
      :comment => "",
      :radar => "rdar://problems/1534315"
    }

    @posts2 = {
      :id => "posts2",
      :title => "Of a confirming statemen",
      :time => "10/27/13 07:55 AM PDT",
      :site => "OS X Mavericks",
      :author => "MrHoffman",
      :content => "In the absence of a confirming statement from the vendor (and unless you get lucky with somebody else around here that has this particular mult-function printer), you can install Mavericks on an external USB disk (either a fresh install, or clone your current boot disk and upgrade that), boot that external disk, and test.",
      :attitude => 3,
      :comment => "To do.",
      :radar => "rdar://problems/1235633"
    }

    @posts_list = 
    [
      @posts1,
      @posts2
    ]

  end

end
