class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, confirmation: true, on: :create
  after_initialize :give_session_token
  has_secure_password
  
  has_many :jobs
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  protected
  
    def give_session_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end
