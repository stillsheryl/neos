require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'astroid_api_service'
require_relative 'astroid_view'

class AstroidViewTest < Minitest::Test
  def test_fetch_astroid_data
    astroids = AstroidApiService.get_neos('2019-03-30')
    view =  AstroidView.new(astroids, '2019-03-30')

    assert_equal 537, view.astroids_data[:biggest_astroid]
  end

  def test_formatted_date
    astroids = AstroidApiService.get_neos('2019-03-30')
    view =  AstroidView.new(astroids, '2019-03-30')

    assert_equal "Saturday Mar 30, 2019", view.formatted_date
  end

  def test_astroid_list
    astroids = AstroidApiService.get_neos('2019-03-30')
    view =  AstroidView.new(astroids, '2019-03-30')

    assert_equal Array, view.astroid_list.class
  end
end
