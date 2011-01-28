class Input
  include Mongoid::Document
  field :name
  field :edit_type, :type=>Integer, :default=>1
  ## Text, TextArea
  embedded_in :template, :inverse_of=>:inputs
end

