class Controller

  attr_accessor :pantry, :importer, :shopping_list

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
      choose_pantry
    end
  end


  def switch_remove_pantry
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


  
  def new_recipe_by_user
    puts "What is the name of the Recipe?"
    name = gets.chomp
    puts "What are the ingredients? (Please enter as a comma separated list)"
    ingredient_list = gets.chomp
    puts "Do you want to add any dietary information? y/n?"
    response = gets.chomp
        if /y\S*/ === response
            puts "Please enter dietary info"
            dietary = gets.chomp
        end
    puts "Do you want to add a cook time? y/n?"
    response_2 = gets.chomp
        if /y\S*/ === response_2
            puts "Please enter cook time"
            cook_time = gets.chomp
        end
    puts "Do you want to add a link to the recipe? y/n?"
    response_3 = gets.chomp
        if /y\S*/ === response_3
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
    new_recipe
end


  def import_greeting
    self.importer = RecipeImporter.new(self)
    puts "--------------------"
    puts "Time to search for a new recipe!"
  end


  def recipe_search
    import_greeting
    puts "Type '1' to manually search for recipes."
    puts "Type '2' to find recipies based on what's in your pantry. (randomly picks ingredients and finds recipies)"
    puts "...or type 'back' to return to the recipe manager"
    input = gets.chomp
    case input
      when /1\D*/
        self.importer.search_by_user
        self.importer.ask_user_to_save
      when /2\D*/
        self.importer.search_by_pantry
      when /b\S*/
        manage_recipes
      else
        puts "That is not a valid selection"
        recipe_search
    end
  end 

  def goodbye
    puts "------------------------------"
    puts "Thank you for using Pantry Pal!"
    exit
  end

  def find_or_seacrh_import_r_to_sl
    puts "------------------------------"
    puts "Which recipe number would you like to import?"
    puts "...or type 'search' to find a new one!"
    Recipe.list("label")
    input = gets.chomp
    if input == "search"
      recipe_search
      find_or_seacrh_import_r_to_sl
    elsif input.to_i >0 && input.to_i <= Recipe.all.size
      this_recipe = Recipe.all[input.to_i - 1]
      self.shopping_list.add_ingredients_from_recipe(this_recipe)
      self.shopping_list.list_ingredients
      manage_shopping_list
    else
      puts "that is not a valid selection"
      manage_shopping_list
    end
  end

  def change_name_by_user
    puts "What should the pantry name be?"
    pantry.name = gets.chomp
    puts "the new name is #{pantry.name}"
  end

  def remove_ingredients_by_user
    puts "What ingredients would you like to remove?"
    puts "remove ingredients as a comma separated list"
    input = gets.chomp.split(", ")
    input.map  do |ingredient| 
      removed_ingredient = pantry.remove_ingredient(ingredient)
      if removed_ingredient
        puts "#{removed_ingredient} has been removed"
      else
        puts "That item is not in your pantry!"
      end
    end
  end

  def add_ingredients_by_user
    puts "What ingredients would you like to add?"
    puts "(add ingredients as a comma separated list)"
    input = gets.chomp
    pantry.add(input.split(", "))
  end

  def manage_pantry
    puts "------------------------------"
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
      change_name_by_user
      manage_pantry
    when "2"
      self.pantry.list_ingredients
      manage_pantry
    when "3"
      add_ingredients_by_user
      manage_pantry
    when "4"
      remove_ingredients_by_user
      manage_pantry
    when "5"
      switch_remove_pantry
      manage_pantry
    when /b\S*/ 
      user_prompt
    when "exit"
      user_prompt
    else
      manage_pantry
    end
  end
  
  def manage_shopping_list
    puts "------------------------------"
    puts "What would you like to do with your shopping list?"
    puts "1. View your shopping list"
    puts "2. Create a new shopping list"
    puts "3. Import recipe ingredients to a shopping list"
    puts "4. Remove or Switch Shopping lists"
    puts "...or type 'back' to return to the main menu"
    input = gets.chomp
    case input
    when /b\S*/
      user_prompt
    when "1"
      self.shopping_list.list_ingredients
      manage_shopping_list
    when "2"
      self.shopping_list = ShoppingList.new_by_user(self)
      manage_shopping_list
    when "3"
      find_or_seacrh_import_r_to_sl
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
    puts "------------------------------"
    puts "Do you want to use this shopping list? or delete it?"
    puts "1. Use this shopping list"
    puts "2. Switch shopping list"
    puts "3. Delete this shopping list (no undo)"
    input = gets.chomp
    case input
    when "1"
      puts "you are now using #{self.shopping_list.name}"
      user_prompt
    when "2"
      choose_shopping_list
    when "3"
      puts "#{self.shopping_list.name} has been deleted"
      self.shopping_list.remove
      choose_shopping_list
    else
      puts "that is not a valid selection"
      swicth_remove_shopping_listpeanuts
    end
  end

  def choose_shopping_list
  puts "------------------------------"
  puts "Please select a shopping list using the list number"
    ShoppingList.list("name")
  puts "...or enter 'new' to create a new one!"
  selection = gets.chomp
    if selection == "new"
      self.shopping_list = ShoppingList.new_by_user(self)
      manage_shopping_list
    elsif selection.to_i >0 && selection.to_i <= ShoppingList.all.size
      self.shopping_list = ShoppingList.all[selection.to_i - 1]
      puts "you are now using #{self.shopping_list.name}"
    else
      puts "That is not a valid selection, please try again"
      choose_shopping_list
    end
  end


  

  def manage_recipes
    puts "------------------------------"
    puts "What would you like to do with your recipes?"
    puts "1. Create a new recipie"
    puts "2. View saved recipes"
    puts "3. Delete a recipe"
    puts "...or type 'back' to return to the main menu"
    input = gets.chomp
    case input
    when /1\D*/
      recipe_make_controller
      manage_recipes
    when /2\D*/
      Recipe.list("label")
      manage_recipes
    when /3\D*/
      puts "Which recipe number would you like to remove?"
      Recipe.list("label")
      input = gets.chomp
      this_recipe = Recipe.all[input.to_i - 1]
      this_recipe.remove
    when "back"
      user_prompt
    else
      puts "that is not a valid selection."
      manage_recipes
    end
  end

  def recipe_make_controller
    puts "------------------------------"
    puts "Would you like to search, or manually input a recipe?"
    puts "1. Search for a recipe"
    puts "2. Manually make a recipe"
    input = gets.chomp
    case input
    when /1\D*/
      recipe_search
    when /2\D*/
      new_recipe_by_user
    else 
      puts "that is not a valid selection."
    end
  end


  def user_prompt
    puts "------------------------------"
    puts "What would you like to do next?"
    puts "1. Search for a recipe."
    puts "2. Manage your recipes"
    puts "3. Manage your pantry."
    puts "4. Change pantry"
    puts "5. Manage your shopping list"
    puts "...or type 'exit' to leave the app."
    input = gets.chomp
    case input
      when /1\D*/
        recipe_search
        user_prompt
      when /2\D*/
        manage_recipes
        user_prompt
      when /3\D*/
        manage_pantry
        user_prompt
      when /4\D*/
        choose_pantry
        user_prompt
      when /5\D*/
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
