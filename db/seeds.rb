if ENV['SEED_SPECIFIC_DATA']
  load Rails.root.join('db', 'seeds', "#{ENV['SEED_SPECIFIC_DATA'].downcase}.rb")
  exit 0
end
