require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/unit/*_test.rb']
  t.verbose = true
end

ActiveRecordVersions = %w(3.2.2 3.1.4 3.0.12)

desc "Run all tests for all supported versions of ActiveRecord"
task :all_tests do
  ActiveRecordVersions.each do |ar_version|
    cmd = "ACTIVE_RECORD_VERSION=#{ar_version} rake test"
    puts cmd
    puts `cd . && #{cmd}`
    puts
  end
end

task :default => :all_tests

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ar-validations-json"
  gem.homepage = "http://github.com/fhwang/ar-validations-json"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "sera@fhwang.net"
  gem.authors = ["Francis Hwang"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

