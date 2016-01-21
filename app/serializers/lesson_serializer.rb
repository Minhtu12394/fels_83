class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :words

  def words
    object.results.map do |result|
      WordLessonSerializer.new result.word, scope: scope, root: false,
        result: result
    end
  end

  def name
    "##{id}"
  end
end
