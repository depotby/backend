class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.string :uri_name, null: false

      t.timestamps
    end
    add_index :categories, :uri_name, unique: true
  end
end
