module TasksHelper
  def task_list_rows(task)
    if task.category && task.tags.any?
      2
    else
      1
    end
  end
end
