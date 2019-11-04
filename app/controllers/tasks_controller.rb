class TasksController < ApplicationController
  before_action:set_user, only:[:create,]
  protect_from_forgery except: :create
  
  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = Task.new(task_params)
    @tasks.user_id = @users.id
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
end
