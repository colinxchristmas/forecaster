class WeatherController < ApplicationController

  def index
  end

  def new
  end

  def show
  end

  def create
    if weather_params[:zipcode].empty? #fix this at a later date but it's functional at the moment.
      flash[:alert] = "Zipcode can't be empty"
      redirect_to new_weather_path
    else
      @weather = check_weather
      render :show
    end
  end

  private

  def weather_params
    params.permit(:zipcode)
  end

  def check_weather
    CheckWeather.new({zipcode: params[:zipcode], country_code: 'us'}).call
  end
end
