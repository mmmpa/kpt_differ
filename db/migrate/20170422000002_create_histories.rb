class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.string :hex, null: false
      t.references :group, foreign_key: true, null: false
      t.integer :state, null: false

      t.timestamps
    end
  end
end
