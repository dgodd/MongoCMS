class PagesController < ApplicationController  
  respond_to :html, :xml, :json  
  load_and_authorize_resource
    
  def index  
    @pages = Page
    @pages = @pages.where(:site_id=>params[:site_id]) if params[:site_id]
    @pages = @pages.all
    respond_with @pages
  end  
    
  def show  
    @page = Page.find(params[:id])  

    ## FIXME ; first assumes html layout
    if @page.site && @page.site.layout.present? then
      render :text=>@page.to_html(true)
    else
      respond_with @page  
    end
  end  
  
  def new  
    @page = Page.new  
    respond_with @page  
  end  
    
  def create  
    @page = Page.new(params[:page])  
    if @page.save  
      #cookies[:last_page_id] = @page.id  
      flash[:notice] = "Successfully created page."  
    end  
    respond_with(@page)  
  end  
  
  def edit  
    @page = Page.find(params[:id])  
    respond_with(@page)  
  end  
  
  def update  
    @page = Page.find(params[:id])  
    if @page.update_attributes(params[:page])  
      flash[:notice] = "Successfully updated page."  
    end  
    respond_with(@page)  
  end  
    
  def destroy  
    @page = Page.find(params[:id])  
    @page.destroy  
    flash[:notice] = "Successfully destroyed page."  
    respond_with(@page)  
  end  
end  
