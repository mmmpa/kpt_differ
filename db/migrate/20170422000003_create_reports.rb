class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :hex, null: false
      t.references :user, foreign_key: true, null: false
      t.references :binder, foreign_key: true, null: false
      t.string :binder_key, null: false
      t.references :history, foreign_key: true, null: false

      t.integer :older_report_id
      t.string :title, null: false, default: ''
      t.text :body, null: false
      t.text :diff, null: false

      t.timestamps
    end

    add_foreign_key :reports, :reports, column: :older_report_id, primary_key: :id
  end
end
