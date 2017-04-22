class CreateBinders < ActiveRecord::Migration[5.0]
  def change
    create_table :binders do |t|
      t.string :key, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
