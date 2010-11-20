class Form
  include Mongoid::Document
  include Mongoid::Timestamps
  field :inputs, :type=>Array
  embedded_in :page, :inverse_of=>:form
end

