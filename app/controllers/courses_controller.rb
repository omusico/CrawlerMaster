class CoursesController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
    if params[:organization_code]
      @courses = Course.where(organization_code:  params[:organization_code].upcase).page(params[:page]).per(params[:paginate_by])
    else
      @courses = Course.page(params[:page]).per(params[:paginate_by])
    end
  end
end
