source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'

gem 'active_model_serializers'
gem 'activerecord-import'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :default do
  gem 'authlogic'
  gem 'jquery-rails'
  gem 'kaminari'
  gem 'markdiff'
  gem 'redcarpet'
  gem 'pygments.rb'
  gem 'slim-rails'
  gem 'sweet-alert-confirm'
  gem 'therubyracer'
  gem 'rack-cors', :require => 'rack/cors'
  gem 'html2slim'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'metric_fu', require: false
end

group :development, :test do
  gem 'foreman'
  gem 'tanemaki'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
end

group :development do
  gem 'bullet'
  gem 'annotate'
  gem 'awesome_print'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rails_best_practices'

  gem 'onkcop', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter'
  gem 'coveralls'
  gem 'faker'
  gem 'poltergeist'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-html-matchers'
  gem 'simplecov'
  gem 'simplecov-rcov'
end
