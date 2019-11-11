class TasksController < ApplicationController
  before_action :set_user
  # protect_from_forgery except: :create
  before_action :logged_in_user
  before_action :correct_user_1, only: [:new, :create]
  before_action :correct_user_2, only: [:edit, :update]
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def index
    @tasks = Task.where(params[:user_id]).order(created_at: :desc)
  end
  
  def show
    @task = Task.find(params[:id])
  end  
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    # @task.title = params[:title]
    # @task.detail = params[:detail]
    # if @task.save
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to user_task_url
    else
      render :edit
    end
    
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_url
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def task_params
    params.require(:task).permit(:title, :detail, :user_id)
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
  end
    
  def correct_user_1
    if logged_in? &&current_user?(@user)
      
    # elsif logged_in?  
    #   redirect_to(user_tasks_url(current_user))
    #   flash.now[:danger] = "権限がありません。"
    else
      redirect_to(root_url)
      flash[:danger] = "権限がありません。"
    end
  end
  
  def correct_user_2
    if logged_in? &&current_user?(@user)
      
    # elsif logged_in?  
    #   redirect_to(user_tasks_url(current_user))
    #   flash.now[:danger] = "権限がありません。"
    else
      redirect_to(user_tasks_url(current_user))
      flash[:danger] = "権限がありません。"
    end
  end
  
end
