class Form
  include Mongoid::Document
  include Mongoid::Timestamps
  field :inputs, :type=>Array
  embedded_in :page, :inverse_of=>:form

  def to_html(csrf_token=nil)
    return nil unless inputs && inputs.length>0
    html = "<form action='/contact' method='post' style='margin:1em 0;'><input type='hidden' name='authenticity_token' value='#{csrf_token}'><input name='contact[page_id]' value='#{self.page._id}' type='hidden'><table cellpadding='10' cellspacing='10' border='0'>"
    inputs.each do |n|
      html += "<tr><th style='text-align:right;'>#{n}</th><td><input type='text' name='contact[#{n}]'></td></tr>"
    end
    html += "<tr><th>&nbsp;</th><td><input type='submit' value='Send'></td></tr>"
    html += "</table></form>"
    html
  end
end

