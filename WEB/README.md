# JBADMIN - WEB

## Setup
- Setup Google API & get client_secret.json
- add sheet ids to .env file
  ```
  APP_NAME=Admin
  PRINTER_SHEET_ID_OLD=xxx
  PRINTER_SHEET_ID=xxx

  STATUS_CSV_ID=xxx
  ```
- format views to display sheets properly

## PDFtoText
- masOS   : brew cask install pdftotext
- Centos 7: yum install poppler-utils
- Debian  : apt-get install poppler-utils


```
$ bundle install

# start server
$ shotgun
```

## Authorize Google API
- You'll need to authorize google api first
- Follow instructions here: [Google Sheets API - Ruby](https://developers.google.com/sheets/api/quickstart/ruby)

### Notes

```
# Initialize Sheet
sheet = JbAdmin::Sheets.new( ENV['PRINTER_SHEET_ID'], 'A2:I' )

# Get data
sheet.get_data
```
```
curl -u user:pass http://127.0.0.1:3000
```
