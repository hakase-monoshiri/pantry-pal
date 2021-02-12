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
        end
    end

    def add_to_list(ingredient)
        self.ingredients << ingredient
    end

    def list_ingredients
        list_items("ingredients")
    end


end
