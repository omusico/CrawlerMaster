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
    sidekiq_options :retry => 1

    def perform *args
      klass = Crawlers.const_get args[0] # may through


      @klass_instance =
        klass.new(
          year: args[1][:year],
          term: args[1][:term],
          update_progress: args[1][:update_progress],
          after_each: args[1][:after_each]
        )

      @klass_instance.worker = self
      @klass_instance.courses # default course crawler method

      # Data handling here
      # ...
    end

  end
end


