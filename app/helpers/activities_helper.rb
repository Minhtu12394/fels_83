module ActivitiesHelper
  def activity_link_to object, type = :html
    resources = object.split "|"
    content, url = resources[0].split ","
    activity_text = url.nil? || type == :text ? "#{content}" :
      "<a href='#{url}'>#{content}</a>"
    if resources.size > 1
      next_object = activity_link_to resources[1..-1].join("|"), type
      activity_text = "#{activity_text} #{I18n.t :of} #{next_object}"
    end
    activity_text
  end
end
