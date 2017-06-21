class WeatherController < ApplicationController

  def index
  end

  def new
  end

  def show
  end

  def create
    # check if cookie exists before running a new api call.
    cookie_check = cookies[['_forecaster_', params[:zipcode]].join('')].to_s.to_sym
    if cookie_check.present?
      # cookie check hash must be a string to convert to OpenStruct
      @clean_weather = clean_hash_string(cookie_check.to_s)
      flash.now[:notice] = "You are pulling from a cached cookie."
      render :show
    else
      @weather = check_weather
      if @weather.blank? || weather_params[:zipcode].empty?  #fix this at a later date but it's functional at the moment.
        flash[:notice] = "There was a problem with your zipcode, please try again."
        redirect_to new_weather_path
      else
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
    CheckWeather.new({zipcode: params[:zipcode]}).call
  end

  def set_session(weather)
    # set cookie with zipcode as a string.
    cookies[['_forecaster_', params[:zipcode]].join('')].to_s.to_sym
    # build value and expires hash and add to cookies
    weather_group = {value: weather, expires: 30.minutes.from_now}
    cookies[['_forecaster_', params[:zipcode]].join('')] = weather_group
    # set and return weather object
    @weather = cookies[['_forecaster_', params[:zipcode]].join('')]
    return @weather
  end

  def clean_hash_string(dirty_hash)
    clean_weather = JSON.parse(dirty_hash.gsub('=>', ':'), object_class: OpenStruct)
  end
end
