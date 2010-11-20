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
    { 'name'=>name, :domain=>domains.first }
  end
end