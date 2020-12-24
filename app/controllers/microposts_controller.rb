class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @micropost = Micropost.find(params[:id])
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "ライブを作成しました！"
      redirect_to root_url
    else
      @microposts = []
      #@feed_items = []
      render 'new'
    end
  end
  
  def edit
    @micropost = Micropost.find(params[:id])
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "ライブを更新しました！"
      redirect_to @micropost
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "ライブを削除しました"
    redirect_to request.referrer || root_url
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
