class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :categories, dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true
end
