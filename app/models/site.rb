class Site
  include Mongoid::Document
  field :name
  field :domains, :type=>Array
  field :admins, :type=>Array
  references_many :pages
  # embeds_many :assets

  def to_s
    name
  end
end
