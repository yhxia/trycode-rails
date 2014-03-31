require './yunyun'

scraper = YunyunScraper.new

# add proxy
if ARGV[0]=="-addp"
  # read proxy.list
  # [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}.*[0-9]{1,5}
  File.readlines("proxy.list").each do |each_proxy|
    each_proxy = each_proxy.strip
    puts "Specting "+each_proxy+" ..."
    if !Proxy.exists?(:addr=> each_proxy)
      Proxy.create({:addr=>each_proxy,:speed=>3600})
      puts "\e[32mSaved!\e[0m"
    else
      puts "\e[31mExisted!\e[0m"
    end
  end
  exit
end

# test proxy
if ARGV[0]=="-testp"
  while true do
    proxy_list = Proxy.where("speed = 3600")
    break if proxy_list.nil?
    r = Random.new(Time.now.to_i+Process.pid)
    n = r.rand(0..(proxy_list.length-2))
    proxy_list = proxy_list.limit(1).offset(n)
    if proxy_list.first.using == 1
      next
    else
      proxy_list.first.using = 1
    end
    proxy_list.first.save!

    proxy_list.each do |each_proxy|
      puts each_proxy.addr
      start_time = Time.now
      puts "\e[32mStart Time: %10.4f" % start_time.to_f+"\e[0m"

      if scraper.fetchContentByPhantomjs2("",each_proxy.addr).length > 199
        stop_time = Time.now
        puts "\e[32mStop Time: %10.4f" % stop_time.to_f+"\e[0m"
        cost_time = (stop_time - start_time)
        puts "\e[32mCost Time: %.4f" % cost_time.to_f + " s"+"\e[0m"
        each_proxy.speed = cost_time.to_i
      else
        puts "\e[31mWrong! Speed updated to 7200..."+"\e[0m"
        each_proxy.speed = 7200
      end
      proxy_list.first.using = 0
      each_proxy.save!
    end
  end
  exit
end

# download
if ARGV[0]=="-fetch"
  # keyword
  keyword_matrix = [
    [1,4,"7.1 拼音","keyboard"],
    [1,12,"7.1 输入法","keyboard"],
    [1,5,"7.1 九宫格","keyboard"],
    [1,12,"iOS 输入法","keyboard"],
    [1, 30, "iOS 7.1","ios"],
    [1, 30, "Siri","siri"],
    [1, 10, "iOS Siri","siri"],
    [1, 10, "7.1 Siri","siri"],
    [1, 10, "iPhone Siri","siri"],
    [1, 10, "iPad Siri","siri"],
    [1, 30, "7.1 升级","ios7_1"],

    [1, 20, "7.1 输入法","keyboard"],
    [1, 20, "7.1 耗电","power"],
    [1, 20, "7.1 费电","power"],
    [1, 20, "7.1 电池","power"],
    [1, 10, "7.1 反应","ios7_1"],
    [1, 10, "7.1 性能","ios7_1"],
    [1, 30, "7.1 快","ios7_1"],
    [1, 20, "7.1 慢","ios7_1"],
    [1, 10, "7.1 崩溃","ios7_1"],
    [6, 20, "7.1 界面","ios7_1"],
    [1, 30, "苹果 iOS","ios7_1"]
  ]

  # url list
  save_root = "rawdata/"
  sleep_second = 0
  url_list = []

  keyword_matrix.each do |from, to, keyword,project|
    url_list += scraper.constructStartList(from,to,keyword,project)
  end

  puts "\e[32m[Fetch] Url Generator Finished. "+url_list.length.to_s+" urls.\e[0m"

  # fetch page
  threads = []
  thr_max = 20
  thr_num = 0
  url_list.each_with_index do |each_url, index|
    thr_num +=1
    threads<<Thread.new{
      puts "[Start thread"+index.to_s+"] "+thr_num.to_s+" threads left."
      puts "\e[32m[Fetching] '"+each_url[1]+"' "+each_url[0]+" ...\e[0m"
      url = each_url[0]
      project = each_url[1]
      sleep(Random.new(125).rand(10))
      thr_num -= 1
      puts "\e[32m[Done thread"+index.to_s+"] "+thr_num.to_s+" threads left.\e[0m"
    }
    # sleep(0.1)
    while true do
      if thr_num < thr_max
        puts "[Requiring another] "+thr_num.to_s+" threads left."
        break
      end
    end
  end
  threads.each {|thr| thr.join}
  exit
  # parse page
end

















