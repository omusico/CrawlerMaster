class RufusJob < ActiveRecord::Base
  belongs_to :crawler
  after_initialize :check_existance

  self.inheritance_column = :_type_disabled

  def job_instance
    self.jid && Rufus::Scheduler.s.job(self.jid)
  end

  def running?
    self.job_instance && self.job_instance.running?
  end

  def check_existance
    if self.jid && !self.job_instance
      self.destroy
    end
  end

  def unschedule
    if job_instance
      job_instance.unschedule
    end
  end
end
