class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :hex, null: false
      t.string :name, null: false, default: ''

      t.timestamps
    end
  end
end
