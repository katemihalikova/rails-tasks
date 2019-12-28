module ApplicationHelper
  def format_datetime(datetime)
    datetime.in_time_zone("Europe/Prague").strftime("%-d. %-m. %Y %-H:%M")
  end

  def format_local_datetime(datetime)
    datetime.strftime("%-d. %-m. %Y %-H:%M")
  end

  def random_color
    "#%06x" % (rand * 0xffffff)
  end

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-danger"
    end
  end
end
