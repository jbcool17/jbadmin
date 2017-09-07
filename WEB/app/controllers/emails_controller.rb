class EmailsController < ApplicationController

  # Upload
  get "/jbadmin/emails" do
    erb :"/emails/emails"
  end

  # Post and Process
  post "/jbadmin/emails" do
    if params[:pdf] && params[:pdf][:filename] && File.extname(params[:pdf][:filename]) == '.pdf'

      filename = "#{Time.now.strftime("%Y%m%d%H%M%S")}-#{params[:pdf][:filename]}"
      file = params[:pdf][:tempfile]
      path = "./public/uploads/#{filename}"

      File.open(path, 'wb') do |f|
        f.write(file.read)
      end

      # Run Process Script
      system("./scripts/parse-emails-from-pdf #{path}")

      # Output Link to File
      f_noext = File.basename(path, '.pdf')
      "<a href=\"/jbadmin/downloads/EMAILS-#{f_noext}.txt\">EMAILS-#{f_noext}.txt"
    else
      "An Error Occured."
    end

  end

  # Download Action
  get "/jbadmin/downloads/:filename" do |filename|
    send_file "./public/downloads/#{params[:filename]}", :filename => filename, :type => 'Application/oclet-stream'
  end
end
