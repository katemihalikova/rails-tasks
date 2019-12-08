class AddTasksCountToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :tasks_count, :integer
  end
end
