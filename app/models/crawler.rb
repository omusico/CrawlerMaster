class Crawler < ActiveRecord::Base

  before_create :setup
  has_many :rufus_jobs

  store :setting, accessors: [ :schedule ]

  SCHEDULE_KEYS = [:at, :in, :every, :cron]
  API_MANAGEMENT_KEYS = [:data_management_api_endpoint, :data_management_api_key, :data_name]
  TEST_SETTING_KEYS = [ :save_to_db, :sync ]

  def klass
    CourseCrawler.get_crawler self.name
  end

  def short_org
    self.organization_code.downcase
  end

  def run_up(args={})
    SCHEDULE_KEYS.map do |k|
      time_str = self.schedule[k]
      next if time_str.empty?

      j = Rufus::Scheduler.s.send(:"schedule_#{k}", time_str) do
        Sidekiq::Client.push(
          'queue' => self.name,
          'class' => CourseCrawler::Worker,
          'args' => [
            self.name,
            args
          ]
        )
      end
      self.rufus_jobs.create(jid: j.id, type: k.to_s, original: j.original)

      j
    end
  end

  private

  def setup
    klass                  = CourseCrawler.get_crawler self.name

    self.class_name        = klass.name
    self.organization_code = self.name.match(/(.+?)CourseCrawler/)[1].upcase
    self.schedule          = {}
  end

end
