module ActivitiesHelper
  def activity_link_to object
    resources = object.split "|"
    content, url = resources[0].split ","
    activity_text = url.nil? ? "#{content}" : "<a href='#{url}'>#{content}</a>"
    if resources.size > 1
      next_object = activity_link_to resources[1..-1].join("|")
      activity_text = "#{activity_text} #{t :of} #{next_object}"
    end
    activity_text
  end
end
