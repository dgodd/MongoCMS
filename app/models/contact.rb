class Contact
  include Mongoid::Document
  #field :page_id
  referenced_in :page

  def site ; page.site ; end
  def to_html
    html = "<table cellpadding='0' cellspacing='0' border='0'>"
    html += "<tr><th>Site</th><td>#{page.site}</td></tr>"
    html += "<tr><th>Page</th><td>#{page}</td></tr>"
    page.form.inputs.each do |n|
      html += "<tr><th>#{n}</th><td>#{self[n]}</td></tr>"
    end
    html += "<tr><th>Page</th><td>#{page}</td></tr>"
    html += "</table>"
  end
end
