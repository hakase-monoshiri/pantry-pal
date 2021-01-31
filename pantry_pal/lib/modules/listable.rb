module Listable

  def list
    self.class.all do |instance|
      i = 1
      puts "#{i} #{instance.name}"
      i += 1
    end
  end


end
