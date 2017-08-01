require "rubygems"
require "rest_client"
require "json"

# Your freshdesk domain
fd_domain = 'jb'

# It could be either your user name or api_key.
user_name_or_api_key = 'G0Me9hQqvBV4vCizhZNb'

# If you have given api_key, then it should be x. If you have given user name, it should be password
password_or_x = 'X'

api_path = "api/v2/tickets"

ticket_id = 12

api_url  = "https://#{fd_domain}.freshdesk.com/#{api_path}/#{ticket_id}"

site = RestClient::Resource.new(api_url, user_name_or_api_key, password_or_x)

begin
  response = site.get(:accept=>'application/json')
  puts "response_code: #{response.code} \n response_body: #{response.body} \n"
rescue RestClient::Exception => exception
  puts "API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id"
  puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
  puts "Response Code: #{exception.response.code} \n Response Body: #{exception.response.body} \n"
end
