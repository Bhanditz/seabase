require "bundler"
require "rake"
require "rspec"
require "git"
require "rspec/core/rake_task"
require "active_record"
require "sinatra/activerecord/rake"
require_relative "lib/seabase"

task default: :spec

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*spec.rb"
end

include ActiveRecord::Tasks
ActiveRecord::Base.configurations =
  YAML.load(ERB.new(File.read("config/database.yml")).result)

namespace :db do
  desc "create all the databases from config.yml"
  namespace :create do
    task(:all) do
      DatabaseTasks.create_all
    end
  end

  desc "drop all the databases from config.yml"
  namespace :drop do
    task(:all) do
      DatabaseTasks.drop_all
    end
  end

  desc "redo last migration"
  task redo: %w(db:rollback db:migrate)
end

desc "prepares everything for tests"
task :testup do
  system("rake db:migrate SEABASE_ENV=test")
  system("rake seed SEABASE_ENV=test")
end

desc "create release on github"
task(:release) do
  require "git"
  begin
    g = Git.open(File.dirname(__FILE__))
    new_tag = Seabase.version
    g.add_tag("v.#{new_tag}")
    g.add(all: true)
    g.commit("Releasing version #{new_tag}")
    g.push
  rescue Git::GitExecuteError
    puts "'v.#{new_tag}' already exists, update your version."
  end
end


desc "open an irb session preloaded with this library"
task :console do
  sh "irb -I lib -I extra -r seabase.rb"
end
