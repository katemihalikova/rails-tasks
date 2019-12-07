class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :color
      t.references :user, foreign_key: true

      t.timestamps
    end
    create_table :tags_tasks, :id => false do |t|
      t.references :task, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
