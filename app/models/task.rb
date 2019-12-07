class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :user, presence: true
  validates :is_done, presence: true
end
