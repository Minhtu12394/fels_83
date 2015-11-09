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
end
