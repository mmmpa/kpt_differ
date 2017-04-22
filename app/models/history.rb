# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  binder_id  :integer          not null
#  binder_key :string(255)      not null
#  state      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_histories_on_binder_id  (binder_id)
#
# Foreign Keys
#
#  fk_rails_02e68ebf7a  (binder_id => binders.id)
#

class History < ApplicationRecord
  attr_accessor :latest_history_id

  belongs_to :binder, primary_key: :key, foreign_key: :binder_key, inverse_of: :histories
  has_many :reports, inverse_of: :history

  enum state: { editable: 1, concreted: 2 }
end
