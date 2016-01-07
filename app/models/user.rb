class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true

  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :username, case_sensitive: false

  validates :username, length: { maximum: 30 }
  validate :username_is_valid

  has_many :books

  def to_param
    username
  end

  private

  def username_is_valid
    unless username.match(/\A[a-zA-Z0-9]*\z/)
      errors.add(:username, 'cannot contain special characters')
    end
  end
end
