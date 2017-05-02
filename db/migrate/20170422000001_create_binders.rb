class CreateBinders < ActiveRecord::Migration[5.0]
  def change
    create_table :binders do |t|
      t.string :hex, null: false
      t.references :group, foreign_key: true, null: false
      t.string :key, null: false
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end

    add_index :binders, [:key, :group_id], unique: true
  end
end
