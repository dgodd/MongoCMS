class Contact
  include Mongoid::Document
  #field :page_id
  referenced_in :page
end
