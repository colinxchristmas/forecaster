class CheckWeather
  def initialize(params)
    @zipcode = params[:zipcode]
    # @country = params[:country] #not in use yet add next
  end

  def call
    begin
      Rails.configuration.open_weather_api.current zipcode: zipcode, country_code: 'us'
    rescue
      false
    end
  end

  private

  attr_reader :zipcode

end
