module Listable
  
  module ClassMethods

    def list
      self.all.each do |instance|
        puts instance
      end
    end

  end

  module InstanceMethods
    def list_items(items)
      self.items.each do |item|
        puts item
      end
    end
  end



end
