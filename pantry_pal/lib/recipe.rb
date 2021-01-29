class Recipe

    @@all = []
    

    # Adding all the attributes from the API recipe result, even though we won't use all of them
    # This is to make importing easier, and keep the code from breaking if the API changes

    #In case of API changes...
    # recipe name ==  #label
    # ingredient list == "ingredientLines"
    # ingredient list with ingredients as objects == "ingredients"
    # cook time = "totalTime"
    # dietary restrictions info = "healthLabels"
    # link to recipe = "url"

    def initialize(attributes)
        attributes.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
    end
        
    def save
        @@all << self
    end
    

    def self.new_by_user
        puts "What is the name of the Recipe?"
        name = gets.chomp
        puts "What are the ingredients? (Please enter as a comma separated list)"
        ingredient_list = gets.chomp
        puts "Do you want to add any dietary information? y/n?"
        response = gets.chomp
            if response == "y"
                puts "Please enter dietary info"
                dietary = gets.chomp
            end
        puts "Do you want to add a cook time? y/n?"
        response_2 = gets.chomp
            if response_2 == /y\S*/
                puts "Please enter cook time"
                cook_time = gets.chomp
            end
        puts "Do you want to add a link to the recipe? y/n?"
        response_3 = gets.chomp
            if response_3 == "y"
                puts "Please enter the full url link for this recipe"
                link = gets.chomp
            end

        attributes = {label: name, ingredientLines: ingredient_list} 
            if dietary
                attributes[:healthLabels] = dietary
            end
            if cook_time 
            attributes[:totalTime] = cook_time
            end
            if link
            attributes[:url] = link
            end

        new_recipe = Recipe.new(attributes)
        new_recipe.save
    end







end