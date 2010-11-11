class User
  include Mongoid::Document
  field :provider
  field :uid
  field :name
  field :email
  index [ :provider, :uid ], :unique=>true

  def to_s
    name || email || "ID:#{id}"
  end
end

