class Activity < ActiveRecord::Base
  belongs_to :user
  validates :behavior, presence: true

  scope :feed_activities_by, ->user_id{where "user_id in (select id from users
    where id = #{user_id} or id in (select followed_id from relationships
      where follower_id = #{user_id}))"}

  scope :activities_by, ->user_id{where "user_id = #{user_id}"}
end
