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

  def start_span!(at: Time.zone.now)
    Report.transaction do
      # バインダーごとの最新のヒストリーの id を得る
      # [binder_id, history_id]
      binder_ids = Binder.connection.select_rows(binders.latest.to_sql)

      # バインダーごとの最新のヒストリーをコンクリートする
      History.where(id: binder_ids.map(&:last)).update_all(state: :concreted)

      # 現在の最新のヒストリーにひもづくレポートを、新たに作成したヒストリー上に複製する
      binder_ids.map do |binder_id, binder_key, latest_history_id|
        new_history_id = History.create!(
          binder_id: binder_id,
          binder_key: binder_key,
          state: :editable,
          created_at: at
        ).id
        report_ids = Report.where(history_id: latest_history_id).ids

        copy_on!(report_ids, new_history_id, binder_key, at)
      end
    end

  end

  def copy_on!(report_ids, new_history_id, binder_key, at)
    now = at.to_s(:db)

    sql = <<-SQL
      insert 
      into reports (id,   hex,    user_id, binder_id, binder_key, history_id,        newer_report_id, older_report_id, title, body, created_at, updated_at)
      select        NULL, UUID(), user_id, binder_id, binder_key, #{new_history_id}, newer_report_id, id,              title, body, '#{now}', '#{now}'
      from reports
      where id in (#{report_ids.join(',')})
    SQL

    Report.connection.select_rows(sql)
  end

end
