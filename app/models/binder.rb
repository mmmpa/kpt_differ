# == Schema Information
#
# Table name: binders
#
#  id          :integer          not null, primary key
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
  has_many :reports, inverse_of: :binder
  has_many :histories, inverse_of: :binder

  def start_span
    History.create!(
      state: :editable,
      binder: self
    )
  end
end
