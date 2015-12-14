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
      courses = @klass_instance.courses # default course crawler method

      # Save course datas into database
      org = args[0].match(/(.+?)CourseCrawler/)[1].upcase
      inserted_column_names = [:ucode] + Course.inserted_column_names + [ :created_at, :updated_at ]

      courses_inserts = courses.map do |c|
        c[:name] && c[:name].gsub!("'", "''")
        c[:lecturer_name] && c[:lecturer_name].gsub!("'", "''")
        c[:lecturer_name] = c[:lecturer_name].nil? ? "" : c[:lecturer_name]
        c[:required] = c[:required].nil? ? "NULL" : c[:required]

        # 去頭去尾
        "( '#{org}-#{c[:code]}', '#{org}', #{
          inserted_column_names[2..-3].map do |k|
            c[k].nil? ? "NULL" : "'#{c[k]}'"
          end.join(', ')
        }, '#{Time.now}', '#{Time.now}' )"
      end

      sql = <<-eof
        INSERT INTO courses (#{inserted_column_names.join(', ')})
        VALUES #{courses_inserts.join(', ')}
      eof

      ActiveRecord::Base.transaction {
        Course.where(organization_code: org).destroy_all
        ActiveRecord::Base.connection.execute(sql)
      }
    end

  end
end


