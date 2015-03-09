require 'rails/generators/base'
class FirstmilerSmsOauthGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def migration
    template 'sms_oauth_token.rb',
             File.join('db', 'migrate', "#{Time.now.getutc.strftime("%Y%m%d%H%M%S")}_create_sms_oauth_token.rb")
  end
end