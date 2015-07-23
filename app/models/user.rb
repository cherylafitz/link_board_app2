class User < ActiveRecord::Base

  has_secure_password

  # posts i created
  has_many :posts
  # votes i created
  has_many :ratings, class_name: 'Vote'
  # votes about me
  has_many :votes, as: :votable
  has_many :comments

  validates :email,
  presence: true,
  uniqueness: {case_sensitive:false},
  format: {with: /@/}

  # validates :my_email_attribute, :email => true

  validates_presence_of :password, on: :create

  validates :name,
  presence: true,
  length: { maximum: 20 }


  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
