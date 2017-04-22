# == Schema Information
#
# Table name: group_users
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  group_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_group_users_on_group_id  (group_id)
#  index_group_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_1486913327  (user_id => users.id)
#  fk_rails_a9d5f48449  (group_id => groups.id)
#

class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
