class WordSerializer < ActiveModel::Serializer
  attributes :id, :content, :messages

  has_many :answers
end
