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


    def search(query)
        url = URL + "search?q=#{query}&app_id=#{@@app_id}&app_key=#{@@app_key}"

        uri = URI.parse(url)

        response = Net::HTTP.get_response(uri)

        json_object = JSON.parse(response.body)

        self.results = json_object["hits"].uniq
    end

    def save_recipe(recipe_number)
        interesting_recipe = self.results[recipe_number.to_i - 1]
        recipe_hash = interesting_recipe["recipe"]
        new_recipe = Recipe.new(recipe_hash)
        new_recipe.save
        puts new_recipe.label

    end



    def list_results
        self.results.each do |result|
           puts "#{self.results.index(result) + 1}. #{result["recipe"]["label"]}"
           puts "Ingredients: #{result["recipe"]["ingredientLines"]}"
           puts "Dietary notes: #{result["recipe"]["healthLabels"]}"
           puts "Cook time: #{result["recipe"]["totalTime"]}"
           puts " for more information such as cooking directions and notes, look at the recipe online at #{result["recipe"]["url"]}"
           puts "--------------------"
        end
        
    end
           




    def search_by_user
        puts "What would you like to search for?"
        query = gets.chomp.gsub(/\s+/,"-")
        search(query)
        list_results
        puts "Which  would you like to save?"
        puts "...or type 'back' to search again"
        number = gets.chomp
        if number == "back"
            search_by_user
        else
            save_recipe(number)
        end
    end


    def search_by_pantry(pantry)
      ingredients = pantry.ingredients





        # recipe name =["hits"].first["recipe"]["label"]
        # ingredient list simple =["hits"].first["recipe"]["ingredientLines"]
        # ingredient list with ingredients as obj["hits"].first["recipe"]["ingredientLines"]
        # cook time =["hits"].first["recipe"]["totalTime"]
        # dietary restrictions info =["hits"].first["recipe"]["healthLabels"]
        # link to recipe =["hits"].first["recipe"]["url"]
    end





end