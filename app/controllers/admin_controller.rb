class AdminController < ApplicationController
	def index
		redirect_to sites_path if signed_in?
	end
	def logout
		self.current_user = nil
		redirect_to '/admin'
	end
	def callback
		auth = request.env['omniauth.auth']  
		@user = User.find_or_create_by(:provider=>auth['provider'], :uid=>auth['uid'])
		@user.name = auth['user_info']['name'] rescue 1
		@user.email = auth['extra']['user_hash']['email'] rescue 1
		@user.save
		self.current_user = @user
		
		# render :text=>auth.to_yaml
  		# render :text=>"Hello, #{@user.name}"
		redirect_to sites_path
	end
end
