ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'csv'
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'pry'
require 'fileutils'
require 'dotenv/load'
require 'net/ping'


Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
require_all 'lib'
