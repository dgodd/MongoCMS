class Notifier < ActionMailer::Base
  def contact_form(form)
    mail(:to=>'catherine@liveyourpassion.com.au', :bcc=>'dave@goddard.id.au', :from=>form.site.info_email, :subject=>'Contact Form') do |format|
      format.html { render :text=>form.to_html }
    end
  end
end
