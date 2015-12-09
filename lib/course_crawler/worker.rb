##
# A general crawler containing worker class. Works for all classes of crawler.
# It would automatically lookup classes under "Crawler" module and call default
# execution method.
#
# Example:
#   CourseCrawler::Worker.perform_async "NtustCourseCrawler", { year: 2015, term: 2 }
#
# The class CourseCrawler::Crawler::NtustCourseCrawler will be loaded and create an instance
# then call default method "courses".

module CourseCrawler
  class Worker
    include Sidekiq::Worker

    def perform *args
      klass = Crawler.const_get args[0] # may through

      @klass_instance = klass.new(*args[1..-1])
      @klass_instance.worker = self
      @klass_instance.courses # default course crawler method

      # Data handling here
      # ...
    end

  end
end


