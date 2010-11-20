class ContactController < ApplicationController  
  respond_to :html, :xml, :json  

  def create  
    @contact = Contact.new(params[:contact])  
    if @contact.save  
      flash[:notice] = "Thankyou for contacting us."  
    end  
    respond_with(@contact.page)
  end  
end
