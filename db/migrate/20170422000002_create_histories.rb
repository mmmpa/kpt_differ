class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.string :binder_key, null: false
      t.integer :state, null: false

      t.timestamps
    end

    add_foreign_key :histories, :binders, column: :binder_key, primary_key: :key
  end
end
