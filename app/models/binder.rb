# == Schema Information
#
# Table name: binders
#
#  id          :integer          not null, primary key
#  key         :string(255)      not null
#  name        :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_binders_on_key  (key) UNIQUE
#

class Binder < ApplicationRecord
  has_many :reports, inverse_of: :binder
  has_many :histories, inverse_of: :binder
end
