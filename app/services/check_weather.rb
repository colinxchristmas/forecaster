class CheckWeather
  def initialize(params)
    @zipcode = params[:zipcode]
    @type = 'current'
  end

  def call
    begin
      search_url(type, zipcode)
    rescue
      false
    end
  end

  def base_url
    "http://api.openweathermap.org/data/2.5/"
  end

  def base_params(type)
    # future additions to allow different weather query types
    case type
    when 'daily'
      'forecast/daily?'
    when 'hourly'
      'forecast?'
    when 'current'
      'weather?'
    else
      'weather?'
    end
  end

  def build_params(zipcode)
    # default build params
    {
      zip: zipcode,
      APPID: ENV['OPEN_WEATHER_KEY'],
      lang: 'en',
      units: 'imperial'
    }
  end

  def search_url(type, zipcode)
    search_url = base_url + base_params(type) + build_params(zipcode).to_query
    url = search_url
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    # depending on the type of query it can return a string or an integer
    if parsed_response['cod'] == 200 || parsed_response['cod'] == '200'
      parsed_response
    else
      false
    end
  end

  private

  attr_reader :zipcode, :type

end
