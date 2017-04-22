# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  binder_id       :integer          not null
#  binder_key      :string(255)      not null
#  history_id      :integer          not null
#  newer_report_id :integer
#  older_report_id :integer
#  title           :string(255)      default(""), not null
#  body            :text(65535)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  fk_rails_183c1b57c3          (newer_report_id)
#  fk_rails_4835dba508          (older_report_id)
#  index_reports_on_binder_id   (binder_id)
#  index_reports_on_history_id  (history_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_183c1b57c3  (newer_report_id => reports.id)
#  fk_rails_4835dba508  (older_report_id => reports.id)
#  fk_rails_9a41d97e54  (binder_id => binders.id)
#  fk_rails_aa9d932195  (history_id => histories.id)
#  fk_rails_c7699d537d  (user_id => users.id)
#

class Report < ApplicationRecord
  belongs_to :user, inverse_of: :reports
  belongs_to :binder, primary_key: :key, foreign_key: :binder_key, inverse_of: :reports
  belongs_to :history, inverse_of: :reports

  belongs_to :newer, class_name: Report, foreign_key: :newer_report_id, inverse_of: :older
  belongs_to :older, class_name: Report, foreign_key: :older_report_id, inverse_of: :newer

  class << self
    def prepare!(new_history_id:, binder_id:, binder_key:, latest_history_id:)
      old_reports = Report.where(history_id: latest_history_id).pluck(:user_id, :id).to_h

      Binder.user_ids(binder_id).map do |user_id, _|
        Report.new(
          user_id: user_id,
          binder_id: binder_id,
          binder_key: binder_key,
          history_id: new_history_id,
          older_report_id: old_reports[user_id],
          body: ''
        )
      end
    end
  end
end
