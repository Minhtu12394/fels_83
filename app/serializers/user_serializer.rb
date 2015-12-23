class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :created_at, :updated_at, :avatar,
    :auth_token, :learned_words

  has_many :activities

  private
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

  def auth_token
    current_user.auth_token if current_user == self.object
  end

  def learned_words
    Word.learned(object.id).size
  end
end
