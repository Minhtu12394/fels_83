class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :answer
  belongs_to :word

  def base_resource
    "#{self.content}|#{self.lesson.base_resource}"
  end
end
