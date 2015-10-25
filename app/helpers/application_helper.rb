module ApplicationHelper
  def comment_time(datetime)
    datetime.strftime("%d %B %Y, %H:%M")
  end
end
