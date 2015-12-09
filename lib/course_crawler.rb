module CourseCrawler
  def crawler_list
    Crawler.constants
  end

  def get_crawler sym
    Crawler.const_get sym
  end

  module_function :crawler_list, :get_crawler
end
