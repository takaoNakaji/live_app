class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit update destroy]
  before_action :correct_user,   only: %i[edit update destroy]

  def show
    @micropost = Micropost.find(params[:id])
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.transaction do
      @micropost.save!
    end
    flash[:success] = "ライブを作成しました！"
    redirect_to root_url
  rescue StandardError
    @microposts = []
    @feed_items = []
    render 'new'
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    @micropost.transaction do
      @micropost.update!(micropost_params)
    end
    flash[:success] = "ライブを更新しました！"
    redirect_to @micropost
  rescue StandardError
    render 'edit'
  end

  def destroy
    @micropost.transaction do
      @micropost.destroy!
    end
    flash[:success] = "ライブを削除しました"
    redirect_to request.referer || root_url
  rescue StandardError
    flash[:danger] = "削除に失敗しました"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :area, :address, :act, :content, :url, :picture, Form::Micropost::REGISTRABLE_ATTRIBUTES)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
