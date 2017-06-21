module ApplicationHelper

  def convert_to_fahrenheit(kelvin)
    fahrenheit = (kelvin * (9.0 / 5.0)) - 459.67
    return fahrenheit.round
  end

  def clean_hash_string(dirty_hash)
    @clean_weather = JSON.parse(dirty_hash.gsub('=>', ':'), object_class: OpenStruct)
  end
end
