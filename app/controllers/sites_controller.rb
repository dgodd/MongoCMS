class SitesController < ApplicationController  
  respond_to :html, :xml, :json  
  load_and_authorize_resource
    
  def index  
    @sites = Site.all  
    respond_with @sites  
  end  
    
  def show  
    @site = Site.find(params[:id])  
    respond_with @site  
  end  
  
  def new  
    @site = Site.new  
    respond_with @site  
  end  
    
  def create  
    @site = Site.new(params[:site])  
    if @site.save  
      #cookies[:last_site_id] = @site.id  
      flash[:notice] = "Successfully created site."  
    end  
    respond_with(@site, :location=>edit_site_path(@site))  
  end  
  
  def edit  
    @site = Site.find(params[:id])  
    respond_with(@site)  
  end  
  
  def update  
    @site = Site.find(params[:id])  
    if @site.update_attributes(params[:site])  
      flash[:notice] = "Successfully updated site."  
    end  
    respond_with(@site, :location=>edit_site_path(@site))  
  end  

  def add_asset
    @site = Site.find(params[:id])
    a = Asset.new(:filename=>params[:qqfile])
    f = request.env['rack.input']
    f.rewind
    a.file = f
    @site.assets << a
    @site.save
    # logger.warn request.env
    ## https://github.com/valums/file-uploader/blob/master/server/perl.cgi
    render :text=>'{ "success": true }'
  end
    
  def destroy  
    @site = Site.find(params[:id])  
    @site.destroy  
    flash[:notice] = "Successfully destroyed site."  
    respond_with(@site)  
  end  
end  
