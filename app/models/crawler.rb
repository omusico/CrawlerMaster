class Crawler < ActiveRecord::Base

  before_create :setup

  store :setting, accessors: [ :schedule ]

  SCHEDULE_KEYS = [:at, :in, :every, :cron]

  def klass
    CourseCrawler.get_crawler self.name
  end

  private

  def setup
    klass                  = CourseCrawler.get_crawler self.name

    self.class_name        = klass.name
    self.organization_code = self.name.match(/(.+?)CourseCrawler/)[1].upcase
    self.schedule          = {}
  end

end
