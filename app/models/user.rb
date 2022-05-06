class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
  validates :email, uniqueness: true
  validates :display_name, length: { in: 2..32 }, unless: ->(user) { user.display_name.length.zero? }

  enum role: {
    user: 0,
    admin: 1
  }, _prefix: true
end
