source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'acts-as-taggable-on', '~> 4.0'
gem 'annotate'
gem 'bugsnag'
gem 'faker'
gem 'graphql'
gem 'graphql-query-resolver'
gem 'search_object'
gem 'search_object_graphql'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'rack-cors'
gem 'scrypt'

group :development, :test do
  gem "bundler-audit", require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem "rubocop", require: false
  gem "rubycritic", require: false
  gem "simplecov", require: false
  gem "yard", require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

end

group :test do
  gem "minitest"
  gem "vcr"
  gem "webmock", "~> 3.3.0"
end

gem 'tzinfo-data'
