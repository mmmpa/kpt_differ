# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  hex             :string(255)      not null
#  user_id         :integer          not null
#  binder_id       :integer          not null
#  binder_key      :string(255)      not null
#  history_id      :integer          not null
#  older_report_id :integer
#  title           :string(255)      default(""), not null
#  body            :text(65535)      not null
#  diff            :text(65535)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  fk_rails_4835dba508          (older_report_id)
#  index_reports_on_binder_id   (binder_id)
#  index_reports_on_history_id  (history_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_4835dba508  (older_report_id => reports.id)
#  fk_rails_9a41d97e54  (binder_id => binders.id)
#  fk_rails_aa9d932195  (history_id => histories.id)
#  fk_rails_c7699d537d  (user_id => users.id)
#

class Report < ApplicationRecord
  belongs_to :user, inverse_of: :reports
  belongs_to :binder, inverse_of: :reports
  belongs_to :history, inverse_of: :reports

  belongs_to :older, class_name: Report, foreign_key: :older_report_id, inverse_of: :newer

  scope :index, -> {
    left_outer_joins(:newer, :older)
      .select(
        :body,
        'olders_reports.body as older_body',
      )
  }
end
