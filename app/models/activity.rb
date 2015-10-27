class Activity < ActiveRecord::Base
  belongs_to :user

  validates :behavior, precense: true, length: {minimum: 4}
end
