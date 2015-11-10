class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|answer| answer[:content].blank?}

  scope :all_word, ->user_id{}
  scope :learned, ->user_id{where "id in (select word_id from answers where
    is_correct = '1' and id in (select answer_id from results where lesson_id in (select id from
      lessons where user_id = #{user_id})))"}
  scope :no_learn, ->user_id{where "id not in (select word_id from answers where
    is_correct = '1' and id in (select answer_id from results where lesson_id in (select id from
      lessons where user_id = #{user_id})))"}

  validates :content, presence: true, length: {minimum: 3}
  before_save :must_be_a_answer_correct

  def base_resource
    "#{self.content}|#{self.category.base_resource}"
  end

  private
  def must_be_a_answer_correct
    unless self.answers.select{|answer| answer.is_correct}.size == 1
      errors.add " ", I18n.t("message.must_a_answer_correct")
    end
  end
end
