class Pantry

  extend Listable::ClassMethods
  include Listable::InstanceMethods

  @@all = []

  attr_accessor :ingredients, :name

    #ingredients should be an array containing ingredient objects
    #name is the name of the Pantry, to allow for multiple pantries/users

  def initialize(name)
    @name = name
    @ingredients = []
  end

  def change_name_by_user
    puts "What should the pantry name be?"
    self.name = gets.chomp
    puts "the new name is #{self.name}"
  end
  

  def add(ingredients)
    self.ingredients << ingredients
  end
  
  def import_ingredients(comma_separated_list)
    ingredient_list = comma_separated_list.split(", ")
    ingredient_list.each do |ingredient|
    end
  end

  def remove_ingredient(ingredient)
    if self.ingredients.include?(ingredient)
      self.ingredients.delete(ingredient)
      puts "removed #{ingredient.to_s}"
    else
      puts "#{ingredient.to_s} was not in your pantry."
    end
  end

  def add_ingredients_by_user
    puts "What ingredients would you like to add?"
    puts "(add ingredients as a comma separated list)"
    input = gets.chomp
    self.add(input.split(", "))
  end

  def remove_ingredients_by_user
    puts "What ingredients would you like to remove?"
    puts "remove ingredients as a comma separated list"
    input = gets.chomp.split(", ")
    input.each {|ingredient| self.remove(ingredient)}
  end

  def empty
    self.ingredients.clear
  end

  def self.all
    @@all
  end

  def list_ingredients
    list_items("ingredients")
  end


  def self.create(name)
    new_pantry = Pantry.new(name)
    new_pantry.save
    new_pantry
  end
  


end