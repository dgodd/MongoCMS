class Page
  include Mongoid::Document
  field :title
  field :position
  field :body
  embeds_many :assets
  embeds_one :form
  referenced_in :site

  def to_s
    title? ? title : '(unknown)'
  end
  def to_url
    "/pages/#{self.id}"
  end
  def body_html
    body.html_safe
  end
  def form_html(csrf_token=nil)
    return nil unless form && form.inputs.length>0
    html = "<form action='/contact' method='post' style='margin:1em 0;'><input type='hidden' name='authenticity_token' value='#{csrf_token}'><input name='contact[page_id]' value='#{self.id}' type='hidden'><table cellpadding='10' cellspacing='10' border='0'>"
    form.inputs.each do |n|
      html += "<tr><th style='text-align:right;'>#{n}</th><td><input type='text' name='contact[#{n}]'></td></tr>"
    end
    html += "<tr><th>&nbsp;</th><td><input type='submit' value='Send'></td></tr>"
    html += "</table></form>"
    html
  end
  def to_drop
    pd = PageDrop.new
    pd.page = self
    pd
  end
  def to_html(layout=true,notice=nil,csrf_token=nil)
    pd = self.to_drop
    mid = Liquid::Template.parse(self.layout).render('page'=>pd, 'notice'=>notice)
    mid += self.form_html(csrf_token).to_s.html_safe
    if layout then
      Liquid::Template.parse(self.site.layout).render('page'=>pd, 'notice'=>notice, 'site'=>self.site, 'yield'=>mid)
    else
      mid
    end
  end
  def layout
    "<h1>{{page.title}}</h1><div>{{page.body}}</div>"
  end
end
