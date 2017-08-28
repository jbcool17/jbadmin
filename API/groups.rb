require 'google/apis/groupssettings_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'pry'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Groups Settings API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'cs.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "groupssettings-ruby-quickstart.yaml")
SCOPE = Google::Apis::GroupssettingsV1::AUTH_APPS_GROUPS_SETTINGS

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
    client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(
      base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
         "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

# Initialize the API
service = Google::Apis::GroupssettingsV1::GroupssettingsService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize
puts "Enter the email address of a Google Group in your domain:"
group_email = gets.strip
binding.pry
# Print the group settings
response = service.get_group(group_email)
binding.pry
puts "#{response.email} - #{response}"
