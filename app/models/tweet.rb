class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :reposts, class_name: "Tweet", foreign_key: "repost_id"
  belongs_to :repost, class_name: "Tweet", optional: true
  validates :content, presence: true
  scope :tweets_for_me, ->(friends) {where(user_id: friends)}

end
