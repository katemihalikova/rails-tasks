class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks

  validates :title, presence: true
  validates :color, presence: true
  validates :user, presence: true
end