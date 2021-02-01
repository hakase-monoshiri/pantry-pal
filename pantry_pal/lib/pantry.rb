class Pantry

  extend Listable

  @@all = []

  attr_accessor :ingredients, :name

    #ingredients should be an array containing ingredient objects
    #name is the name of the Pantry, to allow for multiple pantries/users

  def initialize
    puts "Welcome to your Pantry"
  end


  def add(ingredient)
    self.ingredients << ingredient
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

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create
    new_pantry = Pantry.new
    new_pantry.save
  end
  


end