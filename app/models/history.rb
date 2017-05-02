# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  hex        :string(255)      not null
#  group_id   :integer          not null
#  state      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_histories_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_c9b82342e3  (group_id => groups.id)
#

class History < ApplicationRecord
  attr_accessor :latest_history_id

  belongs_to :group, inverse_of: :histories
  has_many :reports, inverse_of: :history

  enum state: { editable: 1, concreted: 2 }
end
