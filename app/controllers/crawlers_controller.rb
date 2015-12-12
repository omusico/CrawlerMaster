class CrawlersController < ApplicationController
  before_filter :authenticate_admin_user!
  before_filter :find_crawler, only: [:show, :setting, :run]

  def index
    @crawler_list = CourseCrawler.crawler_list
  end

  def show
  end

  def setting
    params[:schedule].slice(*Crawler::SCHEDULE_KEYS).each do |hkey, value|
      @crawler.schedule[hkey] = value
    end

    @crawler.save!

    flash[:success] = "Schedule has been successfully updated"
    redirect_to crawler_path(@crawler.organization_code)
  end

  def run
    jobs = @crawler.run_up(year: params[:year], term: params[:term])

    flash[:success] = "job_ids: #{jobs.map{|j| j && j.id}}"

    redirect_to crawler_path(@crawler.organization_code)
  end

  private

  def find_crawler
    demodulized_name = CourseCrawler.crawler_list.map(&:to_s).find { |cn| cn.match(%r{#{params[:id].downcase.capitalize}CourseCrawler}) } or not_found

    @crawler = Crawler.find_or_create_by(name: demodulized_name)
  end
end
