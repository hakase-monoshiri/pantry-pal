require "open-uri"
require 'net/http'
require 'json'

class RecipeImporter

@@app_id = "5bdd8311"
@@app_key = "3b3ec8a2fd0299ae1205afac4d8f6fee"

    def search_by_user
        puts "What would you like to search for?"
        query = gets.chomp.gsub(/\s+/,"-")

        url = "https://api.edamam.com/search?q=#{query}&app_id=#{@@app_id}&app_key=#{@@app_key}"

        uri = URI.parse(url)


        response = Net::HTTP.get_response(uri)

        cat = JSON.parse(response.body)

        puts cat

        # recipe name = cat["hits"].first["recipe"]["label"]
        # ingredient list simple = cat["hits"].first["recipe"]["ingredientLines"]
        # ingredient list with ingredients as obj cat["hits"].first["recipe"]["ingredientLines"]
        # cook time = cat["hits"].first["recipe"]["totalTime"]
        # dietary restrictions info = cat["hits"].first["recipe"]["healthLabels"]
        # link to recipe = cat["hits"].first["recipe"]["url"]


    end

    def search_by_pantry
        
    end



end

RecipeImporter.new.search