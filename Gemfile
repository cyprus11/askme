source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'recaptcha'
gem 'rails_12factor'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5.2.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'ed25519',  '>= 1.2', '< 2.0'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-bundler', '~> 2.0'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
