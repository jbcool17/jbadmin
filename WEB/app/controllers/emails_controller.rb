class EmailsController < ApplicationController

  # Upload
  get "/jbadmin/emails" do
    erb :"/emails/emails"
  end

  # Post and Process
  post "/jbadmin/emails" do
    if params[:pdf] && params[:pdf][:filename]
      filename = "#{Time.now.strftime("%Y%m%d%H%M%S")}-#{params[:pdf][:filename]}"
      file = params[:pdf][:tempfile]
      path = "./public/uploads/#{filename}"

      File.open(path, 'wb') do |f|
        f.write(file.read)
      end

      # Run Process Script
      system("./script #{path}")
      # FileUtils.cp(path, "./public/uploads/OUT-#{filename}")
      f_noext = File.basename(path, '.pdf')
      redirect "/jbadmin/emails/EMAILS-#{f_noext}.txt"
    end

  end

  # Download Link
  get "/jbadmin/emails/:output" do
    @file = params[:output]
    @file_link = "/jbadmin/download/#{@file}"

    erb :"/emails/emails_output"
  end

  # Download Action
  get "/jbadmin/download/:filename" do |filename|
    send_file "./public/downloads/#{params[:filename]}", :filename => filename, :type => 'Application/oclet-stream'
  end
end
