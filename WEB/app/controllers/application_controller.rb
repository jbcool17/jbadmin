require './config/environment'

class ApplicationController < Sinatra::Base

  # use Rack::Auth::Basic, "Restricted Area" do |username, password|
  #   username == 'admin' and password == 'admin'
  # end

  configure do
    # set :root, File.dirname(__FILE__)
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :views, 'app/views'
  end

  get "/jbadmin" do
    erb :welcome
  end


  get "/jbadmin/status" do
    machines_sheet = JbAdmin::Sheets.new( ENV['STATUS_CSV_ID'], 'A2:C' )
    machines = machines_sheet.get_data

    @outside  = machines.select { |s| s[2] == 'outside' }
    @servers  = machines.select { |s| s[2] == 'server' }
    @printers = machines.select { |s| s[2] == 'printer' }

    erb :status
  end
end
