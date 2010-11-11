require 'openid/store/filesystem'  
require 'omniauth/openid'
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, "CONS_KEY", "CONS_SECRET"
  provider :facebook, "155171474526611", "4b7c98eda968f3ec9bb15c8d20a49416"
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp') # , :domain=>'mail.google.com'
  use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'yahoo', :identifier => 'yahoo.com' 
  use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id' 
end
