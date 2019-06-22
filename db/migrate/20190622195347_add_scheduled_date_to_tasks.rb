class AddScheduledDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :scheduled_date, :date
  end
end
