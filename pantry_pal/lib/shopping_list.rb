class ShoppingList

    include Listable::InstanceMethods
    extend Listable::ClassMethods

    @@all = []

    attr_reader :controller, :ingredients

    def initialize(controller)
        @controller = controller
        @indredients = []
    end

    def all
        @@all
    end

    def add_ingredients_from_recipe(recipe)
        ingredient_array =  recipe.ingredientLines.split(", ")
        self.ingedienst << ingredient_array
    end

    def add_to_list(ingredient)
        self.indredients << ingredient
    end

    def list_ingredients
        list_items(indredients)
    end


end
