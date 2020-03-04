source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'geocoder'
gem 'jsonapi-rails'
gem 'jwt'
gem 'pg'
gem 'puma', '~> 3.12'
gem 'rswag-api'
gem 'rswag-ui'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development, :test do
  gem 'pry'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
