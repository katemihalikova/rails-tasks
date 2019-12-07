class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks

  validates :title, presence: true
  validates :color, presence: true
  validates :user, presence: true
end
