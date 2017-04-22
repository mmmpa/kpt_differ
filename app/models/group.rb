# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :group_users, inverse_of: :user
  has_many :users, through: :group_users, inverse_of: :groups
  has_many :binders, inverse_of: :group

  def start_span!
    Report.transaction do
      binder_keys = Binder.connection.select_rows(binders.latest.to_sql)

      History.where(id: binder_keys.map(&:last)).update_all(state: :concreted)

      reports = binder_keys.map do |binder_id, binder_key, latest_history_id|
        Report.prepare!(
          binder_id: binder_id,
          new_history_id: History.create!(
            binder_id: binder_id,
            binder_key: binder_key,
            state: :editable
          ).id,
          latest_history_id: latest_history_id,
          binder_key: binder_key
        )
      end

      Report.import!(reports.flatten, validate: true)
    end
  end
end
