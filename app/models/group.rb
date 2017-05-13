# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  hex        :string(255)      not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :group_users, inverse_of: :user
  has_many :users, through: :group_users, inverse_of: :groups
  has_many :binders, inverse_of: :group
  has_many :histories, inverse_of: :group

  # ユーザー追加時、レポート追加時に実行が望ましい
  def prepare_report!
    user_ids = users.ids
    latest_history_id = latest_history.id

    nested_reports = binders.pluck(:id, :key).map do |binder_id, binder_key|
      newer_user_ids = user_ids - Report.where(binder_id: binder_id).select(:user_id).distinct.pluck(:user_id)

      newer_user_ids.map do |user_id|
        Report.new(
          user_id: user_id,
          binder_id: binder_id,
          binder_key: binder_key,
          history_id: latest_history_id,
          body: '',
          diff: ''
        )
      end
    end

    reports = nested_reports.flatten

    Report.import!(reports.flatten, validate: true) if reports.size != 0
  end

  def start_span!(at: Time.zone.now)
    Report.transaction do
      latest_history.update!(state: :concreted)

      copy!(
        now: at.to_s(:db),
        latest_history_id: latest_history.id,
        new_history_id: histories.create!(state: :editable).id,
      )
    end
  end

  private

  def latest_history
    @latest_history ||= histories.order(created_at: :desc).first || histories.create!(state: :editable)
  end

  def copy!(now:, latest_history_id:, new_history_id:)
    report_ids = Report.where(history_id: latest_history_id).ids

    return if report_ids.size == 0

    sql = <<-SQL
      insert 
      into reports (id,   hex,    user_id, binder_id, binder_key, history_id,        older_report_id, title, body, diff, created_at, updated_at)
      select        NULL, UUID(), user_id, binder_id, binder_key, #{new_history_id}, id,              title, body, ''  , '#{now}', '#{now}'
      from reports
      where id in (#{report_ids.join(',')})
    SQL

    Report.connection.select_rows(sql)
  end
end
