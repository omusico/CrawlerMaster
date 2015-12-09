require 'sidekiq/api'

Dir.glob(File.join(File.dirname(__FILE__), 'crawler/*.rb')) { |file| load file }

# here should be sidekiq(redis) mangement helper class
# register worker and report statistics and other things

module CourseCrawler::Crawler

    # A helper method that can get crawler progress by jid and crawler class name(in String)
    #   Example
    # => CourseCrawler::Crawler.get_progress "NtustCourseCrawler", "56e8ce29fed9667aa81490e1"
    #
    # You can also pass jid as array too:
    # => CourseCrawler::Crawler.get_progress "NtustCourseCrawler", ["56e8ce29fed9667aa81490e1", "JID-55eec3cc4c4e143e9d3a7aca"]
    def self.get_progress class_name, jid=[]
      klass = self.const_get class_name

      if jid.is_a?(Array)
        Sidekiq.redis { |conn| jid.map{ |id| conn.get("progress:#{klass}_#{id}") } }
      else
        Sidekiq.redis { |conn| conn.get("progress:#{klass}_#{jid}") }
      end
    end

end
