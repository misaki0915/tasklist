class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :edit, :destroy, :donechange]
  
  def create
    @task = current_user.tasks.build(task_params)
    @task.done = false
    if @task.scheduled_date == nil
      require 'date'
      @task.scheduled_date = Date.today
    end
    if @task.save
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      if @task.scheduled_date == nil
        require 'date'
        @task.scheduled_date = Date.today
        @task.save
      end
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました！！'
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:content, :priority, :done, :scheduled_date) #done ha hyou
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
  
end