require "open-uri"
require 'net/http'
require 'json'

require_relative "../config/api_keys.rb"

# recipe name =["hits"].first["recipe"]["label"]
# ingredient list simple =["hits"].first["recipe"]["ingredientLines"]
# ingredient list with ingredients as obj["hits"].first["recipe"]["ingredientLines"]
# cook time =["hits"].first["recipe"]["totalTime"]
# dietary restrictions info =["hits"].first["recipe"]["healthLabels"]
# link to recipe =["hits"].first["recipe"]["url"]

class RecipeImporter

    @@app_id = ApiKeys.id #if you want to use the seach function, go and get your own key and Id
    @@app_key = ApiKeys.key #mine are hidden in a seperate class


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




end