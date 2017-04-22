class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true, null: false
      t.string :binder_key, null: false
      t.references :history, foreign_key: true, null: false

      t.integer :newer_report_id
      t.integer :older_report_id
      t.string :title, null: false, default: ''
      t.text :body, null: false

      t.timestamps
    end

    add_foreign_key :reports, :binders, column: :binder_key, primary_key: :key
  end
end
