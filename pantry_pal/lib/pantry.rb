class Pantry

    attr_accessor :ingredients, :name

    #ingredients should be an array containing ingredient objects
    #name is the name of the Pantry, to allow for multiple pantries/users


    def add(ingredient)
        ingredients << ingredient_array
    end
    
    def remove(indredient)
        if self.ingredients.include?(ingredient)
            self.ingredients.delete(ingredient)
        else
            puts "That item is not in your pantry."
        end
    end

    def empty
        self.ingredients.clear
    end

    


end