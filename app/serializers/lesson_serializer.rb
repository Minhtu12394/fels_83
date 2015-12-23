class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :words

  private
  def words
    object.results.map do |result|
      WordSerializer.new result.word, scope: scope, root: false, result: result
    end
  end

  def name
    "##{id}"
  end
end
