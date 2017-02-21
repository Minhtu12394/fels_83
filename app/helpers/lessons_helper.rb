module LessonsHelper
  def result_status answer
    if answer.nil?
      "default"
    elsif answer.is_correct
      "success"
    else
      "danger"
    end
  end

  def rate_result_lesson lesson
    "#{[lesson.answers.correct.size, lesson.answers.size].join("/")} #{I18n.t("words")}"
  end
end
