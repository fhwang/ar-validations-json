ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  exit e.status_code
end

require 'active_record'
require 'active_record/base'
require 'json'
require 'logger'
require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ar-validations-json'

ActiveRecord::Base.logger = Logger.new(
  File.dirname(__FILE__) + '/log/test.log'
)
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3', :database => 'test/db/test.sqlite3'
)
