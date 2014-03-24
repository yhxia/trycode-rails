require 'json'

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

    @reviewed_list = ["True", "False"].to_json

    @marked_list = ["True", "False"].to_json

    @order_list = ["Latest"].to_json

    @filter_list = [
      ["Order", @order_list]
      # ["From", @from_list],
      # ["To", @to_list],
      # ["Project", @project_list],
      # ["Site", @site_list],
      # ["Attitude", @attitude_list],
      # ["Reviewed", @reviewed_list],
      # ["Marked", @marked_list],
      # ["Related", @related_list]
    ]

    @conditions_list = 
    [
      # ["Project","iOS"],
      # ["Project","iPhone"],
      # ["From","Feb 10th"],
      # ["To","Mar 7th"],
      # ["Related","True"],
      # ["Site","Yunyun"],
      # ["Reviewed","False"],
      # ["Marked","False"],
      # ["Order","Latest"]
    ]

    #### posts ####
    postfix = ""

    # paginate
    page_root = "?p="
    params[:p] = 1 if params[:p].blank?

    # search
    search_root = "&q=" if !params[:q].blank?
    if !params[:q].blank?
      @posts_list = Post.paginate(:page => params[:p], :per_page => 10)
      @posts_list = Post.paginate(:page => 1, :per_page => 10) if params[:p].blank?
      @posts_list = @posts_list.where("content like '%"+params[:q]+"%'")
      postfix += (search_root + params[:q])
    end

    # order
    order_root = "&o=" if !params[:o].blank?
    if params[:o] == "Oldest"
      order_by_str = "time asc"
    elsif  params[:o] == "Latest"
      order_by_str = "time desc"
    end
    if !params[:o].blank? and !order_by_str.blank? and !params[:q].blank?
      @posts_list = @posts_list.reorder(order_by_str)
      postfix += (order_root + params[:o])
      @conditions_list.append(["Order",params[:o].capitalize])
    end

    # paginate return variables
    paginate_return(@posts_list,page_root,postfix) if !@posts_list.nil?
  end


  def paginate_return(list,root,postfix)
    current_i = list.current_page
    total_p = list.total_pages

    @first_url = root + 1.to_s + postfix
    @last_url = root + list.total_pages.to_s + postfix


    if current_i > 1 && current_i<=total_p
      @prev_url = root + (current_i-1).to_s + postfix
    else
      @prev_url = @first_url
    end

    if current_i < total_p
      @next_url = root + (current_i+1).to_s + postfix
    else
      @next_url = @last_url
    end

    url1 = 1
    if 1<=current_i && current_i<=total_p && total_p>5
      if current_i <= 2
        url1 = 1
      elsif current_i >= total_p - 1 && current_i >= 5
        url1 = total_p - 4
      else
        url1 = current_i - 2
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
      each_arr.append(root + (url1+eachi).to_s + postfix)
      each_arr.append(url1+eachi)
      is_span = false
      if url1+eachi == current_i
        is_span = true
      end
      each_arr.append(is_span)
      @nav_url_list.append(each_arr)
    end

  end

end
