# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  hex        :string(255)      not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :reports
  has_many :group_users, inverse_of: :user
  has_many :groups, through: :group_users, inverse_of: :users
  has_many :binders, through: :groups, inverse_of: :users
end
