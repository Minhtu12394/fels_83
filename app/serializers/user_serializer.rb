class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :created_at, :updated_at

  has_many :activities
end
