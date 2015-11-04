module ApplicationHelper
  def comment_time(datetime)
    datetime.strftime("%d %B %Y, %H:%M")
  end

  def external_url(url)
    URI.parse(url).host
  end

  def price(value)
    (value / 1000000).round(2)
  end
end
