module ApplicationHelper

  def convert_to_fahrenheit(kelvin)
    fahrenheit = (kelvin * (9.0 / 5.0)) - 459.67
    return fahrenheit.round
  end
end
