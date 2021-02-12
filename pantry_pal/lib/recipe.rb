class Recipe

    extend Listable::ClassMethods
    include Listable::InstanceMethods

    @@all = []
    

    # Adding all the attributes from the API recipe result, even though we won't use all of them
    # This is to make importing easier, and keep the code from breaking if the API changes

    #In case of API changes...
    # recipe name ==  label
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

    def self.all
        @@all
    end
    


end