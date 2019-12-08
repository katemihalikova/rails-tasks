class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true, counter_cache: true
  has_and_belongs_to_many :tags

  validates_presence_of :title
  validates_presence_of :user
  validates_inclusion_of :is_done, in: [true, false]
end
