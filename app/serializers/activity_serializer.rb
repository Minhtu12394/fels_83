class ActivitySerializer < ActiveModel::Serializer
  include ActivitiesHelper

  attributes :id, :content, :created_at

  def content
    content = object.behavior
    if object.object.present?
      content << " " << activity_link_to(object.object, :text)
    end
    content
  end
end
