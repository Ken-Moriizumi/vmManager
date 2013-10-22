source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'execjs'
gem 'therubyracer'
gem 'rbvmomi'

group :development, :test do
  gem 'spring'
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false, git: 'https://github.com/cucumber/cucumber-rails.git'
  gem 'factory_girl_rails'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'

  #gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i # OSXの場合のみ、ファイル変更検知のため（それ以外の環境ではポーリングになる）
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-coffeescript' # app/assets以下はRailsが自動的にコンパイルしてくれるが、テスト用コードは対象外なので、これを入れる

  gem 'capybara', git: 'https://github.com/jnicklas/capybara.git'
end

gem 'sidekiq' 
