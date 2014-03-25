class HomePagesController < ApplicationController
  def home
    @search_box_placeholder_text = 'Apple'

    @hotword_list_array = ["iPhone5s","苹果","iOS 7.1","Siri","耗电","输入法","iPad","4G","Mac","iTunes"]

    @collecting_table_array = 
    [
      ["OS X","4 days"],
      ["Mac","2 days"],
      ["iPod","20 hours"],
      ["iPhone 5c","1 hour"],
      ["iTunes","12 minutes"]
    ]

    @finished_table_array = 
    [
      ["iPhone 5s","6386 posts"],
      ["iOS 7.1","2568 posts"],
      ["Siri","2275 posts"],
      ["Power","1853 posts"],
      ["Input Method","1263 posts"]
    ]
  end

end