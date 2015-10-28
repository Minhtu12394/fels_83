class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results, dependent: :destroy

  validates :content, presence: true, length: {maximum: 50}
end
