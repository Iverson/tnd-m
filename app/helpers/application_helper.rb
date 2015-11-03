module ApplicationHelper
  def comment_time(datetime)
    datetime.strftime("%d %B %Y, %H:%M")
  end

  def external_url(url)
    URI.parse(url).host
  end
end
