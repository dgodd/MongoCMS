class Site
  include Mongoid::Document
  field :name
  field :domains, :type=>Array
  field :admins, :type=>Array
  field :layout
  references_many :pages, :inverse_of=>:site
  embeds_many :assets

  def to_s
    name
  end
  def domains_txt ; domains.join(' ') ; end
  def domains_txt=(inp) ; domains = inp.to_s.split(/\s+/) ; end
  def to_liquid
    { 'name'=>name, 'domain'=>domains.first, 'pages'=>lambda { pages.where(:published=>true, :parent_id=>nil).order_by(:position.asc,:name.asc).collect { |p| { 'title'=>p.title, 'url'=>p.to_url, 'has_children'=>p.children?, 'children'=>p.children.collect { |p2|  { 'title'=>p2.title, 'url'=>p2.to_url } } } } } }
  end
  def info_email
    "info@#{domains.first}"
  end
end
