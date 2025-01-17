class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'メールとパスワードの組み合わせが無効です'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
