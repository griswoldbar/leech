module Leech
  module Student
    attr_accessor :method_register
    attr_accessor :surrogate_register
    
    def self.extended(base)
      base.surrogate_register = {}
      base.method_register = {}
    end
    
    def add_method(method, victim)
      lots of scenarios here...
      what if i grab a surrogate from a victim, and i already have a ref to that victim from another method?
      # surrogate = if victim.respond_to?(method)
      #   (self.surrogate_register[victim.object_id] ||= Surrogate.new(self, victim))
      # elsif victim.registered?
      #   victim.get_surrogate(method)
      # end
      # 
      # if surrogate
      #   surrogate.copy_methods
      #   self.method_register[method] = victim.object_id
      # else
      #   raise "method not found on victim"
      # end
    end
    
    def method_missing(method, *args)
      if surrogate = get_surrogate(method)
        surrogate.send(method, *args)
      else
        super(*args)
      end
    end
    
    private
    def get_surrogate(method)
      surrogate_register[method_register[method]]
    end
    
    def registered?
      true
    end
  end
end