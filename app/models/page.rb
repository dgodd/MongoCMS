class Page
  include Mongoid::Document
  field :title
  field :position
  field :body
  embeds_many :assets
  referenced_in :site

  def to_s
    title? ? title : '(unknown)'
  end
  def body_html
    RedCloth.new(body).to_html.html_safe
  end
  def to_drop
    pd = PageDrop.new
    pd.page = self
    pd
  end
  def to_html(layout=true)
    pd = self.to_drop
    mid = Liquid::Template.parse(self.layout).render('page'=>pd)
    if layout then
      Liquid::Template.parse(self.site.layout).render('page'=>pd, 'site'=>self.site, 'yield'=>mid)
    else
      mid
    end
  end
  def layout
    "<h1>{{page.title}}</h1><div>{{page.body}}</div>"
  end
end
