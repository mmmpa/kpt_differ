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
end
