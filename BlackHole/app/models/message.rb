class Message
  include Mongoid::Document
  field :email, type: String
  field :topic, type: String
  field :msg, type: String
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:msg, :topic, :email, presence: true)
  validates(:email, format: { :with => EMAIL_REGEX })
  validates(:msg, length: { :maximum => 1024 } )
end
