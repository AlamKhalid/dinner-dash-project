# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :email, presence: true
  validates :email, uniqueness: true
  validates :display_name, length: { in: 2..32 }, if: ->(user) { user.display_name&.length&.positive? }
  validates :role, inclusion: 0..1

  enum role: {
    normal: 0,
    admin: 1
  }, _prefix: true

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
end
