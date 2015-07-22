class Post < ActiveRecord::Base
  belongs_to :user

  validates :title,
  presence: true,
  length: { in: 1..20 }

  validates_presence_of :link, on: :create

end

