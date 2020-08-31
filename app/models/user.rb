class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by(username: slug.split("-").join(" "))
  end
end
