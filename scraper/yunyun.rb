#by simon_xia@apple.com Feb/20/2014
require 'phantomjs'

class YunyunScraper

  def constructStartList(from_page_number, to_page_number,query_keyword)
    url_root = "http://weibo.yunyun.com/Weibo.php?"
    start_list = []
    (from_page_number..to_page_number).each do |pagenumber|
      url = url_root+"p="+pagenumber.to_s+"&q="+query_keyword
      start_list << url
    end
    return start_list
  end

  def fetchContentByPhantomjs(url)
    arr = Array.new
    argUrl = 'http://weibo.yunyun.com/Weibo.php?p=8&q=iphone' #default path
    if url!=""
      argUrl = url
    end
    puts "\e[32m[Phantomjs] Fetching "+argUrl+"...\e[0m"

    loop do
      arr = []
        # call outside file
        jspath =  File.dirname(__FILE__) + "/phantomjs_caller.js"
        Phantomjs.run(jspath,argUrl) do |line|
          if line[/\w+/]!='Unsafe' && line!="\n"
            arr<<line
          end
        end
        if arr.length>0
          puts "\e[32m[Phantomjs] Fetching content success!\e[0m"
          break
        else
          puts "\e[31m[Phantomjs] Content not enough! Try again...\e[0m"
        end
      end

    #puts arr
    puts "\e[32m[Phantomjs] Lines = "+arr.length.to_s+"\e[0m"
    return arr
  end

end

if __FILE__ == $0 # ruby yunyun.rb
  scraper = YunyunScraper.new
  start_list = scraper.constructStartList(11,24,"ios7.1") # crawling page 1, 2, 3

  puts "Start list:",start_list.to_s
  puts "Starting YunyunScraper..."

  start_list.each do |eachurl|
    save_path = "rawdata/"+eachurl.split("/")[-1].split("?")[-1]
    puts "\e[32mProcessing " + eachurl + "...\e[0m"
    if File.exists?(save_path)
      puts "'"+save_path+"' already existed! Skip..."
      next 
    end

    lines = scraper.fetchContentByPhantomjs(eachurl)
    if lines.length<100
      puts "\e[31mError in downloading!\e[0m"
      break
    end

    File.open("rawdata/"+eachurl.split("/")[-1].split("?")[-1], 'w') {|f| f.write(lines.join("")) }
    sleep(2)
  end

  puts "Finished."
end