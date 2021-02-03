require "open-uri"
require 'net/http'
require 'json'

class RecipeImporter

    @@app_id = "5bdd8311"
    @@app_key = "3b3ec8a2fd0299ae1205afac4d8f6fee"


    URL = "https://api.edamam.com/"

    attr_accessor :results
    attr_reader :controller

    def initialize(controller)
        @controller = controller
    end


    def search(query)
        url = URL + "search?q=#{query}&app_id=#{@@app_id}&app_key=#{@@app_key}"

        uri = URI.parse(url)

        response = Net::HTTP.get_response(uri)

        json_object = JSON.parse(response.body)

        self.results = json_object["hits"].uniq
    end

    def save_recipe(recipe_number)
        if recipe_number.to_i <= self.results.size && recipe_number.to_i > 0
            interesting_recipe = self.results[recipe_number.to_i - 1]
            recipe_hash = interesting_recipe["recipe"]
            new_recipe = Recipe.new(recipe_hash)
            new_recipe.save
            puts new_recipe.label
        else
            puts "that is not a valid recipe number, please try again"
        end

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
        puts "...or type 'exit to return to the main menu"
        query = gets.chomp.gsub(/\s+/,"-")
        if query == "exit"
            controller.user_prompt
        else
        search(query)
        list_results
        end
    end

    def ask_user_to_save
        puts "Which  would you like to save?"
        puts "...or type 'back' to search again"
        number = gets.chomp
        if number == "back"
            search_by_user
        else
            save_recipe(number)
        end
    end

    def search_by_pantry
      ingredients = self.controller.pantry.ingredients
      search(ingredients.sample(4).join(" "))
      list_results
      puts "Which  would you like to save?"
      puts "...or type 'back' to return to the main menu "
      number = gets.chomp
      if number == "back"
        puts "returning to main menu"
      else
          save_recipe(number)
      end




        # recipe name =["hits"].first["recipe"]["label"]
        # ingredient list simple =["hits"].first["recipe"]["ingredientLines"]
        # ingredient list with ingredients as obj["hits"].first["recipe"]["ingredientLines"]
        # cook time =["hits"].first["recipe"]["totalTime"]
        # dietary restrictions info =["hits"].first["recipe"]["healthLabels"]
        # link to recipe =["hits"].first["recipe"]["url"]
    end





end