class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :color
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :tasks, :category, foreign_key: true
  end
end
