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

