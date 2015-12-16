class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :created_at, :updated_at, :avatar

  has_many :activities

  def avatar
    if object.avatar.present?
      if Rails.env.production?
        object.avatar.to_s
      else
        root_url + object.avatar.to_s[1..-1]
      end
    else
      ""
    end
  end
end
