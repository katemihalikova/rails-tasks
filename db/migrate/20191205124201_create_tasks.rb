class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :note
      t.boolean :is_done
      t.datetime :deadline_at

      t.timestamps
    end
  end
end
