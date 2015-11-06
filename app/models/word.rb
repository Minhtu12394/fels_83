class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  validates :content, presence: true, length: {minimum: 3}
  before_save :must_be_a_answer_correct

  private
  def must_be_a_answer_correct
    unless self.answers.select{|answer| answer.is_correct}.size == 1
      errors.add " ", I18n.t("message.must_a_answer_correct")
    end
  end
end
