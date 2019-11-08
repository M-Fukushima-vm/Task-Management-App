class TasksController < ApplicationController
  # before_action:set_user, only:[:create]
  # protect_from_forgery except: :create
  before_action :logged_in_user
  before_action :correct_user
  
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
    @tasks = current_user.tasks.order(created_at: :desc)
    # byebug
  end
  
  def show
    @task = Task.find(params[:id])
  end  
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.title = params[:title]
    @task.detail = params[:detail]
    if @task.save
      flash[:success] = "タスクを更新しました"
      redirect_to user_tasks_url
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
    
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
end
