class WeatherController < ApplicationController

  def index

    @weather = cookies[['_forecaster_', "95762"].join('')]
    unless @weather.nil?
      @clean_weather = clean_hash_string(@weather)
    end
  end

  def new
  end

  def show
  end

  def create
    debugger
    cookie_check = cookies[['_forecaster_', params[:zipcode]].join('')].to_s.to_sym
    if cookie_check.present?
      # @weather = cookie_check
      @clean_weather = clean_hash_string(cookie_check.to_s)
      flash[:alert] = "You are pulling from a cached cookie."
      render :show
    else
      @weather = check_weather
      if @weather.blank? || weather_params[:zipcode].empty? #fix this at a later date but it's functional at the moment.
        flash[:alert] = "There was a problem with your zipcode, please try again."
        redirect_to new_weather_path
      else
        # debugger
        # @weather = check_weather
        set_session(@weather)
        @clean_weather = clean_hash_string(@weather.to_s)
        render :show
      end
    end
  end

  private

  def weather_params
    params.permit(:zipcode)
  end

  def check_weather
    # CheckWeather.new({zipcode: params[:zipcode], country_code: 'us'}).call
    CheckWeather.new({zipcode: params[:zipcode]}).call
  end

  def set_session(weather)
    cookies[['_forecaster_', params[:zipcode]].join('')].to_s.to_sym
    # base_cookie = '_forecaster_'
    weather_group = {value: weather, expires: 30.minutes.from_now}
    cookies[['_forecaster_', params[:zipcode]].join('')] = weather_group
    @weather = cookies[['_forecaster_', params[:zipcode]].join('')]
    return @weather
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

  def build_params(parameters={})
    {
      zip: parameters[:zipcode],
      APPID: ENV['OPEN_WEATHER_KEY'],
      lang: 'en',
      units: 'imperial'
    }
  end

  def search_url(type, params)
    search_url = base_url + base_params(type) + build_params(params).to_query
    url = search_url
    uri = URI(url)
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)

    if parsed_response['cod'] == 200
      parsed_response
    else
      err = parsed_response['cod']
      flash[:alert] = "#{err} There was a problem with your zipcode, please try again."
    end
  end

  def clean_hash_string(dirty_hash)
    @clean_weather = JSON.parse(dirty_hash.gsub('=>', ':'), object_class: OpenStruct)
  end
end
