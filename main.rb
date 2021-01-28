require "open-uri"
require 'net/http'


app_id = "5bdd8311"

app_key = "3b3ec8a2fd0299ae1205afac4d8f6fee"

query = "chicken"

url = "https://api.edamam.com/search?q=#{query}&app_id=#{app_id}&app_key=#{app_key}"

uri = URI.parse(url)

response = Net::HTTP.get_response(uri)

puts response.body