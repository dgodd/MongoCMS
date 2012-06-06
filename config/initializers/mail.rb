# ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :user_name => "app2392207@heroku.com",
  :password => "aurium",
  :domain => "lypc.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
