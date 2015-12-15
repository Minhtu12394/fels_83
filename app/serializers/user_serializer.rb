class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :created_at, :updated_at, :avatar

  has_many :activities

  def avatar
    object.avatar.present? ? root_url + object.avatar.to_s[1..-1] : ""
  end
end
