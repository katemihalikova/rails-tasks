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
end
