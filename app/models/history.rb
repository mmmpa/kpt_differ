# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  binder_key :string(255)      not null
#  state      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  fk_rails_d039cbb823  (binder_key)
#
# Foreign Keys
#
#  fk_rails_d039cbb823  (binder_key => binders.key)
#

class History < ApplicationRecord
  belongs_to :binder, primary_key: :key, foreign_key: :binder_key, inverse_of: :histories
  has_many :reports, inverse_of: :history

  enum state: { editable: 1, concreted: 2 }

  after_create :prepare

  def prepare
    reports = User.joins(:groups).where(group_users: { group: binder.group }).map do |user|
      Report.new(
        user: user,
        binder: binder,
        history: self,
        body: ''
      )
    end

    Report.import!(reports, validate: true)
  end
end
