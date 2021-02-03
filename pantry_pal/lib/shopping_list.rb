class ShoppingList

    include Listable::InstanceMethods
    extend Listable::ClassMethods

    @@all = []

    attr_reader :controller
    attr_accessor :name, :ingredients

    def initialize(controller)
        @controller = controller
        @ingredients = []
    end

    def self.all
        @@all
    end

    def add_ingredients_from_recipe(recipe)
        ingredient_array =  recipe.ingredientLines
        ingredient_array.each do |ingredient|
            if controller.pantry.ingredients.include?(ingredient) == false
                self.ingredients << ingredient
    end

    def add_to_list(ingredient)
        self.ingredients << ingredient
    end

    def list_ingredients
        list_items("ingredients")
    end

    def self.new_by_user(controller)
        new_list = ShoppingList.new(controller)
        puts "What is the name of the Shopping List?"
        new_list.name = gets.chomp
        puts "What are the ingredients you want to buy? (Please enter as a comma separated list)"
        new_list.ingredients = gets.chomp.split(", ")
        new_list.save
        new_list
    end

end
