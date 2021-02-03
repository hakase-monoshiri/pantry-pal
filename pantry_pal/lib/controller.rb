class Controller

  attr_accessor :pantry, :importer, :shopping_list, :recipe

  def list_pantries
    Pantry.list("name")
  end

  def initialize
    @shopping_list = ShoppingList.new(self)
    choose_pantry
  end

  def choose_pantry
    puts "--------------------"
    puts "Please select a pantry using the pantry number"
    list_pantries
    puts "...or enter 'new' to create a new one!"
    selection = gets.chomp
      if selection == "new"
        puts "Please make a name for your new pantry"
        name = gets.chomp
        self.pantry = Pantry.create(name)
      elsif selection.to_i >0 && selection.to_i <= Pantry.all.size
        self.pantry = Pantry.all[selection.to_i - 1]
      else
        puts "That is not a valid selection, please try again"
        choose_pantry
      end
      puts "You are now using #{self.pantry.name}"
  end

  def manage_pantry
    puts "---------------------"
    puts "What would you like to do?"
    puts "1. Change pantry name"
    puts "2. List items in pantry"
    puts "3. Add indredients to pantry"
    puts "4. Remove ingredients from pantry"
    puts "...or type 'back' or 'exit' to return to the main menu."
    input = gets.chomp
    case input
    when "1"
      self.pantry.change_name_by_user
      manage_pantry
    when "2"
      self.pantry.list_ingredients
      manage_pantry
    when "3"
      self.pantry.add_ingredients_by_user
      manage_pantry
    when "4"
      self.pantry.remove_ingredients_by_user
      manage_pantry
    when "back" 
      user_prompt
    when "exit"
      user_prompt
    else
      manage_pantry
    end
  end


  def import_greeting
    self.importer = RecipeImporter.new(self)
    puts "Time to search for a new recipe!"
  end


  def recipe_search
    puts "Type '1' to manually search for recipes."
    puts "Type '2' to find recipies based on what's in your pantry. (randomly picks ingredients and finds recipies)"
    input = gets.chomp
    case input
      when "1"
        self.importer.search_by_user
        self.importer.ask_user_to_save
      when "2"
        self.importer.search_by_pantry
      else
        puts "That is not a valid selection"
        recipe_search
    end
  end 

  def goodbye
    puts "Thank you for using Pantry Pal!"
    exit
  end

  def manage_shopping_list
    puts "--------------------"
    puts "What would you like to do with your shopping list?"
    puts "1. Create a new shopping list"
    puts "2. Import recipe ingredients to a shopping list"
    puts "3.  "
    puts "...or type 'back' to return to the main menu"
    input = gets.chomp
    case input

  end

  def manage_recipes
    puts "--------------------"
    puts "What would you like to do with your recipes?"
    puts "1. Create a new recipie"
    puts "2. View saved recipes"
    puts "3. Delete a recipe"
    puts "...or type 'back' to return to the main menu"
    input = gets.chomp
    case input
    when "1"
      Recipe.new_by_user
      manage_recipes
    when "2"
      Recipe.list("label")
      manage_recipes
    when "3"
      puts "Which recipe number would you like to remove?"
      Recipe.list("label")
      input = gets.chomp
      this_recipe = Recipe.all[input.to_i - 1]
      this_recipe.remove
    when "back"
      user_prompt
    else
      puts "that is not a valid selection"
      manage_recipes
    end
  end



  def user_prompt
    puts "--------------------"
    puts "What would you like to do next?"
    puts "1. Search for a recipe."
    puts "2. Manage your recipes"
    puts "3. Manage your pantry."
    puts "4. Change pantry"
    puts "5. Manage your shopping list"
    puts "...or type 'exit' to leave the app."
    input = gets.chomp
    case input
      when "1"
        import_greeting
        recipe_search
        user_prompt
      when "2"
        manage_recipes
        user_prompt
      when "3"
        manage_pantry
        user_prompt
      when "4"
        choose_pantry
        user_prompt
      when "5"
        manage_shopping_list
        user_prompt
      when "exit"
        goodbye
      else 
        puts "that is not a valid selection"
        user_prompt
    end
  end


end
