class Controller

  attr_accessor :pantry

  def list_pantries
    Pantry.list
  end

  def initialize
    puts "Please select a pantry using the pantry number"
    list_pantries
    puts "...or enter 'new' to create a new one!"
    selection = gets.chomp.to_i
      if selection = "new"
        @pantry = Pantry.create
      else
        @pantry = Pantry.all[selection - 1]
      end
  
  end

  def recipe_search
    recipe_importer = RecipeImporter.new
    puts "Time to search for a new recipe!"
    puts "Type '1' to manually search for recipes."
    puts "Type '2' to find recipies based onn what's in your pantry."
    input = gets.chomp
    case input
      when "1"
        recipe_importer.search_by_user
      when "2"
        recipe_importer.search_by_pantry
      else
        puts "That is not a valid selection"
    end
  end



end
