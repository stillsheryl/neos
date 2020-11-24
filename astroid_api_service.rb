require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class AstroidApiService

  def self.fetch_data(date)
    Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
  end

  def self.asteroids_list_data(date)
    fetch_data(date).get('/neo/rest/v1/feed')
  end

  def self.parse_data(date)
    JSON.parse(asteroids_list_data(date).body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def self.largest_astroid(date)
    astroids = parse_data(date)
    astroids.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def self.total_number_of_astroids(date)
    parse_data(date).count
  end

  def self.astroid_data(date)
    astroids = parse_data(date)
    astroids.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def self.get_neos(date)
    {
      astroid_list: astroid_data(date),
      biggest_astroid: largest_astroid(date),
      total_number_of_astroids: total_number_of_astroids(date)
    }
  end
end
