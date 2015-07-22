class User < ActiveRecord::Base

  has_secure_password

  has_many :posts

  validates :email,
  presence: true,
  uniqueness: {case_sensitive:false}

  # validates :my_email_attribute, :email => true

  validates_presence_of :password, on: :create

  validates :name,
  presence: true,
  length: { maximum: 20 }


  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
