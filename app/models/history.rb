# == Schema Information
#
# Table name: histories
#
#  id         :integer          not null, primary key
#  binder_id  :integer
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
  belongs_to :binder, inverse_of: :histories
  has_many :reports, inverse_of: :history
end
