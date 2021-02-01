class Pantry

  extend Listable::ClassMethods

  @@all = []

  attr_accessor :ingredients, :name

    #ingredients should be an array containing ingredient objects
    #name is the name of the Pantry, to allow for multiple pantries/users

  def initialize(name)
    @name = name
  end

  def change_name_by_user
    puts "What should the pantry name be?"
    self.name = gets.chomp
    puts "the new name is #{self.name}"
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

  def add_ingredients_by_user
    puts "What ingredients woulde you like to add?"
  end

  def remove_ingredients_by_user
    puts "what ingredients would you like to remove?"
  end

  def empty
    self.ingredients.clear
  end

  def self.all
    @@all
  end

  def self.list
    self.all.each do |instance|
      puts "#{self.all.index(instance) + 1}. #{instance.name}"
    end
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_pantry = Pantry.new(name)
    new_pantry.save
    new_pantry
  end
  


end