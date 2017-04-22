group = Group.create!(name: 'KPT')

%w(
  Keep
  Problem
  Try
).each do |name|
  Binder.create!(
    group: group,
    key: name.downcase,
    name: name,
    description: name
  )
end

20.times do |n|
  User.create!(
    name: "ユーザー #{n}",
    groups: [group]
  )
end
