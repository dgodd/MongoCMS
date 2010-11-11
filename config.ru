# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use OmniAuth::Builder do
  #provider :twitter, "CONS_KEY", "CONS_SECRET"
  provider :facebook, "155171474526611", "4b7c98eda968f3ec9bb15c8d20a49416"
  # provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
run MongoCMS::Application
