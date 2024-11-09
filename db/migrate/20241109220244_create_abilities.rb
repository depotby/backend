class CreateAbilities < ActiveRecord::Migration[8.0]
  def change
    create_table :abilities, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :abilities, :name, unique: true
  end
end
