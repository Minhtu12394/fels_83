class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :words
  
  def name
    "##{id}"
  end
end
