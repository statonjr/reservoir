require "bundler/gem_tasks"
require 'lib/reservoir/version'

desc "Deploy to Stockpile"
task :deploy => [:build] do
  sh "gem inabox pkg/reservoir-#{Reservoir::VERSION}.gem -g http://apps.hendrickauto.com/stockpile"
end
