class AddTasksCountToTag < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :tasks_count, :integer
  end
end
