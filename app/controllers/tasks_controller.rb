class TasksController < ApplicationController
  # before_action:set_user, only:[:create]
  # protect_from_forgery except: :create
  before_action :logged_in_user
  before_action :correct_user
  
  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = Task.new(task_params)
    if @tasks.save
      flash.now[:success] = "タスクを新規作成しました"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def index
    @tasks = Task.order(created_at: :desc)
    
  end
  
  def show
    @tasks = Task.find(params[:id])
  end  
  
  def edit
    @tasks = Task.find(params[:id])
  end
  
  def update
    @tasks = Task.find(params[:id])
    @tasks.title = params[:title]
    @tasks.detail = params[:detail]
    if @tasks.save
      flash[:success] = "タスクを更新しました"
      redirect_to user_tasks_url
    else
      render :edit
    end
    
  end
  
  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy
    redirect_to user_tasks_url
  end
  
  private
  
  def set_user
    @users = User.find(params[:user_id])
  end
  
  def task_params
    params.permit(:title, :detail, :user_id)
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
  end
    
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
    # flash[:danger] = "編集権限がありません。"
  end
  
end
