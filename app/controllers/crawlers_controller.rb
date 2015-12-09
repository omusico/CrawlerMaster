class CrawlersController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
    @crawler_list = CourseCrawler.crawler_list
  end

  def show
    crawler_class = CourseCrawler.crawler_list.map(&:to_s).find { |cn| cn.match(%r{#{params[:id].downcase.capitalize}CourseCrawler}) } or not_found

    @crawler = CourseCrawler.get_crawler crawler_class
  end

end
