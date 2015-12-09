module CourseCrawler::Mixin
  def self.included(base)
    base.include(InstanceMethods)
  end

  module InstanceMethods
    private

    def current_year
      (Time.now.month.between?(1, 7) ? Time.now.year - 1 : Time.now.year)
    end

    def current_term
      (Time.now.month.between?(2, 7) ? 2 : 1)
    end

  end
end
