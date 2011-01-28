class Template
  include Mongoid::Document
  field :name
  embeds_many :inputs
  references_many :pages
end
