class Page
  include Mongoid::Document
  field :title
  field :slugs, :type=>Array
  field :position, :type=>Integer
  field :parent_id, :type=>BSON::ObjectId
  def parent ; Page.find(parent_id) if parent_id ; end
  def children ; Page.where(:parent_id=>self.id).order_by(:position.asc,:name.asc) ; end
  def children? ; children.count>0 ; end
  field :published, :type=>Boolean
  field :body
  embeds_many :assets
  embeds_one :form
  referenced_in :site
  referenced_in :template

  def to_s
    title? ? title : '(unknown)'
  end
  def to_url
    "/pages/#{self.id}"
  end
  def body_html
    body.html_safe
  end
  def form_fields ; form ? form.inputs.join(', ') : '' ; end
  def form_fields=(inp)
	arr = inp.to_s.split(/\s*,\s*/)
	if arr.length>0 then
		self.form ||= Form.new
		self.form.inputs = inp.split(/\s*,\s*/)
	else
		self.form = nil
	end
  end
  def form_html(csrf_token=nil)
    return nil unless form && form.inputs.length>0
    form.to_html(csrf_token)
  end
  def to_drop
    pd = PageDrop.new
    pd.page = self
    pd
  end
  def breadcrumb_html(link=false)
    out = parent ? parent.breadcrumb_html(true) : ''
    out + " &raquo; ".html_safe + (link ? "<a href='#{self.to_url}'>#{self}</a>" : self.to_s)
  end
  def to_html(layout=true,notice=nil,csrf_token=nil)
    pd = self.to_drop
    mid = Liquid::Template.parse(self.layout).render('page'=>pd, 'notice'=>notice)
    mid += self.form_html(csrf_token).to_s.html_safe
    if children? || (parent && parent.children?) then
      pages = (children? ? children : parent.children).where(published:true)
      mid = "<div id='sublinks'>" + pages.collect { |p| "<a href='#{p.to_url}'>#{p}</a>" }.join('')  + "<div style='clear:both;'<!-- --></div></div>" + mid if pages.length>1 || pages[0]!=self
      mid = "<div>#{breadcrumb_html}</div>" + mid if parent
    end
    if layout then
      Liquid::Template.parse(self.site.layout).render('page'=>pd, 'notice'=>notice, 'site'=>self.site, 'yield'=>mid)
    else
      mid
    end
  end
  def layout
    "<title>#{site.name} - {{page.title}}</title><h1>{{page.title}}</h1><div>{{page.body}}</div>"
  end
end
