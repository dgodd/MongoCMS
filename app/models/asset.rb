class Asset
  include Mongoid::Document
  field :oid #, :type=>BSON::ObjectID
  field :filename
  # embedded_in :site, :inverse_of=>:assets
  embedded_in :page, :inverse_of=>:assets
end

