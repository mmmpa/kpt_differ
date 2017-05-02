Report.delete_all
Binder.delete_all
GroupUser.delete_all
Group.delete_all
User.delete_all

kpt = Group.create!(name: 'KPT')
weekly = Group.create!(name: 'Weekly Report')

%w(
  Keep
  Problem
  Try
).each do |name|
  Binder.create!(
    group: kpt,
    key: name.downcase,
    name: name,
    description: name
  )
end

[
  'Last 2 Weeks',
  'Next 2 Weeks'
].each do |name|
  Binder.create!(
    group: weekly,
    key: name.tr(' ', '_').downcase,
    name: name,
    description: name
  )
end


20.times do |n|
  groups = if (n % 3) == 0
             [kpt]
           else
             [kpt, weekly]
           end

  User.create!(
    name: "ユーザー #{n}",
    groups: groups
  )
end
