class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.string :binder_key
      t.references :history, foreign_key: false

      t.integer :newer_report_id
      t.integer :older_report_id
      t.string :title, null: false
      t.text :body, null: false

      t.integer :state, null: false, default: 1

      t.timestamps
    end

    add_foreign_key :reports, :binders, column: :binder_key, primary_key: :key
  end
end
