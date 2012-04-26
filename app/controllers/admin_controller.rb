class AdminController < ApplicationController
  def index
    redirect_to sites_path and return if signed_in?
    redirect_to 'http://lypc.herokuapp.com/admin' and return unless request.host=='lypc.herokuapp.com' || request.host=='localhost'
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

    # render :text=>auth.to_yaml
    # render :text=>"Hello, #{@user.name}"

    if ['catherine@liveyourpassion.com.au', ''].include?(@user.email)
      self.current_user = @user
      redirect_to sites_path
    else
      flash[:notice] = 'Only Catherine can login'
      redirect_to '/'
    end
  end
end
