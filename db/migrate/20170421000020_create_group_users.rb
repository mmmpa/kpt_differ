class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      t.string :hex, null: false
      t.references :user, foreign_key: true, null: false
      t.references :group, foreign_key: true, null: false

      t.timestamps
    end
  end
end
