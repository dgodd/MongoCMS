class PagesController < ApplicationController
  respond_to :html, :xml, :json
  load_and_authorize_resource :except=>[:root,:show]

  def index
    @pages = Page
    @pages = @pages.where(:site_id=>params[:site_id]) if params[:site_id]
    @pages = @pages.all
    respond_with @pages
  end

  def show
    id = BSON::ObjectId(params[:id]) rescue id = params[:id]
    @page ||= Page.any_of({:_id=>id}, {:slug=>params[:id]}).first

    if false && @page.site && dom=@page.site.domains.first then
      unless request.host==dom || request.host=="www.#{dom}" then
        redirect_to "http://www.#{dom}#{@page.to_url}" and return
      end
    end

    if @page.site && @page.site.layout.present? then
      session[:_csrf_token] ||= ActiveSupport::SecureRandom.base64(32) if @page.form
      render :text=>@page.to_html(!request.xhr?, flash[:notice], session[:_csrf_token])
    else
      respond_with @page
    end
  end
  def root
    @page = Page.where(:site_id=>current_site.id, :published=>true).asc(:position).first
    show
  end

  def new
    @page = Page.new(params[:page])
    respond_with @page
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      #cookies[:last_page_id] = @page.id
      flash[:notice] = "Successfully created page."
    end
    respond_with(@page, :location=>edit_page_path(@page))
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
    respond_with(@page, :location=>edit_page_path(@page))
  end

  def add_asset
    @page = Page.find(params[:id])
    a = Asset.new(:filename=>params[:qqfile])
    f = request.env['rack.input']
    f.rewind
    a.file = f
    @page.assets << a
    @page.save
    # logger.warn request.env
    ## https://github.com/valums/file-uploader/blob/master/server/perl.cgi
    render :text=>'{ "success": true }'
  end
  def positions
    # render :text=>params.to_yaml and return
    parent = Page.find(params[:parent])
    params[:order].each_with_index do |id,idx|
      p = Page.find(id)
      if p && p != parent then
        p.parent_id = parent ? parent.id : nil
        p.position = idx
        p.save
      end
    end
    render :text=>'OK'
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    respond_with(@page, :location=>"/sites/#{@page.site.id}/edit")
  end
end
