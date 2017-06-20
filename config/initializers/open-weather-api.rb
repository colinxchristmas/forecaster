# Open Weather Initializer

OpenWeatherAPI.configure do |config|
  config.api_key = ENV['OPEN_WEATHER_KEY']
  # Change default_units to 'metric' for Celsius or remove for Kelvin.
  config.default_units = 'imperial'
end
