# Open Weather Initializer

OpenWeatherAPI.configure do |config|
  config.api_key = ENV['OPEN_WEATHER_KEY']
  # default_units is non functional only returns Kelvin
  # Conversion is done in application_helper convert_to_fahrenheit()
  config.default_units = 'imperial'
end
