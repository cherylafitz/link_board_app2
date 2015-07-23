class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments

  validates :link,
  presence: true,
  format: {:with => URI::regexp(%w(http https))}

  validates :title,
  presence: true,
  length: { in: 1..20 }

end

