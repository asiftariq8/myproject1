source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.8", ">= 7.0.8.7"
gem 'devise'
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "turbo-rails"
gem 'sassc-rails'
gem "bootstrap", "~> 5.3.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
    gem "web-console"

  
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
