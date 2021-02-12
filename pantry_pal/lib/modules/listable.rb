module Listable
  
  module ClassMethods

    def list(parameter)
      if self.all.empty?
        puts "0. There aren't any #{self.name}(s)!"
      else
        self.all.each do |instance|
          puts "#{self.all.index(instance) + 1}. #{instance.send(parameter)}"
        end
      end
    end

  end

  module InstanceMethods

    def list_items(items)
      if self.send(items).empty?
        puts "0. There aren't any #{items.to_s}(s)! "
      else
        self.send(items).each do |item|
          puts item
        end
      end
    end

    def save
      self.class.all << self
      self
    end

    def remove
      self.class.all.delete(self)
    end

  end



end
