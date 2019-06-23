class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(scheduled_date: :desc).page(params[:page])
      require 'date'
      @today_tasks = current_user.tasks.where(scheduled_date: Date.today).page(params[:page])
      @next_tasks = current_user.tasks.where(scheduled_date: Date.tomorrow).page(params[:page])
      @attempted_tasks = current_user.tasks.where(done: false).page(params[:page])
    end
  end
end