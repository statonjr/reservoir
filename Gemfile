# source 'http://apps.hendrickauto.com/stockpile'
source 'https://rubygems.org'

gem 'motor', :path => '../motor'

platform :jruby do
  gem "neo4j"
  gem "jdbc-postgres"
end

platform :mri_19 do
  gem 'pg'
end

group :development do
  gem 'pry'
  gem 'geminabox'
end

group :test do
  gem 'rspec'
end

gemspec
