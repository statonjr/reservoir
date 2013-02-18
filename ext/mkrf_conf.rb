require 'rubygems'
require 'rubygems/command.rb'
require 'rubygems/dependency_installer.rb'
begin
  Gem::Command.build_args = ARGV
rescue NoMethodError
end
inst = Gem::DependencyInstaller.new
begin
  case RbConfig::CONFIG['RUBY_INSTALL_NAME']
  when "jruby"
    inst.install "jdbc-postgres"
  when "ruby"
    inst.install "pg"
  end
rescue
  exit(1)
end
