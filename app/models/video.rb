class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :link, type: String, :default => ""
  field :email, type: String, :default => ""
  field :visible, type: Boolean, :default => false
#  field :created_at, type: DateTime  # Add this line

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:link, :email, presence: true)
  validates(:email, format: { :with => EMAIL_REGEX })
end
