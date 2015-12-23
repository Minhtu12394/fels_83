class WordSerializer < ActiveModel::Serializer
  attributes :id, :content, :result_id

  has_many :answers

  private
  def result_id
    @options[:result].try :id
  end
end
