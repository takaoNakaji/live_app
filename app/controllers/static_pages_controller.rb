class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @search_params = micropost_search_params
      @microposts = Micropost.where("live_on > ?", Date.yesterday).paginate(page: params[:page], per_page: 10).search(@search_params)
    else
      @search_params = micropost_search_params
      @microposts = Micropost.where("live_on > ?", Date.yesterday).paginate(page: params[:page], per_page: 10).search(@search_params)
    end
  end

  private

  def micropost_search_params
    params.fetch(:search, {}).permit(:act, :live_on_from, :live_on_to, :area)
  end
end
