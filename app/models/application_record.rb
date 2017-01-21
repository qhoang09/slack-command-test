class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
class Weather

  attr_reader :zip

  def initialize(zip)
    @zip = zip
  end

  def city
    data["full"]
  end

  def temperature
    data["temperature_string"]
  end

  def icon_url
    data["icon_url"]
  end


  private

    def data
      @data ||= HTTParty.get("http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/conditions/q/#{zip}.json")["current_observation"]["display_location"]
    end
end