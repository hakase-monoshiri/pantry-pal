class Recipe

    @@all = []

    
    def initialize(attributes)
        attributes.each do |key, value| 
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
    end
        
    def save
        @@all << self
    end
    

    def new_by_user
        puts "What is the name of the Recipe?"


end