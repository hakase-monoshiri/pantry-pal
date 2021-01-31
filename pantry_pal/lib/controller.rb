class Controller

  attr_accessor :pantry

  def list_pantries
    Pantry.list
  end

  def initialize
    puts "Please select a pantry"
    list pantries
    selection = gets.chomp.to_i
    @pantry = Pantry.all[selection - 1]
  end

end
