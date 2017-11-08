source 'https://rubygems.org'
ruby '2.3.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

gem 'dotenv-rails'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
end

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'
gem 'omniauth-github'

gem 'rails_admin', '~> 1.2.0'
gem 'font-awesome-rails'

gem 'will_paginate'
gem 'will_paginate-bootstrap4'

gem 'bootstrap', '~> 4.0.0.beta.2.1'
source 'https://rails-assets.org' do
  gem 'rails-assets-datetimepicker'
#  gem 'rails-assets-tether', '>= 1.4.0'
end

gem 'bugsnag'
gem 'cancancan'

gem 'carrierwave'
gem 'fog'
gem "fog-aws"

gem 'particlerb', '~> 1.4.0'
gem 'delayed_job_active_record'

gem 'stopwords-filter', require: 'stopwords'
gem 'stemmify'
gem 'ruby-fann'
gem 'sparse_array'

gem 'pycall'
