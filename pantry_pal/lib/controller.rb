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
    @pantry = Pantry.all[selection - 1]
  end

end
