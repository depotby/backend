class CreateRoleAbilities < ActiveRecord::Migration[8.0]
  def change
    create_table :role_abilities, id: :uuid do |t|
      t.references :role, null: false, foreign_key: true, type: :uuid
      t.references :ability, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
