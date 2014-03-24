class HomePagesController < ApplicationController
  def home
    @search_box_placeholder_text = 'Apple'

    @hotword_list_array = ["iPhone5s","苹果","iOS7","Siri","耗电","输入法","iPad","移动4G","Mac","iTunes"]

    @collecting_table_array = 
    [
      ["iPhone","2 hours"],
      ["iOS","4 days"],
      ["Siri","5 days"],
      ["OS X","10 days"],
      ["Mac","1 month"]
    ]

    @finished_table_array = 
    [
      ["苹果","52341 views"],
      ["移动4G","12634 views"],
      ["输入法","8145 views"],
      ["苹果","6123 views"],
      ["iPhone5s","1535 views"]
    ]
  end

end