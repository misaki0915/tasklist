class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      require 'date'
      @today_tasks = current_user.tasks.where(scheduled_date: DateTime.now).order(priority: :desc).page(params[:page])
      @next_tasks = current_user.tasks.where(scheduled_date: DateTime.now.tomorrow).order(priority: :desc).page(params[:page])
      @attempted_tasks = current_user.tasks.where(done: false).order(priority: :desc).page(params[:page])
    end
  end
end