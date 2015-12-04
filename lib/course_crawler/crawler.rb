Dir.glob(File.join(File.dirname(__FILE__), 'crawler/*.rb')) { |file| require_relative(file) }

module CourseCrawler::Crawler

end
