group = Group.create!(name: 'First group')

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

User.create!(groups: [group])
User.create!(groups: [group])
User.create!(groups: [group])
