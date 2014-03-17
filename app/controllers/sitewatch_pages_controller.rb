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

    @root = "?page="

    if params[:page].blank?
      params[:page]=1
    end

    @posts_list = Post.order(time: :desc).paginate(:page => params[:page], :per_page => 10)

    current_i = @posts_list.current_page
    total_p = @posts_list.total_pages

    @first_url = @root + 1.to_s
    @last_url = @root + @posts_list.total_pages.to_s

    @prev_url = @root + (current_i-1).to_s if current_i > 1
    @next_url = @root + (current_i+1).to_s if current_i < total_p

    @url1 = 1
    if 1<=current_i && current_i<=total_p
      if current_i <= 2
        @url1 = 1
      elsif current_i >= total_p - 1
        @url1 = total_p - 4
      else
        @url1 = current_i - 2
      end
    end

    @nav_url_list = [
      # [@root+1.to_s,1,true],
      # [@root+2.to_s,2,false],
      # [@root+3.to_s,3,false],
      # [@root+4.to_s,4,false],
      # [@root+5.to_s,5,false]
    ]

    to_page_range = 4
    if total_p<5
      to_page_range = total_p - 1
    end

    (0..to_page_range).each do |eachi|
      each_arr = []
      each_arr.append(@root + (@url1+eachi).to_s)
      each_arr.append(@url1+eachi)
      is_span = false
      if @url1+eachi == current_i
        is_span = true
      end
      each_arr.append(is_span)
      @nav_url_list.append(each_arr)
    end

  end

end
