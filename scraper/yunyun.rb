#by simon_xia@apple.com Feb/20/2014
require 'rubygems'
require 'phantomjs'
require 'hpricot'
require 'active_support'
require 'active_support/time'
require 'active_record'
require 'yaml'

class Post < ActiveRecord::Base
end

class YunyunScraper

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter  => 'mysql2',
      :database => 'userview_test',
      :username => 'root',
      :host     => 'localhost')
  end

  # Downloader core
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
        Phantomjs.run(jspath,argUrl,"--proxy=66.86.108.61:24155") do |line|
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

  # Download List Generator
  def constructStartList(from_page_number, to_page_number,query_keyword)
    url_root = "http://weibo.yunyun.com/Weibo.php?"
    url_list = []
    (from_page_number..to_page_number).each do |pagenumber|
      url = url_root+"p="+pagenumber.to_s+"&q="+query_keyword
      url_list << url
    end
    puts "Download url_list:",url_list.to_s
    return url_list
  end

  # Downloader
  def downloader(url_list, save_root, post_fix, sleep_second)
    puts "Starting Yunyun Crawler..."

    url_list.each do |eachurl|
      save_path = save_root + eachurl.split("/")[-1].split("?")[-1] + post_fix
      puts "\e[32m[Downloader] Processing " + eachurl + "...\e[0m"
      if File.exists?(save_path)
        puts "'"+save_path+"' already existed! Skip..."
        next 
      end

      lines = fetchContentByPhantomjs(eachurl)
      if lines.length<100
        puts "\e[31m[Downloader] Contents less than 100 lines! Break...\e[0m"
        puts lines.join("").to_s
        return false
      end

      File.open(save_path, 'w') {|f| f.write(lines.join("")) }
      sleep(sleep_second)
    end

    return true
  end

  # Parser
  def parser(file_list)
    postTable = []

    file_list.each do |eachfile|
      begin
        puts "\e[32m[Parser] Parsing "+eachfile+"...\e[0m"
        doc = Hpricot(File.read(eachfile))
        if doc.nil?
          puts "\e[31m[Parser] Failed during Hpricot process! Retry...\e[0m"
          next
        end
        puts "\e[32m[Parser] Hpricot success! Doc length = "+ doc.to_s.length.to_s+"\e[0m"        

        (doc/"div.s_microblog").each_with_index do |microblog,index|
          post=[]
          puts "\e[32mMicroblog "+index.to_s + ":\e[0m\n" 
          
          if (microblog/"p.f15 a").nil? or (microblog/"span.feed_item_r span a").nil?
            puts "\e[31mWrong microblog! Ignored.\e[0m"
            next
          else
            puts "author = #{author = (microblog/"p.f15 a")[0].inner_text}"
            puts "content = #{content = (microblog/"p.f15").inner_text[author.length+1..-1].strip}"
            puts "time = #{time = parse_yunyun_time((microblog/"span.time a")[0]['title'])}"
            puts "post_url = #{post_url = (microblog/"span.feed_item_r span a")[2]['href'].split("?")[0]}"
            puts "author_url = #{author_url = (microblog/"p.f15 a")[0]['href']}"
            content_length = 0
            current_index = 0
            content.each_char do |c|
              if c.ascii_only?
                content_length += 1
              else
                content_length += 2
              end
              if content_length < 50
                current_index += 1
              end
            end
            puts "content_length = " + content_length.to_s
            puts "title = #{title = content_length>50 ? content[0..current_index]+"..." : content}"
            puts "site = #{site = "http://"+post_url.split("/")[2]}"
          end

          post << {
            :title => title,
            :time => time,
            :site => site,
            :author => author,
            :content => content,
            :post_url => post_url,
            :author_url => author_url
          }
          postTable << post
        end #doc.each
      rescue Exception => e
        puts "\e[31m[Posts_for] Wrong with processing! Skip...\e[0m"
        puts e.to_s
        next
      end # begin
    end # file_list.each
    postTable
  end

  # parse time format
  def parse_yunyun_time(time_string)
    #puts time_string
    time = Time.parse(time_string.gsub('-', '/'))# - 15.hours in U.S.
    time = time - 24.hours if time_string.downcase.index('yesterday')
    time
  end

  def saveData(postData)
    new_post_count = 0
    dup_post_count = 0
    postData.each do |post|
      puts post.to_s
      if !Post.exists?(:post_url=> post[0][:post_url])
        post = Post.create(post)
        puts "\e[32mSaved!\e[0m"
        new_post_count +=1
      else
        puts "\e[31mAlready Existed!\e[0m"
        dup_post_count +=1
      end
    end
    puts "new_post_count = "+new_post_count.to_s
    puts "dup_post_count = "+dup_post_count.to_s
  end

end

if __FILE__ == $0 # ruby yunyun.rb

  scraper = YunyunScraper.new

  keywordMatrix  = [
    # [1, 30, "iOS 7.1"],
    # [1, 30, "Siri"],
    # [1, 10, "iOS Siri"],
    # [1, 10, "7.1 Siri"],
    # [1, 10, "iPhone Siri"],
    # [1, 10, "iPad Siri"],
    # [1, 30, "7.1 升级"],

    # [1, 20, "7.1 输入法"],
    # [1, 20, "7.1 耗电"],
    # [1, 20, "7.1 费电"],
    # [1, 20, "7.1 电池"],
    # [1, 10, "7.1 反应"],
    # [1, 10, "7.1 性能"],
    # [1, 30, "7.1 快"],
    # [1, 20, "7.1 慢"],
    # [1, 10, "7.1 崩溃"],
    [6, 20, "7.1 界面"]
  ]

  # from = 1 
  # to = 22 #[1,22]
  # keyword = "ios7.1"

  post_fix = "_"+Time.now.to_s.split(" ").join("_")
  save_root = "rawdata/"
  sleep_second = 0
  url_list = []

  # keywordMatrix.each do |from, to,keyword|
  #   url_list += scraper.constructStartList(from,to,keyword)
  # end


  # while true do
  #   if scraper.downloader( url_list , save_root, post_fix, sleep_second) # url, dir, post_fix, sleep_second
  #     break
  #   end
  #   sleep(10)
  # end

  file_list = Dir.glob("rawdata/*")

  file_list.each do |file|
    fileArr = []
    fileArr.append(file)
    postData = scraper.parser(fileArr)

    scraper.saveData(postData)

    puts "\nTotal posts: "+postData.length.to_s
  end

  puts "Finished."
end

