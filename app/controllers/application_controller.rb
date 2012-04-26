class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :current_site

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to '/' # root_url
  end

  protected
  def current_user
    @current_user ||= User.find(:first, :conditions=>{ :id=>session[:user_id] })
  end
  def signed_in?
    !!current_user
  end
  def current_user=(user)
    @current_user = user
    session[:user_id] = user ? user.id : nil
  end
  def current_site
    @current_site ||= Site.where(:domains=>request.host.gsub(/^www\./,'')).first
    @current_site ||= Site.find('4ce7448b9a779b1421000002')
  end
end
