class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results

  before_create :create_words

  private
  def create_words
    self.words = self.category.words.order("RAND()").limit 20
  end
end
