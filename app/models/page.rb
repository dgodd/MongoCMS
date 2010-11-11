class Page
  include Mongoid::Document
  field :title
  field :body
  embeds_many :assets
  referenced_in :site

  def body_html
    RedCloth.new(body).to_html.html_safe
  end
end
