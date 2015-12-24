class WordSerializer < ActiveModel::Serializer
  attributes :id, :content, :result_id

  has_many :answers

  def result_id
    @options[:result].id
  end
end
