require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'astroid_api_service'

class AstroidApiServiceTest < Minitest::Test
  def test_fetch_data
    results =  AstroidApiService.fetch_data('2019-03-30')

    assert_equal Faraday::Connection, results.class
    assert_equal "2019-03-30", results.params["start_date"]
  end

  def test_asteroids_list_data
    results =  AstroidApiService.asteroids_list_data('2019-03-30')

    assert_equal Faraday::Response, results.class
    assert_equal 200, results.env.status
  end

  def test_parse_data
    results =  AstroidApiService.parse_data('2019-03-30')

    assert_equal Array, results.class
    assert_equal "3561029", results.first[:neo_reference_id]
    assert_equal String, results.first[:name].class
  end

  def test_largest_astroid
    results = AstroidApiService.largest_astroid('2019-03-30')

    assert_equal 537, results
  end

  def test_total_number_of_astroids
    results = AstroidApiService.total_number_of_astroids('2019-03-30')

    assert_equal 10, results
  end

  def test_asteroid_data
    results = AstroidApiService.astroid_data('2019-03-30')

    assert_equal "35542652 miles", results.first[:miss_distance]
    assert_equal "(2019 UZ)", results.last[:name]
  end

  def test_a_date_returns_a_list_of_neos
    results = AstroidApiService.get_neos('2019-03-30')

    assert_equal '(2011 GE3)', results[:astroid_list][0][:name]
  end
end
