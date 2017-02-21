class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :photo, :learned_words

  private
  def photo
    if object.photo.present?
      if Rails.env.production?
        object.photo.to_s
      else
        root_url + object.photo.to_s[1..-1]
      end
    else
      ""
    end
  end

  def learned_words
    object.words.learned(current_user.id).size
  end
end
