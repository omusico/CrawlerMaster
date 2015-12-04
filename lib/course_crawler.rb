module CourseCrawler
  def say_yes
    classes = Crawler.constants

    # Crawler.const_get classes.first
  end

  module_function :say_yes
end
