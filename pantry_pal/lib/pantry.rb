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


  def add(ingredients)
    ingredients.each{|ingredient| self.ingredients << ingredient}
  end
  
  def import_ingredients(comma_separated_list)
    ingredient_list = comma_separated_list.split(", ")
    ingredient_list.each do |ingredient|
    end
  end

  def remove_ingredient(ingredient)
    if self.ingredients.include?(ingredient)
      self.ingredients.delete(ingredient)
    end
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