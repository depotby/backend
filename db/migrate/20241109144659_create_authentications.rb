class CreateAuthentications < ActiveRecord::Migration[8.0]
  def change
    create_table :authentications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :status, null: false, default: Authentication.statuses[:active]
      t.string :user_agent

      t.timestamps
    end
  end
end
