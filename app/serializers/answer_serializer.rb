class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :is_correct
end
