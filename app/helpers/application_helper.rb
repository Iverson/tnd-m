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

  def license_available(license)
    if license.available == 2
      return "аналог (#{license.analog})"
    end

    license.available == 1 ? "Есть" : "Нет"
  end

  def beneficiary(b)
    return "-" if b.disclosed.blank?
    b.disclosed ? "Раскрыт" : "Не раскрыт"
  end
end
