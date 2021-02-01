module Listable

  def list
    self.all do |instance|
      i = 1
      puts "#{i}. #{instance.name}"
      i += 1
    end
  end


end
