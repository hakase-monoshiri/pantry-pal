module Listable
  
  module ClassMethods

    def list
      self.all do |instance|
        puts instance
      end
    end

  end

  module InstanceMethods
    def list_items
    end
  end



end
