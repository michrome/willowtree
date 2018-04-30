module DateHelpers
  def human_date(date = Date.today)
    date.day.ordinalize + date.strftime(" %B %Y")
  end

  def iso_date(date = Date.today)
    date.strftime("%F")
  end
end
