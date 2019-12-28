class AddPrimaryKeyToTagsTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tags_tasks, :id, :primary_key
  end
end
