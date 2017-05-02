Report.order(id: :desc).each(&:delete)
History.delete_all

kpt = Group.find_by(name: 'KPT')
weekly = Group.find_by(name: 'Weekly Report')

[5, 4, 3, 2, 1].each do |n|
  kpt.start_span!(at: Time.zone.now - n.weeks)
  weekly.start_span!(at: Time.zone.now - n.weeks)
end

Report.all.each do |report|
  report.update!(
    body: SecureRandom.uuid
  )
end