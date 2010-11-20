require 'mime/types'
class Asset
  include Mongoid::Document
  include Mongoid::Timestamps
  field :oid #, :type=>BSON::ObjectID
  field :filename
  field :content_type
  embedded_in :site, :inverse_of=>:assets
  embedded_in :page, :inverse_of=>:assets

  # Accessor to GridFS
  def grid
    @grid ||= Mongo::Grid.new(Mongoid.database)
  end
  def file=(f)
    #self.oid ||= BSON::ObjectID.new()
    g = grid.put(
      f.read,
      :filename => filename,
      :content_type => content_type
      #:_id => oid
    )
    self.oid = g
  end
end

