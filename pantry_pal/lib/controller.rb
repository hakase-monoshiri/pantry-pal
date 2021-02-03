class Controller

  attr_accessor :pantry, :importer, :shopping_list, :recipe


  def initialize
    @shopping_list = ShoppingList.new(self)
    choose_pantry
  end

  def choose_pantry
  puts "--------------------"
  puts "Please select a pantry using the pantry number"
    Pantry.list("name")
  puts "...or enter 'new' to create a new one!"
  selection = gets.chomp
    if selection == "new"
      puts "Please make a name for your new pantry"
      name = gets.chomp
      self.pantry = Pantry.create(name)
      puts "you are now using #{self.pantry.name}"
    elsif selection.to_i >0 && selection.to_i <= Pantry.all.size
      self.pantry = Pantry.all[selection.to_i - 1]
    else
      puts "That is not a valid selection, please try again"
      choose_pantry5
    end
  end


  def swicth_remove_pantry
    puts "Do you want to use this pantry? or delete it? [y/n]"
    puts "1. Use this pantry"
    puts "2. Delete this pantry (no undo)"
    input = gets.chomp
    case input
    when "1"
      puts "you are now using #{self.pantry.name}"
      user_prompt
    when "2"
      puts "#{self.pantry.name} has been deleted"
      self.pantry.remove
      choose_pantry
    else
      puts "that is not a valid selection"
      choose_pantry
    end
  end

      
      


  def manage_pantry
    puts "---------------------"
    puts "What would you like to do?"
    puts "1. Change pantry name"
    puts "2. List items in pantry"
    puts "3. Add indredients to pantry"
    puts "4. Remove ingredients from pantry"
    puts "5. Delete or swap pantries"
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
    when "5"
      swicth_remove_pantry
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
    puts "1. View your shopping list"
    puts "2. Create a new shopping list"
    puts "3. Import recipe ingredients to a shopping list"
    puts "4. Remove or Switch Shopping lists"
    puts "...or type 'back' to return to the main menu"
    input = gets.chomp
    case input
    when "back"
      user_prompt
    when "1"
      self.shopping_list.list_ingredients
      manage_shopping_list
    when "2"
      self.shopping_list = ShoppingList.new_by_user(self)
      manage_shopping_list
    when "3"
      self.shopping_list.add_ingredients_from_recipe
      self.shopping_list.list_ingredients
      manage_shopping_list
    when "4"
      swicth_remove_shopping_list
      manage_shopping_list
    else
      puts "that is not a valid selection"
      manage_shopping_list
    end
  end

  def swicth_remove_shopping_list
    puts "Do you want to use this shopping list? or delete it? [y/n]"
    puts "1. Use this shopping list"
    puts "2. Delete this shopping list (no undo)"
    input = gets.chomp
    case input
    when "1"
      puts "you are now using #{self.shopping_list.name}"
      user_prompt
    when "2"
      puts "#{self.shopping_list.name} has been deleted"
      self.shopping_list.remove
      choose_shopping_list
    else
      puts "that is not a valid selection"
      choose_shopping_list
    end
  end

  def choose_shopping_list
  puts "--------------------"
  puts "Please select a shopping list using the list number"
    ShoppingList.list("name")
  puts "...or enter 'new' to create a new one!"
  selection = gets.chomp
    if selection == "new"
      self.shopping_list = ShoppingList.new_by_user(self)
      manage_shopping_list
    elsif selection.to_i >0 && selection.to_i <= ShoppingList.all.size
      self.shopping_list = ShoppingList.all[selection.to_i - 1]
    else
      puts "That is not a valid selection, please try again"
      choose_shopping_list
    end
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
