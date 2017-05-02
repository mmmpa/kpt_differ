# == Schema Information
#
# Table name: binders
#
#  id          :integer          not null, primary key
#  hex         :string(255)      not null
#  group_id    :integer          not null
#  key         :string(255)      not null
#  name        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_binders_on_group_id          (group_id)
#  index_binders_on_key_and_group_id  (key,group_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_96f0476016  (group_id => groups.id)
#

class Binder < ApplicationRecord
  belongs_to :group
  has_many :users, through: :group, inverse_of: :binders
  has_many :reports, inverse_of: :binder
  has_many :histories, inverse_of: :binder

  after_validation :change_key

  scope :latest, -> {
    left_outer_joins(:histories)
      .select(
        arel_table[:id],
        arel_table[:key],
        History.arel_table[:id].maximum.as('last_history_id')
      )
      .group(:id)
  }

  class << self
    def user_ids(id)
      Binder.connection.select_rows(
        User
          .joins(:binders)
          .select(User.arel_table[:id])
          .where(Binder.arel_table[:id].eq(id))
          .to_sql
      )
    end
  end

  def change_key
    reports.update_all(binder_key: key)
    histories.update_all(binder_key: key)
  end

  def update!(*)
    Binder.transaction do
      super
    end
  end
end
