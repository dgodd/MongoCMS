class Page
  include Mongoid::Document
  field :title
  field :position
  field :body
  embeds_many :assets
  referenced_in :site

  def to_s
    title
  end
  def body_html
    RedCloth.new(body).to_html.html_safe
  end
end
