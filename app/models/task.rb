class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true, counter_cache: true
  has_many :tags_tasks, dependent: :destroy
  has_many :tags, through: :tags_tasks

  validates_presence_of :title
  validates_presence_of :user
  validates_inclusion_of :is_done, in: [true, false]
end
