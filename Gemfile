source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'pg'
gem 'jquery-rails'
gem 'unicorn'
gem "twitter-bootstrap-rails"
gem "less-rails"
gem 'opentok'
gem 'haml'
gem 'annotate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem "therubyracer", platforms: :ruby
end

group :development do
  gem 'capistrano', '= 2.9.0' # Higher versions do not work on uat
  gem 'rvm-capistrano', '= 1.1.0' # Higher versions do not work on uat
end

group :test do
  gem 'factory_girl_rails'
  gem 'annotate'
  gem 'rr'
  gem 'forgery'
  gem "shoulda-matchers", "= 1.4.1"
end

gem 'rspec-rails', group: [:development, :test]