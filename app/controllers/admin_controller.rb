class AdminController < ApplicationController
	def index
		redirect_to '/auth/facebook'
	end
	def callback
		auth = request.env['omniauth.auth']  
		@user = User.find_or_create_by(:provider=>auth['provider'], :uid=>auth['uid'])
		@user.name = auth['user_info']['name'] rescue 1
		@user.email = auth['extra']['user_hash']['email'] rescue 1
		@user.save
		current_user = @user
		
		# render :text=>auth.to_yaml
  		render :text=>"Hello, #{@user.name}"
	end
end
