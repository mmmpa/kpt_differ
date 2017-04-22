# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  binder_key      :string(255)
#  history_id      :integer
#  newer_report_id :integer
#  older_report_id :integer
#  title           :string(255)      not null
#  body            :text(65535)      not null
#  state           :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  fk_rails_df8959742e          (binder_key)
#  index_reports_on_history_id  (history_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_c7699d537d  (user_id => users.id)
#  fk_rails_df8959742e  (binder_key => binders.key)
#

class Report < ApplicationRecord
  belongs_to :user, through: :binder, inverse_of: :reports
  belongs_to :binder, foreign_key: :binder_key, inverse_of: :reports
  belongs_to :history, inverse_of: :reports

  belongs_to :newer, class_name: Report, foreign_key: :newer_report_id, inverse_of: :older
  belongs_to :older, class_name: Report, foreign_key: :older_report_id, inverse_of: :newer

  enum state: { editable: 1, frozen: 2 }

  validates :user, :binder, :title, :body,
            presence: true
end
