class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def show
    @users = User.find(params[:id])
  end

  def new
    @users = User.new
  end
  
  def create
    @users = User.new(user_params)
    if @users.save
      log_in @users
      flash[:success] = '新規作成に成功しました。'
      redirect_to users_show_path(@users.id)
    else
      render :new
    end
  end
  
  def edit
    @users = User.find(params[:id])
  end
  
  def update
    @users = User.find(params[:id])
    if @users.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @users
    else
      render :edit
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
end
