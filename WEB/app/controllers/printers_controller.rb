class PrintersController < ApplicationController

  get "/jbadmin/printers" do
    printer_sheet_api = JbAdmin::Sheets.new( ENV['PRINTER_SHEET_ID'], 'A2:I' )
    @printers = printer_sheet_api.get_data

    erb :"/printers/index.html"
  end
end
