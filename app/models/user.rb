class User
  include Mongoid::Document
	
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  field :login, type: String, :default => ""
  field :email, type: String, :default => ""
  field :password, type: String, :default => ""
  #field :password_confirmation, type: String, :default => ""
  field :encrypted_password, type: String
  field :salt, type: String

  validates(:login, :email, uniqueness: true)
  validates(:email, format: { :with => EMAIL_REGEX })
  validates(:login, length: { :maximum => 64, :minimum => 6 } )
  validates(:encrypted_password, length: { :minimum => 6 }, :confirmation => true, :if => :password )

  before_save :encrypt_password
  
  def has_password?(password_soumis)
	encrypted_password == encrypt(password_soumis)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.find_by_id(id)
    find(id) rescue nil
  end
  def self.find_by_email(email)
  	find(email) rescue nil
  end
  private
    
    def self.authenticate_with_salt(id, cookie_salt)
    	user = find_by_id(id)
    	(user && user.salt == cookie_salt) ? user : nil
    end

    def encrypt_password
      self.encrypted_password = encrypt(encrypted_password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{encrypted_password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
