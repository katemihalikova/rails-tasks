class TagsTask < ApplicationRecord
  belongs_to :task
  belongs_to :tag, counter_cache: :tasks_count
end
