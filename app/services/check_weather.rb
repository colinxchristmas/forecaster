class CheckWeather
  def initialize(params)
    @zipcode = params[:zipcode]
    @type = 'current'
  end

  def call
    begin
      # debugger
      search_url(type, zipcode)
    rescue
      false
    end
  end

  def base_url
    "http://api.openweathermap.org/data/2.5/"
  end

  def base_params(type)
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
    # parsed_response = JSON.parse(response).with_indifferent_access
    parsed_response = JSON.parse(response)
      if parsed_response['cod'] == 200 || parsed_response['cod'] == '200'
        parsed_response
      else
        parsed_response['cod']
      end
  end

  def setup_indifferent_access(clean_hash)
    clean_hash.default_proc = proc{|h, k| h.key?(k.to_s) ? h[k.to_s] : nil}
    clean_hash.each { |k, v| setup_indifferent_access(v) if v.is_a?(Hash) }
  end

  private

  attr_reader :zipcode, :type

end
