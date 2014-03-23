class ReportPagesController < ApplicationController
  def home

    # cookies.delete :highlights

    if !cookies[:highlights].nil?
      highlights = JSON.parse(cookies[:highlights])
      @highlights_list = []
      highlights["items"].each do |item|
        json_item = {}
        json_item[:id]= item["id"]
        json_item[:comment] = item["comment"]
        json_item[:url] = [item["url"]]
        json_radar = []
        # radar_arr = item["radar"].split("//")[1].split("&")
        # item["radar"].each do |radar|
        #   json_radar += radar
        # end
        json_radar.append(item["radar"])
        json_item[:radar] = json_radar
        json_item[:attitude] = item["attitude"].to_i
        json_item[:keyword] = item["keyword"]
        @highlights_list.append(json_item)
      end

      chart_raw_list = {}
      max = 0
      highlights["items"].each do |item|
        if !chart_raw_list.has_key?(item["keyword"])
          chart_raw_list[item["keyword"]] = [0,0,0,0,0]
        end
        # add attitude, not "unrelated"
        if item["attitude"].to_i>=2 && item["attitude"].to_i<=4
          chart_raw_list[item["keyword"]][item["attitude"].to_i-1] += 1
          chart_raw_list[item["keyword"]][4]+=1
        end
        # add up total
        if max < chart_raw_list[item["keyword"]][4]
          max = chart_raw_list[item["keyword"]][4]
        end
      end

      @chart_list = {}
      @keyword_list = []
      #second loop decide each bar length
      #from chart_raw_list to chart_list
      chart_raw_list.each do |key,value|
        @chart_list[key] = ["","","","",0]
        @chart_list[key][0] = (95.0*value[4]/max).round(0).to_s+"%" # bar_per
        pos_per = (100.0*value[1]/value[4]).round(0)
        @chart_list[key][1] = pos_per.to_s+"%"
        neu_per = (100.0*value[2]/value[4]).round(0)
        @chart_list[key][2] = neu_per.to_s+"%"
        @chart_list[key][3] = (100 - pos_per - neu_per).to_s+"%"
        @chart_list[key][4] = value[4]
        @keyword_list.append(["",key])
      end

      @keyword_list[0][0] = "iOS7.1"

      # @chart_list = {
      #   "Apple"=>["51%","51%","20%","29%",124],
      #   "苹果"=>["90%","23%","64%","13%",252]
      # }
    end

    cookies[:result] = @highlights_list.to_json+"\n"+@chart_list.to_json
  end

  def new
  end
end
