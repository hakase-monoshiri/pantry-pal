require "open-uri"
require 'net/http'
require 'json'

class RecipeImporter

@@app_id = "5bdd8311"
@@app_key = "3b3ec8a2fd0299ae1205afac4d8f6fee"

URL = "https://api.edamam.com/"

attr_accessor :pantry, :results

    def initialize(pantry)
        @pantry = pantry
    end


    def search
        url = URL + "search?q=#{query}&app_id=#{@@app_id}&app_key=#{@@app_key}"

        uri = URI.parse(url)

        response = Net::HTTP.get_response(uri)

        json_object = JSON.parse(response.body)

        self.results = json_object["hits"]
    end

    def list_results
        self.results.each do |result|
           puts result["recipe"]["label"]
           puts "Ingredients: #{result["recipe"]["ingredientLines"]}"
           puts "Dietary notes: #{result["recipe"]["healthLabels"]}"
           puts "Cook time: #{result["recipe"]["totalTime"]}"
           puts " for more information such as cooking directions and notes, look at the recipe online at #{result["recipe"]["url"]}"
           puts "--------------------"
        end
           




    def search_by_user
        puts "What would you like to search for?"
        query = gets.chomp.gsub(/\s+/,"-")
        search
    end



        # recipe name =["hits"].first["recipe"]["label"]
        # ingredient list simple =["hits"].first["recipe"]["ingredientLines"]
        # ingredient list with ingredients as obj["hits"].first["recipe"]["ingredientLines"]
        # cook time =["hits"].first["recipe"]["totalTime"]
        # dietary restrictions info =["hits"].first["recipe"]["healthLabels"]
        # link to recipe =["hits"].first["recipe"]["url"]

    def search_by_pantry
        query = pantry.ingredients.to_s
        search
    end

    end



end

RecipeImporter.new.search