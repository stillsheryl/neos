require 'faraday'
require 'figaro'
require 'pry'

require_relative 'astroid_api_service'
require_relative 'astroid_view'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp

astroids = AstroidApiService.get_neos(date)

AstroidView.new(astroids, date).display
