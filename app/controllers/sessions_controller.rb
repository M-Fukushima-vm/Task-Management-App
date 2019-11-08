class SessionsController < ApplicationController
  protect_from_forgery except: :create
  before_action :is_login?, {only: [:new, :create]}

  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。'
      redirect_back_or user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def is_login?
    if current_user 
      flash[:info] = "すでにログインしています。"
      redirect_to user_path(current_user)
    end
  end
  
end
