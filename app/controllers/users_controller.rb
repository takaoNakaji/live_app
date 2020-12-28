class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user,   only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.transaction do
      @user.save!
    end
    log_in @user
    flash[:success] = "ようこそ Stcheck へ！"
    redirect_to @user
  rescue StandardError
    render 'new'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.transaction do
      @user.update!(user_params)
    end
    flash[:success] = "ユーザー情報を更新しました！"
    redirect_to @user
  rescue StandardError
    render 'edit'
  end

  def destroy
    User.transaction do
      User.find(params[:id]).destroy!
    end
    flash[:success] = "退会しました"
    redirect_to users_url
  rescue StandardError
    flash[:danger] = "退会に失敗しました"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # beforeアクション

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
