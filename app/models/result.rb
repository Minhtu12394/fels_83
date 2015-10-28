class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :answer
end
