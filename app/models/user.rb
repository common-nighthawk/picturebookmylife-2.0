class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  validates :username, length: { maximum: 30 }
  validate :username_is_valid

  private

  def username_is_valid
    unless username.match(/\A[a-zA-Z0-9]*\z/)
      errors.add(:username, 'cannot contain special characters')
    end
  end
end
