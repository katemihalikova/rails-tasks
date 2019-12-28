class Tag < ApplicationRecord
  belongs_to :user
  has_many :tags_tasks, dependent: :destroy
  has_many :tasks, through: :tags_tasks

  validates :title, presence: true
  validates :color, presence: true
  validates :user, presence: true
end
